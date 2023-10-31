//
//  MusicView.swift
//  Vooconnect
//
//  Created by door on 16/05/2023.
//

import SwiftUI
import AVKit
import AVFoundation
import SwiftUIBloc

struct MusicView: View {
    @Environment(\.presentationMode) var presentaionMode
    @Binding var reelId: Int
    @Binding var follow: Bool
    @State var uuid = ""
    @StateObject private var userVM: LogInViewModel = LogInViewModel()
    @StateObject private var reelVM: ReelsViewModel = ReelsViewModel()
    @StateObject private var likeVM: ReelsLikeViewModel = ReelsLikeViewModel()
    @Binding var cameraView: Bool
    @State var audioPlayer: AVAudioPlayer!
//    @State private var audioPlayer: AVPlayer?
    @State var player: AVPlayer!
    @State var isPlaying = false
//    @State var follow: Bool = false
    @State var viewerProfile = false
    @State var songModel: DeezerSongModel?
    var soundsViewBloc = SoundsViewBloc(SoundsViewBlocState())
    //    var thumbnailImageView: UIImageView
    @State var thumbnailImageView2: UIImage?
    @State var musicImage: Image?
    @Binding var musicURL: String
    @State var reels: Post?
    var gridLayoutMP: [GridItem] {
        return Array(repeating: GridItem(.fixed(120), spacing: 1), count: 3)
    }
    @StateObject var cameraModel = CameraViewModel()
    
    
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
                    VStack {
                        
                        ForEach(reelVM.allReels, id: \.postID) { reel in
                            if reel.postID == reelId {
                                VStack(alignment: .leading){
                                    HStack{
                                        Image("MusicImage")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 140, height: 140)
                                        VStack (alignment: .leading) {
                                            Spacer()
                                            Text("\(reel.musicTrack ?? "Original Sound")")
                                                .font(.custom("Urbanist-Regular", size: 24))
                                                .fontWeight(Font.Weight.semibold)
                                                .lineLimit(2)
                                            Spacer(minLength: 10.0)
                                            Text("28,7M Videos")
                                                .font(.custom("Urbanist-Regular", size: 14))
                                                .fontWeight(Font.Weight.medium)
                                                .foregroundColor(.gray)
                                            Spacer()
                                        }
//                                        .frame(maxWidth: .infinity)
                                        Spacer()
                                    }
                                    
                                    //buttons
                                    HStack {
                                        Button {
                                            
                                            if let audioPlayer = audioPlayer {
                                                if audioPlayer.currentTime == 0.0 {
                                                    isPlaying = false
                                                }
                                            }
                                            isPlaying.toggle()
                                            if isPlaying {
                                                self.audioPlayer?.play()
                                            } else {
                                                self.audioPlayer?.pause()
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
                                    
                                    //singer
                                    HStack {
                                        VStack{
                                            HStack{
                                                if let creatorImage = reel.creatorProfileImage{
                                                    CreatorProfileImageView(creatorProfileImage: creatorImage)
                                                        .scaledToFill()
                                                        .frame(width: 60, height: 60)
                                                        .padding(.trailing,20)
                                                }else{
                                                    Image("ImageCP")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 60, height: 60)
                                                        .padding(.trailing,20)
                                                }
                                                VStack(alignment: .leading){
                                                    Text("\((reel.creatorFirstName ?? "John") + " " + (reel.creatorLastName ?? " Devise")) ")
                                                        .font(.custom("Urbanist-Regular", size: 18))
                                                        .fontWeight(Font.Weight.semibold)
                                                    Text("Profesional Singer")
                                                        .font(.custom("Urbanist-Regular", size: 14))
                                                        .fontWeight(Font.Weight.medium)
                                                        .foregroundColor(.gray)
                                                }
                                                .onTapGesture{
                                                    viewerProfile = true
                                                    self.reels = reel
                                                }
                                            }
                                        }
                                        Spacer()
                                        if let uid = UserDefaults.standard.string(forKey: "uuid"){
                                            if uuid != uid{
                                                Button {
                                                    follow.toggle()
                                                    if (follow == true) {
                                                        likeVM.followApi(user_uuid: uuid)
                                                        likeVM.UserFollowingUsers()
                                                    }else{
                                                        likeVM.unFollowApi(user_uuid: uuid)
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                                            likeVM.UserFollowingUsers()
                                                        }
                                                    }
                                                } label: {
                                                    Text(follow ? "Following" : "Follow")
                                                        .font(.custom("Urbanist-Medium", size: 16))
                                                        .fontWeight(Font.Weight.medium)
                                                }
                                                .frame(width: 120,height: 40)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .strokeBorder(
                                                            follow
                                                            ? LinearGradient(colors: [
                                                                Color("buttionGradientTwo"),
                                                                Color("buttionGradientOne"),
                                                            ], startPoint: .top, endPoint: .bottom)
                                                            : LinearGradient(colors: [
                                                                Color(.white),
                                                            ], startPoint: .top, endPoint: .bottom),
                                                            lineWidth: 2
                                                        )
                                                )
                                                .background(follow ? LinearGradient(colors: [
                                                    Color(.white),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                    Color("buttionGradientOne"),
                                                    Color("buttionGradientTwo"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                                )
                                                
                                                .cornerRadius(40)
                                                .foregroundColor(follow ? Color("buttionGradientOne") : .white)
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            
                        }
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
        .blurredSheet(.init(.white), show: $viewerProfile) {
            
        } content: {
            if #available(iOS 16.0, *) {
                ViewerProfileDetailSheet(reelId: reelId, follow: $follow, uuid: $uuid, reel: $reels)
                    .presentationDetents([.large,.medium,.height(500)])
            } else {
                // Fallback on earlier versions
            }
        }
        .onAppear{
            print("it's running")
            if let songUrl = URL(string: "\(getImageVideoBaseURL + musicURL)") {
                // Create an AVAudioPlayer instance.
                print("songUrl: \(songUrl)")
                downloadMusic(url: songUrl)
            }
        }
        
        
    }
    
    func downloadMusic(url: URL){
        let task = URLSession.shared.downloadTask(with: url) { (location, response, error) in
            if let error = error {
                print("Error downloading audio file: \(error)")
                return
            }
            
            // Get the downloaded audio file URL.
            guard let location = location else {
                print("Could not get downloaded audio file URL.")
                return
            }
            
            // Create an AVAudioPlayer from the downloaded audio file.
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: location)
                _ = UserDefaults.standard.setValue(location.absoluteString, forKey: "useSong")
            } catch let error {
                print("Error creating AVAudioPlayer: \(error)")
                return
            }
        }
        
        task.resume()
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
