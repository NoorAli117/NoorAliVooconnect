//
//  ReelsResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 03/12/22.
//

import Foundation
import SwiftUI
import Combine
import Swinject
import Photos
import Regift

class CreatorImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let allReels: Post
    
    init(creatorImage: Post) {
        self.allReels = creatorImage
        getCreatorImage()
    }
    
    private func getCreatorImage() {
        guard let url = URL(string: getImageVideoBaseURL + (allReels.creatorProfileImage ?? "")) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returendImage) in
                self?.image = returendImage
                self?.imageSubscription?.cancel()
            })
        
    }
    
}


class ProfileImageService: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    private var appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!
    private var userAuthenticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    
    @Published var image: UIImage? = nil
    
    init() {
        getCreatorImage()
        updateProfileImageObserver()
    }
    
    var profileImage: String{
        return userAuthenticationManager.userDetail?.profileImage ?? ""
    }
    
    private func getCreatorImage() {
        guard let url = URL(string: getImageVideoBaseURL + profileImage) else { return }
        
        NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returendImage) in
                self?.image = returendImage!
            })
            .store(in: &cancellable)
        
    }
    
    // Update the Profile Image when user update it from profile
    private func updateProfileImageObserver(){
        appEventsManager.updateProfileImage
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] type in
                getCreatorImage()
            })
            .store(in: &cancellable)
    }
    
}


class VideoDownloader: ObservableObject {
    
    @Published var downloadGifProgress: Double = 0.0
    @Published var downloadProgress: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    func downloadVideo(url: URL, completion: @escaping (Bool) -> Void) {
        print("Video Url: \(url)")
        let task = URLSession.shared.downloadTask(with: url) { (tempURL, _, error) in
            if let tempURL = tempURL {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let destinationURL = documentsDirectory.appendingPathComponent("\(Date().timeIntervalSince1970).mp4")
                
                try? FileManager.default.moveItem(at: tempURL, to: destinationURL)
                
                // Save the video to the Photos library
                PHPhotoLibrary.shared().performChanges {
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: destinationURL)
                } completionHandler: { success, error in
                    if success {
                        print("Download Success: \(destinationURL)")
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            } else {
                completion(false)
            }
        }
        
        let progressPublisher = task.progress.publisher(for: \.fractionCompleted)
        progressPublisher
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.main) // Debounce the updates
            .sink { fractionCompleted in
                DispatchQueue.main.async {
                    self.downloadProgress = fractionCompleted // Update progress on the main thread
                }
            }
            .store(in: &cancellables)
        
        task.resume()
    }

    
    func convertAndSaveVideoToGif(videoURL: URL, completion: @escaping (Bool) -> Void) {
        // Download the video asynchronously
        let task = URLSession.shared.dataTask(with: videoURL) { [weak self] data, response, error in
            guard let self = self else { return } // Avoid retain cycle
            
            if let data = data {
                // Create a temporary file URL to save the downloaded video
                let temporaryVideoURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(Date().timeIntervalSince1970).mp4")
                
                // Save the downloaded data to the temporary file URL
                do {
                    try data.write(to: temporaryVideoURL)
                    
                    // Convert the video to GIF
                    let regift = Regift(sourceFileURL: temporaryVideoURL, frameCount: 10, delayTime: 0.1)
                    if let gifURL = regift.createGif() {
                        DispatchQueue.main.async {
                            // Save the GIF to Photos library
                            self.saveGifToPhotos(gifURL: gifURL) { isSuccess in
                                if isSuccess {
                                    print("Video Saved")
                                    completion(true)
                                } else {
                                    print("Error saving video as GIF")
                                    completion(false)
                                }
                            }
                        }
                    }
                } catch {
                    // Handle the error, e.g., by showing an alert to the user
                    print("Error saving the video data: \(error.localizedDescription)")
                }
            } else {
                // Handle the error, e.g., by showing an alert to the user
                print("Error downloading the video: \(error?.localizedDescription ?? "Unknown Error")")
            }
        }
        task.resume()
        
        let progressPublisher = task.progress.publisher(for: \.fractionCompleted)
        progressPublisher.assign(to: &$downloadGifProgress)
        print("Gif Download progress: \(downloadGifProgress)")
    }
    
    func saveGifToPhotos(gifURL: URL, completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.shared().performChanges {
            let gifCreationRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: gifURL)
            gifCreationRequest?.creationDate = Date()
        } completionHandler: { success, error in
            if success {
                print("Video saved to Photos library.")
                completion(true)
            } else {
                print("Error saving video to Photos library: \(error?.localizedDescription ?? "Unknown Error")")
                completion(false)
            }
        }
    }
}
