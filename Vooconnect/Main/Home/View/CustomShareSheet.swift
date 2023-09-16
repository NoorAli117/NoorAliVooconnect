//
//  CustomShareSheet.swift
//  Vooconnect
//
//  Created by Mac on 15/09/2023.
//

import Foundation
import SwiftUI

struct CustomShareSheet: View{
    
    @StateObject var downloader = VideoDownloader()
    @Binding var reelURL: String
    @Binding var shareSheet: Bool
    @Binding var isSaveVideo: Bool
    @Binding var isGifDownloading: Bool
    @Binding var bottomSheetReport: Bool
//    @Binding var isSuccess: Bool
    var body: some View{
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
                        let urll = "https://vooconnectasset.devssh.xyz/uploads/marked" + reelURL
                        let videoURL = URL(string: urll)! // Replace with your video URL
                        downloader.downloadVideo(url: videoURL) { downloadedURL in
                            if downloadedURL == true {
                                isSaveVideo = false
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
                    VStack {
                        Image("ShareasaGifS")
                        Text("Share as a Gif")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .lineLimit(0)
                    }
                    .onTapGesture {
                        isGifDownloading = true
                        shareSheet = false
                        let urll = "https://vooconnectasset.devssh.xyz/uploads/marked" + reelURL
                        let videoURL = URL(string: urll)!
                        downloader.convertAndSaveVideoToGif(videoURL: videoURL){ success in
                            if success {
                                print("gif done")
                                isGifDownloading = false
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
