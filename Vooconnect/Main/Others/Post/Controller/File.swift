
import SwiftUI
import Photos
import AVKit

func downloadAncdSaveVideo(){
    let fileName = UserDefaults.standard.string(forKey: "imageName") ?? ""
    let markedVideoURL = URL(string: getImageVideoMarkedBaseURL + fileName)
    let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let destinationUrl = docsUrl?.appendingPathComponent(markedVideoURL?.lastPathComponent ?? "")
    
    if let destinationUrl = destinationUrl {
        if FileManager().fileExists(atPath: destinationUrl.path) {
            print("File already exists")
        } else {
            let urlRequest = URLRequest(url: markedVideoURL!)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    //                                                          self.isDownloading = false
                    return
                }
                
                guard let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    guard let data = data else {
                        //                                                              self.isDownloading = false
                        return
                    }
                    DispatchQueue.main.async {
                        do {
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: destinationUrl)
                            }) { saved, error in
                                if saved {
                                    print("saved")
                                    //
                                }
                            }
                            try data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                            DispatchQueue.main.async {
                                //                                                                      self.isDownloading = false
                            }
                        } catch let error {
                            print("Error decoding: ", error)
                            //                                                                  self.isDownloading = false
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
}
