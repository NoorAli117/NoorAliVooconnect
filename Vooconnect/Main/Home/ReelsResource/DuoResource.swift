//
//  DuoResource.swift
//  Vooconnect
//
//  Created by Noor on 30/11/2023.
//

import Foundation
import AVFoundation
import Photos
import UIKit


class DuoResource: ObservableObject {
    
    func combineVideosWithAudio(video1URL: URL, video2URL: URL, outputURL: URL, completion: @escaping (Error?) -> Void) { // Create AVAsset for each input video
        let asset1 = AVAsset(url: video1URL)
        let asset2 = AVAsset(url: video2URL)
        // Create composition
        let composition = AVMutableComposition()
        
        // Add video tracks to the composition
        let videoTrack1 = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let videoTrack2 = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        // Add audio tracks to the composition
        let audioTrack1 = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        let audioTrack2 = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        do {
            // Add video tracks to the composition
            try videoTrack1?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: asset1.duration), of: asset1.tracks(withMediaType: .video)[0], at: .zero)
            try videoTrack2?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: asset2.duration), of: asset2.tracks(withMediaType: .video)[0], at: .zero)
            
            // Add audio tracks to the composition
            try audioTrack1?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: asset1.duration), of: asset1.tracks(withMediaType: .audio)[0], at: .zero)
            try audioTrack2?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: asset2.duration), of: asset2.tracks(withMediaType: .audio)[0], at: .zero)
        } catch {
            completion(error)
            return
        }
        
        // Set up video composition instructions
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(start: .zero, duration: CMTimeAdd(asset1.duration, asset2.duration))
        
        // Set up video layer instructions
        let layerInstruction1 = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack1!)
        let layerInstruction2 = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack2!)
        
        // Zoom the second video within its dimensions
        let zoomFactor: CGFloat = 0.7 // Adjust the zoom factor to your liking
        let scaleTransform = CGAffineTransform(scaleX: zoomFactor, y: zoomFactor)
        let translateTransform = CGAffineTransform(translationX: asset1.tracks(withMediaType: .video)[0].naturalSize.width, y: 0)
        
        let combinedTransform = scaleTransform.concatenating(translateTransform)
        layerInstruction2.setTransform(combinedTransform, at: .zero)
        
        // Add instructions to the composition
        instruction.layerInstructions = [layerInstruction1, layerInstruction2]
        
        // Create video composition
        let videoComposition = AVMutableVideoComposition()
        videoComposition.instructions = [instruction]
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        videoComposition.renderSize = CGSize(width: asset1.tracks(withMediaType: .video)[0].naturalSize.width * 2, height: asset1.tracks(withMediaType: .video)[0].naturalSize.height)
        
        // Export the composition to a file
        guard let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
            completion(nil)
            return
        }
        
        exportSession.outputFileType = .mp4
        exportSession.outputURL = outputURL
        exportSession.videoComposition = videoComposition
        
        exportSession.exportAsynchronously {
            completion(exportSession.error)
        }
    }

    func downloadVideo(url: URL, completion: @escaping (URL?) -> Void) {
        print("Video Url: \(url)")
        
        let task = URLSession.shared.downloadTask(with: url) { (tempURL, _, error) in
            if let tempURL = tempURL {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let destinationURL = documentsDirectory.appendingPathComponent("savedVideo\(Date()).mp4")
                
                do {
                    try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                    completion(destinationURL)
                } catch {
                    print("Error moving file: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }


    
    func downloadMusic(url: URL, completion: @escaping (String) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { (location, response, error) in
            if let error = error {
                print("Error downloading audio file: \(error)")
                completion("")
                return
            }
            
            // Get the downloaded audio file URL.
            guard let location = location else {
                print("Could not get downloaded audio file URL.")
                completion("")
                return
            }
            
            do {
                let fileManager = FileManager.default
                let tmpURL = location
                
                // Generate a unique filename
                let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + "_converted.mp3")
                
                // Move the downloaded file to the desired output location
                try fileManager.moveItem(at: tmpURL, to: outputURL)
                
                completion(outputURL.absoluteString)
            } catch let error {
                print("Error moving temporary file: \(error)")
                completion("")
            }
        }
        
        task.resume()
    }


}
