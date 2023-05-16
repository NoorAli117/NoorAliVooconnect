//
//  PreviewFromGallery.swift
//  Vooconnect
//
//  Created by Vooconnect on 12/12/22.
//

import SwiftUI
import AVFoundation
import AVKit

struct PreviewFromGallery: View {
    
    @EnvironmentObject var imagePicker: ImagePickerViewModel
    @Environment(\.presentationMode) var presentaionMode
//    presentaionMode.wrappedValue.dismiss()
    var body: some View {
        
        // For Top Buttons...
        
        NavigationView{
            
            VStack {
                HStack {
                    Button {
                        imagePicker.selectedAsset = nil
                        presentaionMode.wrappedValue.dismiss()
                    } label: {
                        Image("BackButton")
                    }
                    Spacer()
                }
//                Spacer()
                .padding(.horizontal)
                ZStack{
                    
                    if imagePicker.selectedAsset != nil && imagePicker.selectedAsset?.asset.mediaType == .video{
    
                        VideoPlayer(player: AVPlayer(url: imagePicker.selectedAsset!.url))
                    }
    
                    else if imagePicker.selectedAsset != nil{
    
                        AsyncImage(url: imagePicker.selectedAsset!.url){image in
                            image.resizable()
                        }
                        placeholder:{
                            ProgressView()
                        }
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarHidden(true)
        }
    }
}

struct PreviewFromGallery_Previews: PreviewProvider {
    static var previews: some View {
        PreviewFromGallery()
    }
}
