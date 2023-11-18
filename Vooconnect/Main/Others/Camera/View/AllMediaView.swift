//
//  AllMediaView.swift
//  Vooconnect
//
//  Created by Vooconnect on 10/12/22.
//

import SwiftUI
import AVKit

struct AllMediaView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State private var all: Bool = true
    @State private var videos: Bool = false
    @State private var photos: Bool = false
    @State private var previewView: Bool = false
    @State private var selected: Bool = false
    @State private var preview: Bool = false
    @State var previewURL: String = ""
    @StateObject var imagePicker = ImagePickerViewModel()
    @State var selectedIndex = "1"
    @StateObject var camera = CameraModelPhoto()
    @StateObject var cameraModel = CameraViewModel()
    @State private var outputURL: URL?
    var callback : (URL) -> () = {val in}
    @State private var upload: Bool = false
    @State private var isShowPopup = false
    @State private var message = ""
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
                    
                    if let url = URL(string: previewURL){
                        NavigationLink(destination: FinalPreview(controller: FinalPreviewController(url: url, speed: cameraModel.speed), songModel: cameraModel.songModel, speed: 1, url: .constant(url))
                            .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $preview) {
                                EmptyView()
                            }
                    }
                    
//                    if(imagePicker.selectedAsset != nil )
//                    {
//                        NavigationLink(destination:
//                                        FinalPreview(url: imagePicker.selectedAsset!.url, showPreview: .constant(true), songModel: songModel)
//                                        .navigationBarBackButtonHidden(true)
//                                        .navigationBarHidden(true),
//                                       isActive: $imagePicker.showPreview) {
//                                EmptyView()
//                            }
//                    }
                    
                    
                    // Top Bar
                    HStack {
                        Button {
                            imagePicker.selectedAsset = nil
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButtonM")
                        }
                        
                        Spacer()
                        
                        Text("All Media")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(.black)
                        
                        Image("ArrowDownLogoM")
                        
                        Spacer()
                        
                        Image("MoreOptionLogoM")
                        
                    }
                    .padding(.bottom, 20)
//                    .padding(.horizontal)
                    
                    // All button
                    HStack {
                        
                        Button {
                            all = true
                            videos = false
                            photos = false
                            
                        } label: {
                            VStack {
                                Text("All")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundStyle( all ?
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                            Color("gray"),
                                            Color("gray"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                                
                                ZStack {
                                    if all {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .frame(height: 4)
                                    } else {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("grayOne"),
                                                    Color("grayOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.trailing, -9)
                                            .frame(height: 2)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            all = false
                            videos = true
                            photos = false
                            
                        } label: {
                            VStack {
                                Text("Videos")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundStyle( videos ?
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                            Color("gray"),
                                            Color("gray"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                                ZStack {
                                    if videos {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .frame(height: 4)
                                    } else {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("grayOne"),
                                                    Color("grayOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.leading, -8)
                                            .padding(.trailing, -40)
                                            .frame(height: 2)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            all = false
                            videos = false
                            photos = true
                            
                        } label: {
                            VStack {
                                Text("Photos")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundStyle( photos ?
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                            Color("gray"),
                                            Color("gray"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                                ZStack {
                                    if photos {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .frame(height: 4)
                                    } else {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("grayOne"),
                                                    Color("grayOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.leading, -8)
                                        
                                            .frame(height: 2)
                                    }
                                }
                                
                            }
                        }
                        
                    }
                    .padding(.bottom)
//                    .padding(.horizontal)
                    
                    // All Photo
                    if all {
                        
                        VStack {
                            
                            ScrollView(.vertical, showsIndicators: false, content: {
                                LazyVGrid(columns: gridLayoutOne, alignment: .center, spacing: columnSpacingOne, pinnedViews: []) {
                                    
                                    // Images...
                                    
                                    ForEach(imagePicker.fetchedAssets) { photo in

                                        Button(action: {
//                                            imagePicker.extractPreviewData(asset: photo.asset)
//                                            selectedIndex = photo.id
//                                            print(selectedIndex)
                                            self.imagePicker.selectedAsset = photo
                                        }, label: {

                                            ThumbnailViewAll(photo: photo, isSelected: photo.url == imagePicker.selectedAsset?.url)

                                        })
                                        
                                        
                                    }
                                    
                                    // More Or Give Access Button...
                                    
                                    if imagePicker.library_status == .denied || imagePicker.library_status == .limited{
                                        
                                        VStack(spacing: 15){
                                            
                                            Text(imagePicker.library_status == .denied ? "Allow Access For Photos" : "Select More Photos" )
                                                .foregroundColor(.gray)
                                            
                                            Button(action: {
                                                // Go to Settings
                                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                                            }, label: {
                                                
                                                Text(imagePicker.library_status == .denied ? "Allow Access" : "Select More")
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                                    .padding(.vertical,10)
                                                    .padding(.horizontal)
                                                    .background(
                                                        LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    )
                                                    .cornerRadius(5)
                                            })
                                        }
                                        
                                        .frame(width: 150)
                                        .padding(.leading, 30)
                                    }
                                    
                                    
                                }
                            })
                        }
                        
                    } else if videos == true {
                        
                        VStack {

                            ScrollView(.vertical, showsIndicators: false, content: {
                                LazyVGrid(columns: gridLayoutOne, alignment: .center, spacing: columnSpacingOne, pinnedViews: []) {

                                    // Images...
                                    ForEach(imagePicker.fetchedVideos) { photo in

                                        Button(action: {
//                                            imagePicker.extractPreviewData(asset: photo.asset)
//                                            selectedIndex = photo.id
//                                            print(selectedIndex)
                                                self.imagePicker.selectedAsset = photo
//                                            imagePicker.showPreview.toggle()
                                        }, label: {

                                            ThumbnailViewVideo(photo: photo, isSelected: photo.url == imagePicker.selectedAsset?.url)
                                        })


                                    }

                                    // More Or Give Access Button...
 
                                    if imagePicker.library_status == .denied || imagePicker.library_status == .limited {

                                        VStack(spacing: 15){

                                            Text(imagePicker.library_status == .denied ? "Allow Access For Photos" : "Select More Photos" )
                                                .foregroundColor(.gray)

                                            Button(action: {
                                                // Go to Settings
                                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                                            }, label: {

                                                Text(imagePicker.library_status == .denied ? "Allow Access" : "Select More")
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                                    .padding(.vertical,10)
                                                    .padding(.horizontal)
                                                    .background(
                                                        LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    )
                                                    .cornerRadius(5)
                                            })
                                        }

                                        .frame(width: 150)
                                        .padding(.leading, 30)
                                    }

                                }
                            })
                        }
                        
                    } else {
                        
                        VStack {

                            ScrollView(.vertical, showsIndicators: false, content: {
                                LazyVGrid(columns: gridLayoutOne, alignment: .center, spacing: columnSpacingOne, pinnedViews: []) {

                                    // Images...
                                    ForEach(imagePicker.fetchedImages) { photo in

                                        Button(action: {
//                                            imagePicker.extractPreviewData(asset: photo.asset)
////                                            imagePicker.showPreview.toggle()
//                                            selectedIndex = photo.id
//                                            print(selectedIndex)
                                            self.imagePicker.selectedAsset = photo
                                        }, label: {

                                            ThumbnailViewImage(photo: photo, isSelected: photo.url == imagePicker.selectedAsset?.url)
                                        })


                                    }

                                    // More Or Give Access Button...  ThumbnailViewImage
 
                                    if imagePicker.library_status == .denied || imagePicker.library_status == .limited {

                                        VStack(spacing: 15){

                                            Text(imagePicker.library_status == .denied ? "Allow Access For Photos" : "Select More Photos" )
                                                .foregroundColor(.gray)

                                            Button(action: {
                                                // Go to Settings
                                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                                            }, label: {

                                                Text(imagePicker.library_status == .denied ? "Allow Access" : "Select More")
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                                    .padding(.vertical,10)
                                                    .padding(.horizontal)
                                                    .background(
                                                        LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    )
                                                    .cornerRadius(5)
                                            })
                                        }

                                        .frame(width: 150)
                                        .padding(.leading, 30)
                                    }


                                }
                            })
                        }
                    }
                    
                    Spacer()
                    
                    
                    Text("You can select both videos & photos")
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(Color("GraySeven"))
//                        .padding(.vertical, 10)
                    
                    Button {
//                        imagePicker.showPreview = true
                        if let asset = self.imagePicker.selectedAsset{
                            processAsset(asset)
                        }
                    } label: {
                        Text("Next")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .padding(18)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(40)
                            .foregroundColor(.white)
                    }
                    
                    
                }
                .padding(.horizontal)
                
                if self.isShowPopup {
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            Spacer()
                            Text(message)
                                .frame(maxWidth: geometry.size.width * 0.8, maxHeight: 40.0)
                                .padding(.bottom, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.black.opacity(0.50))
                                )
                                .foregroundColor(Color.white)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            self.isShowPopup = false
                                        }
                                    }
                                }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
                    }
                }
                
                
            }
            
            .navigationBarHidden(true)
        }
        .onAppear {
            imagePicker.setUp()
            imagePicker.openImagePicker()
        }
        .environmentObject(imagePicker)
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Use the minimum ratio to fit the image within the target size
        let ratio = min(widthRatio, heightRatio)
        
        // Calculate the new size for the image
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        // Calculate the center position offset
        let xOffset = (targetSize.width - newSize.width) / 2.0
        let yOffset = (targetSize.height - newSize.height) / 2.0
        
        // Create a new bitmap context with the new size
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        
        // Draw the image at the centered position
        image.draw(in: CGRect(x: xOffset, y: yOffset, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? UIImage()
    }



    func resizeVideo(url: URL, size: CGSize) {
        // Input URL of the original video
        print("new size will be: \(size)")
        
        // Output URL for the resized video in the Documents directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputURL = documentsDirectory.appendingPathComponent("\(Date())_resized_video.mp4")
        
        cameraModel.resizeVideo(inputURL: url, outputURL: outputURL, newWidth: size.width, newHeight: size.height) { success in
            if success {
                print("Video resized successfully")
                previewURL = outputURL.absoluteString
                cameraModel.previewURL = outputURL
//                cameraModel.showPreview = true
                preview = true
            } else {
                print("Failed to resize video")
                isShowPopup = true
                showMessagePopup(messages: "Failed to export")
            }
        }
    }
    
    func showMessagePopup(messages: String) {
        self.message = messages
        self.isShowPopup = true
    }

    
    func processAsset(_ asset: Asset) {
        let url = asset.url
        if url.pathExtension == "png" || url.pathExtension == "jpg" || url.pathExtension == "JPG" {
            print(url)
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data){
                    // Perform video creation and merging asynchronously
                let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 375.0, height: 812.0))
                print("resizedImage size\(resizedImage.size)")
                if resizedImage != nil {
                    DispatchQueue.global().async {
                        camera.createVideoFromImage(image: resizedImage, originalSize: resizedImage.size, duration: 30.0) { result in
                            switch result {
                            case .success(let outputURL):
                                print("Video export completed successfully.")
                                print("Output URL: \(outputURL)")
                                
                                if let audioURL = URL(string: (cameraModel.songModel?.preview ?? "")!) {
                                    camera.mergeVideoAndAudio(videoUrl: outputURL, audioUrl: audioURL) { error, url in
                                        guard let url = url else {
                                            print("Error merging video and audio.")
                                            return
                                        }
                                        print("Video and audio merge completed, new URL: \(url.absoluteString)")
                                        DispatchQueue.main.async {
                                            self.previewURL = url.absoluteString
                                            cameraModel.previewURL = url
                                            self.preview.toggle()
                                        }
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        self.previewURL = outputURL.absoluteString
                                        cameraModel.previewURL = outputURL
                                        self.preview.toggle()
                                    }
                                }
                                
                            case .failure(let error):
                                print("Video export failed with error: \(error.localizedDescription)")
                                isShowPopup = true
                                showMessagePopup(messages: "Export Failed")
                            }
                        }
                    }
                }
                }
        } else {
            print(url)
            resizeVideo(url: url, size: CGSize(width: 375.0, height: 812.0))
        }
    }
    
}

//struct AllMediaView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllMediaView()
//    }
//}

let columnSpacingOne: CGFloat = 8
let rowSpacingOne: CGFloat = 0
var gridLayoutOne: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingOne), count: 3)
}

// Preview View....
struct PreviewView: View {
    
    @EnvironmentObject var imagePicker: ImagePickerViewModel
     
    
    var body: some View{
        
        // For Top Buttons...
        
        NavigationView{
            
            ZStack{
                
                if imagePicker.selectedAsset != nil {

                    VideoPlayer(player: AVPlayer(url: self.imagePicker.selectedAsset!.url))
                }

                if imagePicker.selectedAsset != nil{
                    AsyncImage(url: imagePicker.selectedAsset?.url){image in
                        image.resizable()
                    }
                    placeholder:{
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
            
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button(action: {}, label: {
                        Text("Send")
                    })
                }
            })
        }
    }
}

struct ThumbnailViewAll: View {
    
    var photo: Asset
    let isSelected: Bool
    
    var body: some View{
        
        ZStack(alignment: .bottomTrailing, content: {
            if(photo.asset.mediaType == .video)
            {
                VideoPlayer(player: AVPlayer(url: photo.url))
                    .aspectRatio(contentMode: .fill)
    //                .frame(width: 150, height: 150)
                    .frame(width: UIScreen.main.bounds.width / 3 - 20, height: 120)
    //                .frame(width: 110, height: 120)
                    .cornerRadius(10)
            }else
            {
                Image(uiImage: photo.uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
    //                .frame(width: 150, height: 150)
                    .frame(width: UIScreen.main.bounds.width / 3 - 20, height: 120)
    //                .frame(width: 110, height: 120)
                    .cornerRadius(10)
            }

            
            // If Its Video
            // Displaying Video Icon...  UnCheckBoxM
            
            if photo.asset.mediaType == .video {
                Image(systemName: "video.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(8)
            }
            
        })
        .overlay(
            Image(isSelected ? "CheckBoxLogoM" : "UnCheckBoxM")
                .frame(width: 20, height: 20)
                .padding(.top,8)
                .padding(.trailing,8)
            , alignment: .topTrailing
            
        )
        
    }
}


struct ThumbnailViewVideo: View {
    
    var photo: Asset
    let isSelected: Bool
    var body: some View {

        ZStack(alignment: .bottomTrailing, content: {
            VideoPlayer(player: AVPlayer(url: photo.url))
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / 3 - 20, height: 120)
                .cornerRadius(10)

            Image(systemName: "video.fill")
                .font(.title2)
                .foregroundColor(.white)
                .padding(8)
        })
        .overlay(
            Image(isSelected ? "CheckBoxLogoM" : "UnCheckBoxM")
                .frame(width: 20, height: 20)
                .padding(.top,8)
                .padding(.trailing,8)
            , alignment: .topTrailing

        )
    }
}


struct ThumbnailViewImage: View {
    
    var photo: Asset
    let isSelected: Bool
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing, content: {
            
            if photo.asset.mediaType == .image {
                Image(uiImage: photo.uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                //                .frame(width: 150, height: 150)
                    .frame(width: UIScreen.main.bounds.width / 3 - 20, height: 120)
                //                .frame(width: 110, height: 120)
                    .cornerRadius(10)
            }
            
            // If Its Video
            // Displaying Video Icon...
            
            if photo.asset.mediaType == .video {
                Image(systemName: "video.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(8)
            }
        })
        .overlay(
            Image(isSelected ? "CheckBoxLogoM" : "UnCheckBoxM")
                .frame(width: 20, height: 20)
                .padding(.top,8)
                .padding(.trailing,8)
            , alignment: .topTrailing

        )
    }
}
