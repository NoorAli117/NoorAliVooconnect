//
//  CustomShareSheet.swift
//  Vooconnect
//
//  Created by Mac on 15/09/2023.
//

import Foundation
import SwiftUI
import FBSDKShareKit

struct CustomShareSheet: View{
    
    @StateObject var downloader = VideoDownloader()
    @StateObject private var likeVM: ReelsLikeViewModel = ReelsLikeViewModel()
    @Binding var reelURL: String
    @Binding var reelDescription: String
    @Binding var postID: Int
    @Binding var shareSheet: Bool
    @Binding var isSaveVideo: Bool
    @Binding var isGifDownloading: Bool
    @Binding var bottomSheetReport: Bool
    @Binding var isShowPopup: Bool
    @Binding var message: String
    @Binding var isDuo: Bool
//    @Binding var isSuccess: Bool
    var body: some View{
        NavigationView{
            ScrollView{
                VStack(alignment: .center, spacing: 20) {
                    VStack{
                        Text("Share to")
                            .foregroundColor(Color("Black"))
                            .font(.custom("Urbanist-Bold", size: 24))
                            .padding(.top, 10) // Add padding to separate it from the top
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    // Add a divider between the first and second column
                    Divider().frame(height: 1).background(Color.gray).opacity(0.3)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Image("RepostS")
                            Text("Repost")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    // Add a divider between the first and second column
                    Divider().frame(height: 1).background(Color.gray).opacity(0.3)
                    HStack(alignment: .top, spacing: 30) {
                        VStack {
                            Image("WhatsAppS")
                            Text("WhatsApp")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        VStack {
                            Image("TwitterS")
                            Text("Twitter")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        VStack {
                            Image("FacebookS")
                            Text("Facebook")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        .onTapGesture {
                            print("Facebook tapped")
                            shareSheet = false
                            shareFacebookLink(url: reelURL, description: reelDescription)
                        }
                        VStack {
                            Image("InstaS")
                            Text("Instagram")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    HStack(alignment: .top, spacing: 40) {
                        VStack {
                            Image("YahooS")
                            Text("Yahoo")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        VStack {
                            Image("ChatS")
                            Text("Chat")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        VStack {
                            Image("WeChatS")
                            Text("WeChat")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        VStack {
                            Image("SlackS")
                            Text("Slack")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Add a divider between the first and second column
                    Divider().frame(height: 1).background(Color.gray).opacity(0.3)
                    
                    HStack(alignment: .top, spacing: 30) {
                        VStack {
                            Image("ReportS")
                            Text("Report")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        .onTapGesture{
                            shareSheet = false
                            bottomSheetReport = true
                        }
                        VStack {
                            Image("NotInterestedS")
                            Text("Not Interested")
                                .font(.custom("Urbanist-Bold", size: 16))
                                .lineLimit(0)
                        }
                        VStack {
                            Image("SaveVideoS")
                            Text("Save Video")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        .onTapGesture {
                            isSaveVideo = true
                            shareSheet = false
                            isShowPopup = true
                            showMessagePopup(messages: "Saving Video...")
                            let urll = getImageVideoBaseURL + "/marked" + reelURL
                            let videoURL = URL(string: urll)! // Replace with your video URL
                            DispatchQueue.main.async {
                                downloader.downloadVideo(url: videoURL) { downloadedURL in
                                    if downloadedURL == true {
                                        isSaveVideo = false
                                        isShowPopup = true
                                        showMessagePopup(messages: "Video Saved")
                                    }
                                }
                            }
                        }
                        VStack {
                            Image("SetasWallpaperS")
                            Text("Set as Wallpaper")
                                .font(.custom("Urbanist-Bold", size: 16))
                                .lineLimit(0)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    HStack(alignment: .top, spacing: 40) {
                        VStack {
                            Image("DuoS")
                            Text("Duo")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        .onTapGesture{
                            shareSheet = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                isDuo = true
                            }
                        }
                        VStack {
                            Image("KnitS")
                            Text("Knit")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        VStack {
                            Image("AddtoFavoritesS")
                            Text("Add to Favorites")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                        .onTapGesture {
                            shareSheet = false
                            let uuid = UserDefaults.standard.string(forKey: "uuid")
                            likeVM.bookMarkDataModel.userUUID = uuid ?? ""
                            likeVM.bookMarkDataModel.postID = postID
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                likeVM.bookMarkApi(){successMessage, success in
                                    if success == true {
                                        if successMessage == "Post bookmarked."{
                                            isShowPopup = true
                                            showMessagePopup(messages: "Added to Favorites")
                                        }else{
                                            isShowPopup = true
                                            showMessagePopup(messages: "Removed from Favorites")
                                        }
                                    }else{
                                        isShowPopup = true
                                        showMessagePopup(messages: "Network Error")
                                    }
                                }
                            }
                        }
                        VStack {
                            Image("ShareasaGifS")
                            Text("Share as a Gif")
                                .font(.custom("Urbanist-Bold", size: 16))
                                .lineLimit(0)
                        }
                        .onTapGesture {
                            isGifDownloading = true
                            shareSheet = false
                            let urll = getImageVideoBaseURL + "/marked" + reelURL
                            let videoURL = URL(string: urll)!
                            showMessagePopup(messages: "Saving GIF...")
                            DispatchQueue.main.async {
                                downloader.convertAndSaveVideoToGif(videoURL: videoURL){ success in
                                    if success {
                                        print("gif done")
                                        isGifDownloading = false
                                        showMessagePopup(messages: "GIF Saved")
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(.horizontal, 10)
            }
        }
        
        
    }
    func showMessagePopup(messages: String) {
        self.message = messages
        self.isShowPopup = true
    }
    func shareFacebookLink(url: String, description: String) {
        // Create a content object
        let content = ShareLinkContent()
        content.contentURL = URL(string: url) // Replace with your URL
        content.quote = description
        
        // Show the share dialog
        ShareDialog(viewController: nil, content: content, delegate: nil).show()
    }
}
