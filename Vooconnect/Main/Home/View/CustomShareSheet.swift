//
//  CustomShareSheet.swift
//  Vooconnect
//
//  Created by Mac on 15/09/2023.
//

import Foundation
import AVFoundation
import SwiftUI
import FBSDKShareKit
import FBSDKCoreKit
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import Social

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
    
    
    var documentInteractionController: UIDocumentInteractionController!
    
    
    var body: some View{
        NavigationView{
            ScrollView{
                VStack(alignment: .center, spacing: 30) {
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
                        .onTapGesture {
                            if let reelUrl = URL(string: reelURL){
                                shareSheet = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    shareVideoToWhatsApp(videoUrl: reelURL)
                                    print("Whatsapp tapped")
                                }
                            }
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
                            shareSheet = false
                            DispatchQueue.main.async{
                                if let videoUrl =  URL(string: getImageVideoBaseURL + reelURL){
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                        uploadVideoToFacebook(videoURL: videoUrl)
                                        print("Facebook tapped")
                                    }
                                }
                            }
                        }
                        VStack {
                            Image("InstaS")
                            Text("Instagram")
                                .font(.custom("Urbanist-Bold", size: 16))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack(alignment: .top, spacing: 30) {
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
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
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
//                            DispatchQueue.main.async {
//                                downloader.downloadVideo(url: videoURL) { downloadedURL in
//                                    if downloadedURL == true {
//                                        isSaveVideo = false
//                                        isShowPopup = true
//                                        showMessagePopup(messages: "Video Saved")
//                                    }
//                                }
//                            }
                        }
                        VStack {
                            Image("SetasWallpaperS")
                            Text("Set as Wallpaper")
                                .font(.custom("Urbanist-Bold", size: 16))
                                .lineLimit(0)
                        }
                        .onTapGesture{
                            shareSheet = false
                            isShowPopup = true
                            showMessagePopup(messages: "Saving Image...")
                            let urll = getImageVideoBaseURL + "/marked" + reelURL
                            let videoURL = URL(string: urll)! // Replace with your video URL
                            DispatchQueue.main.async {
                                downloader.saveImageToPhotos(url: videoURL) { success in
                                    if success == true {
                                        isShowPopup = true
                                        showMessagePopup(messages: "Image Saved")
                                    }else{
                                        isShowPopup = true
                                        showMessagePopup(messages: "Failed to Save Image")
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack(alignment: .top, spacing: 30) {
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
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .padding(.bottom, 48)
                .frame(width: 428, alignment: .center)
                .background(.white)

                .cornerRadius(40)

                .overlay(
                RoundedRectangle(cornerRadius: 40)
                .inset(by: 0.5)
                .stroke(Color(red: 0.96, green: 0.96, blue: 0.96), lineWidth: 1)

                )
            }
        }
        
        
    }
    func showMessagePopup(messages: String) {
        self.message = messages
        self.isShowPopup = true
    }
    private func shareVideoToWhatsApp(videoUrl: String) {
        guard let videoURL = URL(string: getImageVideoBaseURL + videoUrl) else { return }

        let delegate = WhatsAppDelegate()
        let documentInteractionController = UIDocumentInteractionController(url: videoURL)
        documentInteractionController.uti = UTType.video.identifier
        documentInteractionController.delegate = delegate

        // Check if the UIWindow.key?.rootViewController?.view property is not nil.
        if let view = UIApplication.shared.windows.first?.rootViewController?.view {
            documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: view, animated: true)
        }
    }
    func shareToFacebook(videoURL: URL) {
        let activityItems: [Any] = [videoURL, self.reelDescription]
                let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    private func uploadVideoToFacebook(videoURL: URL) {

            let videoData = try? Data(contentsOf: videoURL)
            guard let videoData = videoData else { return }

            let videoObject: [String: Any] = ["title": "Application Name", "description": "Sharing a video to Facebook...", videoURL.absoluteString: videoData]

            let uploadRequest = GraphRequest(graphPath: "me/videos", parameters: videoObject, httpMethod: .post)

            let connection = GraphRequestConnection()
            connection.add(uploadRequest, completion: { (connection, result, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Video shared to Facebook successfully!")
                }
            })
            connection.start()
        }

}

class WhatsAppDelegate: NSObject, UIDocumentInteractionControllerDelegate {

    func documentInteractionController(_ controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) {
        // Check if the application is WhatsApp.
        if application == "net.whatsapp.WhatsApp" {
            // The video will be sent to WhatsApp.
        } else {
            // The video will not be sent to WhatsApp.
        }
    }
}
