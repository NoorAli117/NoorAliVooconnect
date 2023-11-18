//
//  ImagePickerViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 10/12/22.
//


import SwiftUI
import Photos
import AVKit

class ImagePickerViewModel: NSObject,ObservableObject,PHPhotoLibraryChangeObserver {
    
    @Published var showImagePicker = false
    
    @Published var library_status = LibraryStatus.denied
    
    // List Of Fetched arrays...
    @Published var fetchedVideos : [Asset] = []
    @Published var fetchedImages : [Asset] = []
    @Published var fetchedAssets : [Asset] = []
    
    // To Get Updates....
    @Published var allPhotos : PHFetchResult<PHAsset>!
    
    // Preview...
    @Published var showPreview = false
    @Published var selectedAsset: Asset?
    
    func openImagePicker() {
        
        // CLosing Keyboard if opened....
        
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        // Fetching fetching all assets if `fetchedAssets` is empty
        if fetchedAssets.isEmpty {
            fetchAll()
        }
        
        withAnimation{showImagePicker.toggle()}
    }
    
    func setUp() {
        
        // requesting Permission...
        PHPhotoLibrary.requestAuthorization(for: .readWrite) {[self] (status) in
            
            DispatchQueue.main.async {
                
                switch status {
                
                case .denied: self.library_status = .denied
                case .authorized: self.library_status = .approved
                case .limited: self.library_status = .limited
                default : self.library_status = .denied
                }
            }
        }
        
        // Registering Observer...
        PHPhotoLibrary.shared().register(self)
    }
    
    // Listeneing To Changes...
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let _ = allPhotos else{return}
        
        if let updates = changeInstance.changeDetails(for: allPhotos) {
            
            // Getting Updated List...
            let updatedPhotos = updates.fetchResultAfterChanges
            
            // There is bug in it...
            // It is not updating the inserted or removed items....
            
//            print(updates.insertedObjects.count)
//            print(updates.removedObjects.count)
            
            // So were Going to verify All And Append Only No in the list...
            // To Avoid Of reloading all and ram usage...
            
            updatedPhotos.enumerateObjects {[self] (asset, index, _) in
                
                if !allPhotos.contains(asset) {
                    
                    // If its not There...
                    // getting Image And Appending it to array...
                    
                    getImageFromAsset(asset: asset,size: CGSize(width: 450, height: 450)) { (url,image) in
                        
                        let asset = Asset(asset: asset,  url: url, uiImage: image)
                        self.fetchedAssets.append(asset)
                        self.fetchedImages.append(asset)
                        
                    }
                }
            }
            
            // To Remove If Image is removed...
            allPhotos.enumerateObjects { (asset, index, _) in
                
                if !updatedPhotos.contains(asset){
                    
                    // removing it...
                    DispatchQueue.main.async {
                        
                        self.fetchedAssets.removeAll { (result) -> Bool in
                            return result.asset == asset
                        }
                        self.fetchedImages.removeAll { (result) -> Bool in
                            return result.asset == asset
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.allPhotos = updatedPhotos
            }
        }
    }
    
    func fetchPhotos() {
        
        // Fetching All Photos...
        let options = PHFetchOptions()
        options.sortDescriptors = [
        
            // Latest To Old...
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        options.includeHiddenAssets = false
        
        let fetchResults = PHAsset.fetchAssets(with: options)
        
        allPhotos = fetchResults
        
        fetchResults.enumerateObjects {[self] (asset, index, _) in
            
            // Getting Image From Asset...
            if(index < 300)
            {
                getImageFromAsset(asset: asset,size: CGSize(width: 450, height: 450)) { (url,image) in
                    
                    // Appending it To Array...
                    
                    // Why we storing asset..
                    // to get full image for sending....
                    
                    let asset = Asset(asset: asset,  url: url, uiImage: image)
                    self.fetchedAssets.append(asset)
                    self.fetchedImages.append(asset)
                    
                }
            }
            
        }
    }
    
    func fetchVideo() {
        
        // Fetching All Photos...
        let options = PHFetchOptions()
        options.sortDescriptors = [
        
            // Latest To Old...
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        options.includeHiddenAssets = false
        let videoPredicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)
        options.predicate = videoPredicate
        let fetchResults = PHAsset.fetchAssets(with: options)
        
        allPhotos = fetchResults
        
        fetchResults.enumerateObjects {[self] (asset, index, _) in
            
            // Getting Image From Asset...
            if(index < 300)
            {
                getVideoFromAsset(asset: asset,size: CGSize(width: 450, height: 450)) { (url) in
                    
                    // Appending it To Array...
                    
                    // Why we storing asset..
                    // to get full image for sending....
                    
                    let asset = Asset(asset: asset,  url: url, uiImage: UIImage())
                    self.fetchedAssets.append(asset)
                    self.fetchedVideos.append(asset)
                    
                }
            }
            
        }
    }
    
    
    ///Fetching all images and videos from gallery
    func fetchAll() {
        
        let options = PHFetchOptions()
        options.sortDescriptors = [
            // Latest To Old...
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        options.includeHiddenAssets = false
        let videoPredicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)
        let imagePredicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [videoPredicate, imagePredicate])
        //Fetching videos and photos
        options.predicate = predicate
        let fetchResults = PHAsset.fetchAssets(with: options)
        allPhotos = fetchResults
        fetchResults.enumerateObjects {[self] (asset, index, _) in
            
            // Getting only 500 assets to prevent memory leak
            if(index < 500)
            {
                getAssets(asset: asset,size: CGSize(width: 450, height: 450)) { (url,image) in
                    if(asset.mediaType == .image)
                    {
                        let asset = Asset(asset: asset,  url: url, uiImage: image ?? UIImage())
                        self.fetchedAssets.append(asset)
                        self.fetchedImages.append(asset)
                    }else
                    {
                        let asset = Asset(asset: asset,  url: url, uiImage: UIImage())
                        self.fetchedAssets.append(asset)
                        self.fetchedVideos.append(asset)
                    }
                    
                }
            }
            
        }
    }
    
    // Using Completion Handlers...
    // To recive Objects...
    
    func getImageFromAsset(asset: PHAsset,size: CGSize,completion: @escaping (URL, UIImage)->()) {
        
        // To cache image in memory....
        
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        
        // Your Own Properties For Images...
        let imageOptions = PHImageRequestOptions()
        imageOptions.deliveryMode = .opportunistic
        imageOptions.isSynchronous = false
        
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: imageOptions) { (image, _) in
            
            guard let resizedImage = image else{return}
            asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) { (eidtingInput, info) in
                if let input = eidtingInput, let photoUrl = input.fullSizeImageURL {
                    completion(photoUrl, resizedImage)
                }
            }
            
//            completion(resizedImage)
        }
        
        
    }
    
    func getVideoFromAsset(asset: PHAsset,size: CGSize,completion: @escaping (URL)->()) {
        
        // To cache image in memory....
        
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        
        // Your Own Properties For Images...
        let imageOptions = PHImageRequestOptions()
        imageOptions.deliveryMode = .opportunistic
        imageOptions.isSynchronous = false
        
        PHCachingImageManager().requestAVAsset(forVideo: asset, options: nil, resultHandler: { asset, _, _ in
            DispatchQueue.main.async {
                guard let asset = asset else {return}
                guard let assetUrl = (asset as? AVURLAsset) else{return}
                completion(assetUrl.url)
            }
        })
        
        
    }
    
    ///Getting asset from `asset`, returns nil as ``UIImage`` if asset its a video
    func getAssets(asset: PHAsset,size: CGSize,completion: @escaping (URL, UIImage?)->()) {
        
        // To cache image in memory....
        
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        
        // Your Own Properties For Images...
        let imageOptions = PHImageRequestOptions()
        
        imageOptions.isSynchronous = false
        if(asset.mediaType == .image)
        {
            imageOptions.deliveryMode = .highQualityFormat
            imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: imageOptions) { (image, _) in
                guard let resizedImage = image else{return}
                asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) { (eidtingInput, info) in
                    if let input = eidtingInput, let photoUrl = input.fullSizeImageURL {
                        completion(photoUrl, resizedImage)
                    }
                }
            }
        }else
        {
            imageOptions.deliveryMode = .fastFormat
            PHCachingImageManager().requestAVAsset(forVideo: asset, options: nil, resultHandler: { asset, _, _ in
                DispatchQueue.main.async {
                    guard let asset = asset else {return}
                    guard let assetUrl = (asset as? AVURLAsset) else{return}
                    completion(assetUrl.url, nil)
                }
            })
        }
    }
    
    // Opening Image Or Video....
    
    func extractPreviewData(asset: PHAsset) {
        
        let manager = PHCachingImageManager()
        
        if asset.mediaType == .image{
            
            // Extract Image..
            
            getImageFromAsset(asset: asset, size: PHImageManagerMaximumSize) { (url, image) in
                
                DispatchQueue.main.async {
//                    self.selectedImagePreview = url
                }
            }
        }
        
        if asset.mediaType == .video {
            
            // Extract Video...
            
            let videoManager = PHVideoRequestOptions()
            videoManager.deliveryMode = .highQualityFormat
            
            manager.requestAVAsset(forVideo: asset, options: videoManager) { (videoAsset, _, _) in
                
                DispatchQueue.main.async {
                    
                    if let urlAsset = videoAsset as? AVURLAsset {
//                        let localVideoUrl: URL = urlAsset.url as URL
//                        self.sele = localVideoUrl
                    }
                }
            }
        }
    }
}


enum LibraryStatus {

    case denied
    case approved
    case limited
}

struct Asset: Identifiable {
    var id = UUID().uuidString
    var asset: PHAsset
    var url : URL
    var uiImage : UIImage
    var isVideo: Bool {
        let lowercasedURL = url.absoluteString.lowercased()
        return lowercasedURL.hasSuffix(".mov") || lowercasedURL.hasSuffix(".mp4")
    }
}
