
import SwiftUI
import Photos
import AVKit

//func downloadVideo() {
//    let videoURLString = "https://vooconnectasset.devssh.xyz/uploads/marked/1685455994937-2023-05-301411220000.mp4"
//        guard let videoURL = URL(string: videoURLString) else {
//            print("Invalid video URL")
//            return
//        }
//
//        let session = URLSession(configuration: .default)
//        let downloadTask = session.downloadTask(with: videoURL) { localURL, _, error in
//            if let error = error {
//                print("Video download failed: \(error.localizedDescription)")
//                return
//            }
//
//            guard let localURL = localURL else {
//                print("Unable to retrieve local URL for downloaded video")
//                return
//            }
//
//            saveVideoToGallery(videoURL: localURL)
//        }
//
//        downloadTask.resume()
//    }
//
//    func saveVideoToGallery(videoURL: URL) {
//        PHPhotoLibrary.requestAuthorization { status in
//            if status == .authorized {
//                PHPhotoLibrary.shared().performChanges({
//                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
//                }) { saved, error in
//                    if saved {
//                        print("Video saved successfully")
//                    } else {
//                        print("Error saving video: \(error?.localizedDescription ?? "")")
//                    }
//                }
//            } else {
//                print("Access to photo library denied")
//            }
//        }
//    }


func downloadVideo() {
    var fileName = UserDefaults.standard.string(forKey: "imageName") ?? ""
//    let fileName1 = fileName.removeFirst()
//    let url = NSURL(string: getImageVideoBaseURL + "/marked" + fileName)!
    let url = URL(string: getImageVideoBaseURL + "/marked" + fileName)!
    print(url)
    let asset = AVAsset(url: url)
    let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!
    exporter.outputFileType = AVFileType.mov
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    let outputPath = documentsPath.appendingPathComponent(fileName)
    exporter.outputURL = URL(fileURLWithPath: outputPath)
    
    
    guard let renderUrl = exporter.outputURL else{
        print("incorrect url, can't save to gallery")
        return
    }
    print("saving to device, url: " + renderUrl.absoluteString)
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: renderUrl)
        }) { complete, error in
            if complete {
                print("Saved to gallery")
            }
        }
}
//exporter.exportAsynchronously(completionHandler: {
//    let activityViewController = UIActivityViewController(activityItems: [exporter.outputURL!], applicationActivities: nil)
//    activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
//        if activityType == .saveToCameraRoll {
//            print("Video saved!")
//        }else {
//            print("saving error \(String(describing: error))" )
//        }
//    }
//    DispatchQueue.main.async {
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let window = windowScene.windows.first {
//            window.rootViewController?.present(activityViewController, animated: true, completion: nil)
//        }
//    }
//})
