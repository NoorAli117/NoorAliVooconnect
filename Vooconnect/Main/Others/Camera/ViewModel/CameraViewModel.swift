//
//  CameraViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/12/22.
//

import Foundation

import AVFoundation
// MARK: Camera View Model
class CameraViewModel: NSObject,ObservableObject,AVCaptureFileOutputRecordingDelegate {
    
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCaptureMovieFileOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    // MARK: Video Recorder Properties
    @Published var isRecording: Bool = false
    @Published var recordedURLs: [URL] = []
    @Published var previewURL: URL? = nil
    @Published var showPreview: Bool = false
              
    // Top Progress Bar
    @Published var recordedDuration: CGFloat = 0
    // YOUR OWN TIMING
    @Published var maxDuration: CGFloat = 10
    
    @Published var isBackCamera : Bool = true
    @Published var isBackCameraPhoto : Bool = true
    @Published var songModel : DeezerSongModel? = nil
    @Published var filterData: FilterData? = nil
    @Published var speed : Float = 1
    
    // Video
    func checkPermission(isBackCamera : Bool){

        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp(isFront: isBackCamera)
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                
                if status{
                    self.setUp(isFront: isBackCamera)
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    
    func getFilterData(){
           NetworkManager.makeEndpointCall(fromEndpoint: .getFilterData, withDataType: FilterData.self) { [weak self]  result in
               switch result {
               case .success(let filterRes):
                   self?.filterData = filterRes
                   logger.error("Successfully fetched user stats!!!", category: .profile)
               case .failure(let error):
                   logger.error("Error Fetching User Stats: \(error.localizedDescription)", category: .profile)
               }
           }
       }
    
    //Video with Song
    
    func removeAudioFromVideo(videoURL: URL, completion: @escaping (URL?, Error?) -> Void) {
        let fileManager = FileManager.default
        let composition = AVMutableComposition()

        guard let sourceAsset = AVURLAsset(url: videoURL) as AVAsset? else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid video asset"]))
            return
        }

        guard let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to add video track"]))
            return
        }

        guard let sourceVideoTrack = sourceAsset.tracks(withMediaType: .video).first else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Video track not found"]))
            return
        }

        let timeRange = CMTimeRange(start: .zero, duration: sourceAsset.duration)

        do {
            try compositionVideoTrack.insertTimeRange(timeRange, of: sourceVideoTrack, at: .zero)
        } catch {
            completion(nil, error)
            return
        }

        // Create a layer instruction for the video track
        let videoLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: compositionVideoTrack)

        // Get the track's natural size
        let naturalSize = sourceVideoTrack.naturalSize

        // Check if the video track's dimensions need to be swapped
        let shouldSwapDimensions = needsSwapDimensions(for: sourceVideoTrack.preferredTransform)

        // Swap the dimensions if necessary
        let renderSize: CGSize = shouldSwapDimensions ? CGSize(width: naturalSize.height, height: naturalSize.width) : naturalSize

        // Create a transform to rotate the video
        let transform = sourceVideoTrack.preferredTransform

        // Apply the transform to the layer instruction
        videoLayerInstruction.setTransform(transform, at: .zero)

        let videoCompositionInstruction = AVMutableVideoCompositionInstruction()
        videoCompositionInstruction.timeRange = CMTimeRange(start: .zero, duration: composition.duration)
        videoCompositionInstruction.layerInstructions = [videoLayerInstruction]

        // Create a video composition and set the instructions
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = renderSize
        videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
        videoComposition.instructions = [videoCompositionInstruction]

        // Export the video
        let exportPath = NSTemporaryDirectory().appending("\(Date()).mp4")
        let exportURL = URL(fileURLWithPath: exportPath)

        if fileManager.fileExists(atPath: exportPath) {
            do {
                try fileManager.removeItem(at: exportURL)
            } catch {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to remove existing export file"]))
                return
            }
        }

        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create AVAssetExportSession"]))
            return
        }

        // Set the video composition for the exporter
        exporter.videoComposition = videoComposition

        // Rotate the video track to its original size
        compositionVideoTrack.preferredTransform = transform.inverted()

        exporter.outputURL = exportURL
        exporter.outputFileType = .mp4

        exporter.exportAsynchronously {
            DispatchQueue.main.async {
                if exporter.status == .completed {
                    completion(exportURL, nil)
                } else {
                    completion(nil, exporter.error)
                }
            }
        }
    }

    // Function to check if video track's dimensions need to be swapped
    func needsSwapDimensions(for transform: CGAffineTransform) -> Bool {
        return transform.a == 0 && transform.d == 0 && (transform.b == 1.0 || transform.b == -1.0) && (transform.c == 1.0 || transform.c == -1.0)
    }
    //merge Song with audio
    
    func mergeAudioToVideo(sourceAudioPath: String, sourceVideoPath: String, completion: @escaping (URL?, Error?) -> Void) {
        
        
        let fileManager = FileManager.default
        let composition = AVMutableComposition()
        
        let videoAsset = AVURLAsset(url: URL(fileURLWithPath: sourceVideoPath))
        let audioAsset = AVURLAsset(url: URL(fileURLWithPath: sourceAudioPath))
        
        guard let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid),
              let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else {
            completion(nil, NSError(domain: "AVError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create audio and video tracks."]))
            return
        }
        
        do {
            try audioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration),
                                           of: audioAsset.tracks(withMediaType: .audio)[0],
                                           at: .zero)
            
            try videoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration),
                                           of: videoAsset.tracks(withMediaType: .video)[0],
                                           at: .zero)
        } catch {
            completion(nil, error)
            return
        }
        
        let exportPath = NSTemporaryDirectory().appending("\(Date()).mp4")
        let exportURL = URL(fileURLWithPath: exportPath)
        
        if fileManager.fileExists(atPath: exportPath) {
            do {
                try fileManager.removeItem(at: exportURL)
            } catch {
                completion(nil, error)
                return
            }
        }
        
        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
            completion(nil, NSError(domain: "AVError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create AVAssetExportSession."]))
            return
        }
        
        exporter.outputURL = exportURL
        exporter.outputFileType = .mov
        
        exporter.exportAsynchronously {
            DispatchQueue.main.async {
                if exporter.status == .completed {
                    completion(exportURL, nil)
                } else {
                    completion(nil, exporter.error)
                }
            }
        }
    }
    
    
    
    // Video
    func setUp(isFront : Bool){
        
        do {
            
            self.session.beginConfiguration()
            
            if let inputs = session.inputs as? [AVCaptureDeviceInput] {
                for input in inputs {
                    session.removeInput(input)
                }
            }
            
            let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            let videoInput = try AVCaptureDeviceInput(device: cameraDevice!)
            let audioDevice = AVCaptureDevice.default(for: .audio)
            let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
            
            // MARK: Audio Input
            
            if self.session.canAddInput(videoInput) && self.session.canAddInput(audioInput){
                self.session.addInput(videoInput)
                self.session.addInput(audioInput)
            }
            
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    func switchCamera() {
        session.sessionPreset = AVCaptureSession.Preset.high
        session.beginConfiguration()
        let currentInput = session.inputs.first as? AVCaptureDeviceInput
        session.removeInput(currentInput!)
        let newCameraDevice = currentInput?.device.position == .back ? getCamera(with: .front) : getCamera(with: .back)
        let newVideoInput = try? AVCaptureDeviceInput(device: newCameraDevice!)
        session.addInput(newVideoInput!)
        session.commitConfiguration()
    }

    func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        guard let devices = AVCaptureDevice.devices(for: AVMediaType.video) as? [AVCaptureDevice] else {
            return nil
        }
        
        return devices.filter {
            $0.position == position
            }.first
    }

    
    func startRecording(){
        // MARK: Temporary URL for recording Video
        let tempURL = NSTemporaryDirectory() + "\(Date()).mp4"
        output.startRecording(to: URL(fileURLWithPath: tempURL), recordingDelegate: self)
        print("Start recording")
        if(songModel != nil)
        {
            let _ = SoundsManagerHelper.instance.playAudioFromUrl(url: songModel!.preview)
        }
        recordingStopWatch()
        isRecording = true
    }
    
    func recordingStopWatch(){
        print("Init stopwatch : "+self.maxDuration.description)
        Timer.scheduledTimer(withTimeInterval: self.maxDuration, repeats: false) { (_) in
            print("Stopwatch stop1")
            DispatchQueue.main.async {
                print("Stopwatch stop2")
                self.stopRecording()
            }
        }
    }
    
    func stopRecording(){
        SoundsManagerHelper.instance.pause()
        output.stopRecording()
        isRecording = false
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        // CREATED SUCCESSFULLY
        print(outputFileURL)
        self.recordedURLs.append(outputFileURL)
        if self.recordedURLs.count == 1{
            self.previewURL = outputFileURL
            return
        }
        
        // CONVERTING URLs TO ASSETS
        let assets = recordedURLs.compactMap { url -> AVURLAsset in
            return AVURLAsset(url: url)
        }
        
        self.previewURL = nil
        // MERGING VIDEOS
        mergeVideos(assets: assets) { exporter in
            exporter.exportAsynchronously {
                if exporter.status == .failed{
                    // HANDLE ERROR
                    print(exporter.error!)
                }
                else{
                    if let finalURL = exporter.outputURL{
                        print(finalURL)
                        DispatchQueue.main.async {
                            self.previewURL = finalURL
                        }
                    }
                }
            }
        }
    }
    
    func mergeVideos(assets: [AVURLAsset],completion: @escaping (_ exporter: AVAssetExportSession)->()){
        
        let compostion = AVMutableComposition()
        var lastTime: CMTime = .zero
        
        guard let videoTrack = compostion.addMutableTrack(withMediaType: .video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else{return}
        guard let audioTrack = compostion.addMutableTrack(withMediaType: .audio, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else{return}
        
        for asset in assets {
            // Linking Audio and Video
            do{
                try videoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: asset.tracks(withMediaType: .video)[0], at: lastTime)
                // Safe Check if Video has Audio
                if !asset.tracks(withMediaType: .audio).isEmpty{
                    try audioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: asset.tracks(withMediaType: .audio)[0], at: lastTime)
                }
            }
            catch{
                // HANDLE ERROR
                print(error.localizedDescription)
            }
            
            // Updating Last Time
            lastTime = CMTimeAdd(lastTime, asset.duration)
        }
        
        // MARK: Temp Output URL
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory() + "Reel-\(Date()).mp4")
        
        // VIDEO IS ROTATED
        // BRINGING BACK TO ORIGNINAL TRANSFORM
        
        let layerInstructions = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        
        // MARK: Transform
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: 90 * (.pi / 180))
        transform = transform.translatedBy(x: 0, y: -videoTrack.naturalSize.height)
        layerInstructions.setTransform(transform, at: .zero)
        
        let instructions = AVMutableVideoCompositionInstruction()
        instructions.timeRange = CMTimeRange(start: .zero, duration: lastTime)
        instructions.layerInstructions = [layerInstructions]
        
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize(width: videoTrack.naturalSize.height, height: videoTrack.naturalSize.width)
        videoComposition.instructions = [instructions]
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        
        guard let exporter = AVAssetExportSession(asset: compostion, presetName: AVAssetExportPresetHighestQuality) else{return}
        exporter.outputFileType = .mp4
        exporter.outputURL = tempURL
        exporter.videoComposition = videoComposition
        completion(exporter)
    }
    
    
    
    
}


