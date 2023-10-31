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
    @State private var isPresentingActivityViewController = false
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
    @Binding var repost: Bool
    @State private var videoUrl: String?
    @State private var app: UIApplication? = UIApplication.shared
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
                        Button(action: {
                            shareSheet = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                repost.toggle()
                                print("repost")
                            }
                        }){
                            VStack {
                                Image("RepostS")
                                Text("Repost")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    // Add a divider between the first and second column
                    Divider().frame(height: 1).background(Color.gray).opacity(0.3)
                    HStack(alignment: .top, spacing: 30) {
                        Button(action: {
                            guard let videoURL = URL(string: getImageVideoBaseURL + "/marked" + reelURL) else {
                                print("Invalid video URL")
                                return
                            }
                            let videoURLWithoutProtocol = videoURL.absoluteString.replacingOccurrences(of: "https://", with: "")
                            if let url = URL(string: "https://wa.me/?text=\(videoURLWithoutProtocol)"),
                                UIApplication.shared.canOpenURL(url) {
                                print("Opening WhatsApp with message: \(reelDescription)%20\(videoURLWithoutProtocol)")
                                print("url is \(url)")
                                UIApplication.shared.open(url, options: [:])
                            } else {
                                print("WhatsApp is not installed on this device")
                            }
                            shareSheet = false
                        }) {
                            VStack {
                                Image("WhatsAppS")
                                Text("WhatsApp")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
                            downloadVideo(reelURL: reelURL)
                        }) {
                            VStack {
                                Image("TwitterS")
                                Text("Twitter")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
                            guard let videoURL = URL(string: getImageVideoBaseURL + "/marked" + reelURL) else {
                                print("Invalid video URL")
                                return
                            }
                            shareSheet = false
                            let videoURLWithoutProtocol = videoURL.absoluteString.replacingOccurrences(of: "https://", with: "")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                shareToFacebook(videoURL: videoURL, description: videoURLWithoutProtocol)
                            }

                        }) {
                            VStack {
                                Image("FacebookS")
                                Text("Facebook")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
                            
                        }){
                            VStack {
                                Image("InstaS")
                                Text("Instagram")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack(alignment: .top, spacing: 30) {
                        Button(action: {
                            
                        }){
                            VStack {
                                Image("YahooS")
                                Text("Yahoo")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
                            
                        }){
                            VStack {
                                Image("ChatS")
                                Text("Chat")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
                            
                        }){
                            VStack {
                                Image("WeChatS")
                                Text("WeChat")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
                            
                        }){
                            VStack {
                                Image("SlackS")
                                Text("Slack")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    // Add a divider between the first and second column
                    Divider().frame(height: 1).background(Color.gray).opacity(0.3)
                    
                    HStack(alignment: .top, spacing: 30) {
                        Button(action: {
                            shareSheet = false
                            bottomSheetReport = true
                        }){
                            VStack {
                                Image("ReportS")
                                Text("Report")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
                            likeVM.notInterested(postId: postID){ success in
                                if success == true{
                                    shareSheet = false
                                    isShowPopup = true
                                    showMessagePopup(messages: "Video Not Interested")
                                }else{
                                    isShowPopup = true
                                    showMessagePopup(messages: "Failed")
                                }
                            }
                        }){
                            VStack {
                                Image("NotInterestedS")
                                Text("Not Interested")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                                    .lineLimit(0)
                            }
                        }
                        Button(action: {
                            isSaveVideo = true
                            shareSheet = false
                            isShowPopup = true
                            showMessagePopup(messages: "Saving Video...")
                            let urll = getImageVideoBaseURL + "/marked" + reelURL
                            if let videoURL = URL(string: urll){
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
                        }){
                            VStack {
                                Image("SaveVideoS")
                                Text("Save Video")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
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
                        }){
                            VStack {
                                Image("SetasWallpaperS")
                                Text("Set as Wallpaper")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                                    .lineLimit(0)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack(alignment: .top, spacing: 30) {
                        Button(action: {
                            shareSheet = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                isDuo = true
                            }
                        }){
                            VStack {
                                Image("DuoS")
                                Text("Duo")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
                            
                        }){
                            VStack {
                                Image("KnitS")
                                Text("Knit")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
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
                        }){
                            VStack {
                                Image("AddtoFavoritesS")
                                Text("Add to Favorites")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Button(action: {
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
                        }){
                            VStack {
                                Image("ShareasaGifS")
                                Text("Share as a Gif")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .foregroundColor(Color.black)
                                    .lineLimit(0)
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
    
    func shareToFacebook(videoURL: URL, description: String) {
        let activityItems: [Any] = [description, videoURL]
                let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }



    private func downloadVideo(reelURL: String) {
        let urlSession = URLSession(configuration: .default)
        
        let url = URL(string: getImageVideoBaseURL + "/marked" + reelURL)!
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let data = data {
                self.videoUrl = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(reelURL).absoluteString
                
                try? data.write(to: URL(string: self.videoUrl!)!)
                
                DispatchQueue.main.async {
                    // Make sure that the video has finished downloading before trying to share it.
                    if let videoURL = self.videoUrl {
                        self.shareVideoToWhatsApp(videoUrl: videoURL)
                        print("videoURL")
                    }
                }
            } else if let error = error {
                print(error)
            }
        }
        
        task.resume()
    }
    
    private func shareVideoToWhatsApp(videoUrl: String) {
        let activityViewController = UIActivityViewController(activityItems: [URL(string: videoUrl)!], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.copyToPasteboard,
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.openInIBooks,
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.saveToCameraRoll
        ]
        
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            if completed {
                print("Video shared successfully.")
            } else {
                print("Failed to share video.")
            }
        }
        
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

//struct ShareMessageToWhatsAppView: View {
//
//    @State private var message = ""
//
//    var body: some View {
//        TextField("Enter message:", text: $message)
//        Button(action: {
//            let client = WhatsAPIClient()
//            client.sendMessage(to: "phone number", text: message) { success in
//                if success {
//                    // Message shared successfully
//                } else {
//                    // Error sharing message
//                }
//            }
//        }) {
//            Text("Share Message to WhatsApp")
//        }
//    }
//}
//
