
import SwiftUI
import Photos
import AVKit
import AVFoundation

func downloadAndSaveWithCaptionVideo(videoUrl: String, completion: @escaping (Bool) -> Void){
    let markedVideoURL = URL(string: getImageVideoBaseURL + "/marked" + videoUrl)
    print(markedVideoURL!)
    let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let destinationUrl = docsUrl?.appendingPathComponent(markedVideoURL?.lastPathComponent ?? "")
    
    if let destinationUrl = destinationUrl {
        if FileManager().fileExists(atPath: destinationUrl.path) {
            print("File already exists")
            try! FileManager().removeItem(atPath: destinationUrl.path)
            saveVideo(url: markedVideoURL!, destiURL: destinationUrl){ success in
                if success == true{
                    completion(true)
                }else{
                    completion(false)
                }
            }
        } else {
            saveVideo(url: markedVideoURL!, destiURL: destinationUrl){ success in
                if success == true{
                    completion(true)
                }else{
                    completion(false)
                }
            }
//            try! FileManager().removeItem(atPath: destinationUrl.path)
        }
    }
}

func saveVideo(url: URL, destiURL: URL, completion: @escaping (Bool) -> Void) {
    let urlRequest = URLRequest(url: url)
    
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
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: destiURL)
                    }) { saved, error in
                        if saved {
                            print("Video saved.....")
                            completion(true)
                            //
                        }else{
                            debugPrint(error as Any)
                            print("erroe:::")
                            completion(false)
                        }
                    }
                    try data.write(to: destiURL, options: Data.WritingOptions.atomic)
                    DispatchQueue.main.async {
                        //                                                                      self.isDownloading = false
                        print("doneeeeee")
                    }
                } catch let error {
                    print("Error decoding: ", error)
                    //                                                                  self.isDownloading = false
                }
            }
        }
        else{
            print("error code is: \(response.statusCode)")
        }
    }
    dataTask.resume()
}
