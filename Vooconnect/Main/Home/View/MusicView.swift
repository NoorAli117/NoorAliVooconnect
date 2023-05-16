//
//  MusicView.swift
//  Vooconnect
//
//  Created by door on 16/05/2023.
//

import SwiftUI
import AVKit
import AVFoundation

struct MusicView: View {
    @Environment(\.presentationMode) var presentaionMode
    @Binding var reelId: Int
    @State var uuid = ""
    @StateObject private var userVM: LogInViewModel = LogInViewModel()
    @StateObject private var reelVM: ReelsViewModel = ReelsViewModel()
    @StateObject private var likeVM: ReelsLikeViewModel = ReelsLikeViewModel()
    @Binding var cameraView: Bool
    @State var audioPlayer: AVAudioPlayer!
    @State var player: AVPlayer!
    @State var isPlaying = false
    //    var thumbnailImageView: UIImageView
    @State var thumbnailImageView2: UIImage?
    
    var gridLayoutMP: [GridItem] {
        return Array(repeating: GridItem(.fixed(120), spacing: 1), count: 3)
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Spacer()
                        
                        Button {
                            print(uuid)
                        } label: {
                            Image("ShareN")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal,24)
                    
                    
                    //music picture with title
                    HStack {
                        
                        ForEach(reelVM.allReels, id: \.postID) { reel in
                            if reel.postID == reelId {
                                if reel.musicURL == nil {
                                    Image(uiImage: thumbnailImageView2!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .cornerRadius(24)
                                    
                                    
                                }else{
                                    Image(reel.creatorProfileImage!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .cornerRadius(24)
                                }
                            }
                            
                        }
                        
                        //                        Image("EffectsImageE")
                        //                            .resizable()
                        //                            .scaledToFill()
                        //                            .frame(width: 140, height: 140)
                        //                            .cornerRadius(24)
                        
                        Spacer()
                        
                        VStack (alignment: .leading) {
                            
                            ForEach(reelVM.allReels, id: \.postID) { reel in
                                if reel.postID == reelId {
                                    VStack (alignment: .leading) {
                                        Text("\(reel.musicTrack == nil ? "Original-Sound" : "\(reel.title ?? "") by")")
                                            .font(.custom("Urbanist-Regular", size: 24))
                                            .fontWeight(Font.Weight.semibold)
                                            .lineLimit(1)
                                        if reel.musicTrack != nil {
                                            Text("\(reel.creatorFirstName! + " " + reel.creatorLastName!)")
                                                .font(.custom("Urbanist-Regular", size: 24))
                                                .fontWeight(Font.Weight.semibold)
                                                .lineLimit(1)
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                            
                            Text("28,7M Videos")
                                .font(.custom("Urbanist-Regular", size: 14))
                                .fontWeight(Font.Weight.medium)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal,24)
                    .padding(.top,24)
                    
                    //buttons
                    HStack {
                        Button {
                            isPlaying.toggle()
                            
                            for reel in reelVM.allReels{
                                if reel.postID == reelId {
                                    
                                    let playerItem = AVPlayerItem(url: URL(string: reel.musicURL == nil ? reel.contentURL! : reel.musicURL!)!)
                                    print(playerItem)
                                    player = AVPlayer(playerItem: playerItem)
                                    if isPlaying == false {
                                        player.play()
                                    }else{
                                        player.pause()
                                    }
                                    
                                }
                                
                            }
                            
                            
                        } label: {
                            HStack {
                                Image("PlayS")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 16, height: 16)
                                
                                Text("Play Song")
                                    .font(.custom("Urbanist-Regular", size: 16))
                                    .fontWeight(Font.Weight.medium)
                                    .foregroundColor(Color("buttionGradientOne"))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        //                        .padding(.horizontal,10)
                        .padding(.vertical,8)
                        .overlay( RoundedRectangle(cornerRadius: 40)
                            .stroke(Color("buttionGradientOne"), lineWidth: 2)
                        )
                        
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image("BookmarkSound")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 16, height: 16)
                                
                                Text("Add to Favourites")
                                    .font(.custom("Urbanist-Regular", size: 16))
                                    .fontWeight(Font.Weight.medium)
                                    .foregroundColor(Color("buttionGradientOne"))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal,3)
                        .padding(.vertical,8)
                        .overlay( RoundedRectangle(cornerRadius: 40)
                            .stroke(Color("buttionGradientOne"), lineWidth: 2)
                        )
                    }
                    .padding(.horizontal,24)
                    .padding(.top,24)
                    
                    //singer
                    HStack {
                        HStack {
                            
                            ForEach(userVM.usersList, id: \.self) { user in
                                if user.uuid == uuid {
                                    
                                    if user.profile_image?.isEmpty == false {
                                        Image(user.profile_image ?? "")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(24)
                                            .padding(.trailing,20)
                                    }else{
                                        Image("musicProfileIcon")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(24)
                                            .padding(.trailing,20)
                                    }
                                    
                                }
                            }
                            
                            
                            
                            VStack (alignment: .leading) {
                                ForEach(userVM.usersList, id: \.self) { user in
                                    if user.uuid == uuid {
                                        HStack {
                                            Text("\(user.first_name ?? "") ")
                                                .font(.custom("Urbanist-Regular", size: 18))
                                                .fontWeight(Font.Weight.semibold)
                                            
                                            Text("\(user.last_name ?? "")")
                                                .font(.custom("Urbanist-Regular", size: 18))
                                                .fontWeight(Font.Weight.semibold)
                                        }
                                    }
                                }
                                
                                
                                
                                ForEach(likeVM.userInterestCategory, id: \.id) { categ in
                                    if categ.user_uuid == uuid {
                                        ForEach(likeVM.interestCategory, id: \.id) { uiCateg in
                                            if categ.category_id == uiCateg.id {
                                                Text("\(uiCateg.category_name)")
                                                    .font(.custom("Urbanist-Regular", size: 14))
                                                    .fontWeight(Font.Weight.medium)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                }
                                //                                Text("Professional Singer")
                                //                                    .font(.custom("Urbanist-Regular", size: 14))
                                //                                    .fontWeight(Font.Weight.medium)
                                //                                    .foregroundColor(.gray)
                                
                            }
                            
                            Spacer()
                            
                        }
                        
                        Button {
                            likeVM.followApi(user_uuid: uuid)
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            
                            Text("Follow")
                                .font(.custom("Urbanist-Medium", size: 16))
                                .fontWeight(Font.Weight.medium)
                            
                        }
                        .padding(.vertical,6)
                        .padding(.horizontal,16)
                        .background(
                            LinearGradient(colors: [
                                Color("buttionGradientOne"),
                                Color("buttionGradientTwo"),
                            ], startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(30)
                    }
                    .padding(.horizontal,24)
                    .padding(.top,24)
                    
                    //divider
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 2.5)
                        .foregroundColor(Color.gray.opacity(0.1))
                        .padding(.horizontal,24)
                        .padding(.top,24)
                    
                    //use this sound
                    Button {
                        cameraView.toggle()
                    } label: {
                        HStack {
                            Image("MusicIcon")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16, height: 16)
                            
                            
                            Text("Use this Sound")
                                .font(.custom("Urbanist-Bold", size: 16))
                                .fontWeight(Font.Weight.semibold)
                            
                        }
                        
                        .padding(.vertical,18)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [
                            Color("buttionGradientOne"),
                            Color("buttionGradientTwo"),
                        ], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .padding(.horizontal,24)
                    .padding(.top,20)
                    
                    
                    ScrollView {
                        LazyVGrid(columns: gridLayoutMP, spacing: 1) {
                            ForEach(0...6, id: \.self) { item in
                                ZStack(alignment: .bottomLeading) {
                                    Image("ImageCP")
                                        .resizable()
                                        .scaledToFill()
                                    
                                    HStack {
                                        Image("PlayS")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                        
                                        Text("837.9 k")
                                            .foregroundColor(.white)
                                            .font(.custom("Urbanist-Regular", size: 10))
                                            .fontWeight(Font.Weight.medium)
                                    }
                                    .padding(.leading,10)
                                    .padding(.bottom,12)
                                    
                                }
                            }
                        }
                        .frame(height: 400)
                        .padding(.horizontal,24)
                    }
                    //                    .padding(.horizontal,24)
                    
                    
                    //                    Spacer()
                }
            }
        }
        .onAppear {
            getThumbnailFromUrl("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") { image in
                self.thumbnailImageView2 = image
            }
            //            for reel in reelVM.allReels {
            //                if reel.postID == reelId {
            //                    if reel.musicURL == nil {
            //                        getThumbnailFromUrl(reel.contentURL!) { image in
            //                            self.thumbnailImageView2 = image
            //                            print("Image:    \(image) \(reel.contentURL)")
            //                        }
            //                    }
            //                }}
            
        }
        
    }
    
    func getThumbnailFromUrl(_ url: String?, _ completion: @escaping ((_ image: UIImage?)->Void)) {
        
        guard let url = URL(string: (url ?? "")) else { return }
        DispatchQueue.main.async {
            let asset = AVAsset(url: url)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            
            let time = CMTimeMake(value: 2, timescale: 1)
            do {
                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: img)
                completion(thumbnail)
            } catch let error{
                print("Error :: ", error)
                completion(nil)
            }
        }
    }
}

//struct MusicView_Previews: PreviewProvider {
//    @State var reelId: Int = 0
//    @State var cameraView: Bool = false
//    
//    static var previews: some View {
//        MusicView(reelId: reelId, cameraView: cameraView)
//    }
//}


