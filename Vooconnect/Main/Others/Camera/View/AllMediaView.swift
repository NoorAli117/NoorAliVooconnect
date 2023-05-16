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
    
    @State var message = ""
    @StateObject var imagePicker = ImagePickerViewModel()
    @State var selectedIndex = "1"
    var callback : (Asset) -> () = {val in}
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
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
                        if(self.imagePicker.selectedAsset != nil)
                        {
                            self.callback(self.imagePicker.selectedAsset!)
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
                
                
            }
            
            .navigationBarHidden(true)
        }
        .onAppear {
            imagePicker.setUp()
            imagePicker.openImagePicker()
        }
        .environmentObject(imagePicker)
    }
}

struct AllMediaView_Previews: PreviewProvider {
    static var previews: some View {
        AllMediaView()
    }
}

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
