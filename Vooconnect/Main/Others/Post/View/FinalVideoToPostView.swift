//
//  FinalVideoToPostView.swift
//  Vooconnect
//
//  Created by Vooconnect on 06/12/22.
// ReelsPostViewModel

import SwiftUI
import Photos
import SDWebImageSwiftUI
import FBSDKShareKit
import CountryPicker
import NavigationStack
//import SocialMedia
//import FacebookLogin
//import FacebookCore

struct FinalVideoToPostView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var shouldPopToRootView : Bool
    @State private var showPreview = false
    @State private var bottomSheetShown = false
    @State private var bottomSheetMoreOption = false
    @State private var loadingVideo = false
    @State private var uploadingVideo = false
    @State private var homeView = false
    @State var text2: String = ""
    @State var description: String = ""
    
    @State var text = ""
    @State var didStartEditing = false
    
    @State var placeholder: String = "Add Video Description"
    
    //    @State var airplaneMode = true
    @State var toggleOn =  true
    @State var toggleOnTwo =  true
    @State var toggleOnThree =  false
    private enum Field: Int, CaseIterable {
        case captionn
    }
    @FocusState private var focusedField: Field?
    
    private let uploadReels: UploadReelsResource = UploadReelsResource()
    //    @State var selectedImage: UIImage = UIImage(named: "profileicon")!
    @StateObject var reelsPostVM = ReelsPostViewModel()
    @StateObject private var reelsVM = ReelsViewModel()
    
    //    var url: URL
    @Binding var postModel : PostModel
    @Binding var renderUrl : URL?
    @State var speed : Float = 1.0
    @State private var saveToDevice = false
    @State private var autoCaption = false
    @State private var loader = false
    @State private var showTopicView = false
    @State private var videoCreditsView = false
    @State private var isShowPopup = false
    @State private var message = ""
    @State private var captionLang = ""
    @State private var selectedTopic = ""
    @State private var selectedCat: Int?
    @State private var videoData: Data?
    @State private var showPrivacySettings = false
    
    @State private var isListView = false
    @GestureState private var tapGestureState = false
    @State private var extractedImage: UIImage?
    @FocusState private var isFocused: Bool
    @State var progress: Double = 0
    @State private var subLang: String = ""
    @State private var subAllow: String = ""
    @State private var subString: String = ""
    @State private var videoCreditsText: String = ""
    @State private var videoCreditsVisible: Bool = false
    @State var userNames: [String] = []
    @State var videoCredits: [String] = []
    @State private var showCountryPicker = false
    @State private var country: Country?
    
    var catSelected: (Int) -> () = {val in}
    @State private var selectedType: SocialMediaType?
    @State private var reelProgress: Double = 0.0
    @State private var uploadProgress: Double = 0.0
    
    @State private var audioUrl: URL?
    
    
    var body: some View {
        ZStack {
            //                NavigationView {
            Color(.white)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
//                        goBackToHome()
                    } label: {
                        Image("BackButton")
                    }
                    
                    Text("Post")
                        .font(.custom("Urbanist-Bold", size: 24))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    
                    HStack {
                        DescriptionTextEditor(text: $description, isListVisible: $isListView, userNames: $userNames, videoCreditsVisible: $videoCreditsVisible, videoCreditsText: $videoCreditsText)
                            .focused($isFocused)
                            .onTapGesture{
                                isFocused = true
                            }
                            .onChange(of: description) { newValue in
                                print("value is\(newValue)")
                                if let lastIndex = newValue.lastIndex(of: "@") {
                                    let substring = newValue.suffix(from: newValue.index(after: lastIndex))
                                    
                                    self.subString = String(substring)
                                    print("sub value is\(self.subString)")
                                }
                            }
                        
                        
                        //                            Image("SelectCover")
                        if let image = extractedImage {
                            ExtractedImageView(image: image)
                                .cornerRadius(15)
                        } else {
                            Image(uiImage: UIImage(imageLiteralResourceName: "SelectCover"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 130)
                                .cornerRadius(15)
                            
                        }
                    }
                    .onAppear {
                        extractImageFromVideo(url: renderUrl!) { image in
                            DispatchQueue.main.async {
                                extractedImage = image
                            }
                        }
                    }
                    .padding(.top,2)
                    
                    HStack(alignment: .top){
                        Text("Video credit to: ")
                            .font(.custom("Urbanist-Regular", size: 18))
                            .frame(width: 120)
                        if videoCreditsVisible {
                            CreditsView(videoCreditsText: $videoCreditsText)
                                .padding(.trailing, 10)
                        }
                        Spacer()
                    }
                    .padding(.top,2)
                    
                    
                    // Hastag
                    HStack {
                        
                        HStack {
                            
                            Image("HastagLogo")
                            
                            Button {
                                isFocused = true
                                description += " #"
                                
                            } label: {
                                Text("Hashtag")
                                    .lineLimit(1)
                                    .font(.custom("Urbanist-SemiBold", size: 14))
                                    .foregroundStyle((LinearGradient(colors: [
                                        Color("buttionGradientTwo"),
                                        Color("buttionGradientOne"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    ))
                            }
                            .padding(.leading, -4)
                            
                        }
                        .padding(.horizontal, 6)
                        .padding(.vertical, 8)
                        //                            .padding(5)
                        //                            .padding(.horizontal, 4)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder((LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                ), lineWidth: 2)
                        }
                        
                        Spacer()
                        
                        HStack {
                            
                            Image("AttheRateLogo")
                            
                            Button {
                                isFocused = true
                                description += " @"
                            } label: {
                                Text("Mention")
                                    .lineLimit(1)
                                    .font(.custom("Urbanist-SemiBold", size: 14))
                                    .foregroundStyle((LinearGradient(colors: [
                                        Color("buttionGradientTwo"),
                                        Color("buttionGradientOne"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    ))
                            }
                            .padding(.leading, -4)
                            
                        }
                        .padding(.horizontal, 6)
                        .padding(.vertical, 8)
                        //                            .padding(5)
                        //                            .padding(.horizontal, 4)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder((LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                ), lineWidth: 2)
                        }
                        
                        Spacer()
                        
                        HStack {
                            
                            Button {
                                if (videoCreditsVisible == true){
                                    videoCreditsVisible = false
                                    videoCreditsView = false
                                }else{
                                    videoCreditsView = true
                                }
                            } label: {
                                HStack{
                                    Image("VideoLogo")
                                    Text("Videos")
                                        .lineLimit(1)
                                        .font(.custom("Urbanist-SemiBold", size: 14))
                                }
                            }
                            .frame(width: 80, height: 32)
                            .foregroundStyle(videoCreditsVisible ? LinearGradient(colors: [
                                Color.white
                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                Color("buttionGradientTwo"),
                                Color("buttionGradientOne"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .background(videoCreditsVisible ? LinearGradient(colors: [
                                Color("buttionGradientTwo"),
                                Color("buttionGradientOne"),
                                Color("buttionGradientOne"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                Color.clear,
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(25)
                            .overlay(videoCreditsVisible ?
                                     RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                            
                        }
                        
                        Spacer()
                        
                        HStack {
                            
                            Image("CategorieLogo")
                            
                            Button {
                                isFocused = false
                                self.postModel.description = description
                                showTopicView.toggle()
                            } label: {
                                Text("Category")
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                                    .font(.custom("Urbanist-SemiBold", size: 14))
                            }
                            
                            .padding(.leading, -4)
                            
                        }
                        .padding(.horizontal, 6)
                        .padding(.vertical, 8)
                        //                            .padding(5)
                        //                            .padding(.horizontal, 4)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder((LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                ), lineWidth: 2)
                        }
                        .background(LinearGradient(colors: [
                            Color("buttionGradientTwo"),
                            Color("buttionGradientOne"),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .cornerRadius(20)
                        
                    }
                    .padding(.top, 8)
                    .sheet(isPresented: $showTopicView) {
                        CatBotSheetView(selectedCat: selectedCat ?? 0, onItemSelected: { category in
                            selectedCat = category
                            self.catSelected(category)
                            showTopicView.toggle()
                        })
                    }
                    .sheet(isPresented: $videoCreditsView) {
                        VideoCreditsView(videoCreditsView: $videoCreditsView, videoCreditsVisible: $videoCreditsVisible, videoCreditsText: $videoCreditsText)
                    }
                    
                    
                    
                    RoundedRectangle(cornerRadius: 0)
                        .frame(height: 1)
                        .foregroundColor(Color("GrayThree"))
                        .padding(.top)
                    if isListView {
                        ScrollView{
                            VStack(spacing: 20){
                                
                                ForEach (userNames, id: \.self){ user in
                                    HStack{
                                        Button{
                                            isListView = false
                                            if let lastIndex = description.lastIndex(of: "@") {
                                                let range = lastIndex..<description.endIndex
                                                if range.upperBound == description.endIndex {
                                                    // Append user + " " to the end of the description
                                                    description += user + " "
                                                } else {
                                                    description = description.replacingOccurrences(of: self.subString, with: user + " ", options: [], range: range)
                                                }
                                            }
                                        }label: {
                                            Text(user)
                                                .font(.custom("Urbanist-SemiBold", size: 18))
                                                .foregroundColor(.black)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }else{
                        VStack{
                            VStack(spacing: 20) {
                                HStack {
                                    Image("ProfileLogo")
                                    
                                    Button {
                                        
                                    } label: {
                                        Text("Tag People")
                                            .font(.custom("Urbanist-SemiBold", size: 18))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.leading, 12)
                                    
                                    Spacer()
                                    
                                    Image("ArrowLogo")
                                    
                                }
                                
                                HStack {
                                    Image("LocationLogo")
                                    
                                    Button {
                                        showCountryPicker = true
                                    } label: {
                                        Text("Location")
                                            .font(.custom("Urbanist-SemiBold", size: 18))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.leading, 12)
                                    Spacer()
                                    Text(country?.isoCode.getFlag() ?? "US".getFlag())
                                        .font(.custom("Urbanist-SemiBold", size: 18))
                                        .foregroundColor(.black)
                                    Image("DownArrow")
                                }
                                .sheet(isPresented: $showCountryPicker) {
                                    CountryPicker(country: $country)
                                }
                                
                                HStack {
                                    Image("VisibalLogo")
                                    
                                    Button {
                                        //                                    bottomSheetShown.toggle()
                                        showPrivacySettings.toggle()
                                    } label: {
                                        Text("Visible to \(self.postModel.visibility.rawValue.prefix(1).capitalized + self.postModel.visibility.rawValue.dropFirst())")
                                            .font(.custom("Urbanist-SemiBold", size: 18))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.leading, 12)
                                    
                                    Spacer()
                                    
                                    Image("ArrowLogo")
                                    
                                }
                                
                                HStack {
                                    Image("AllowComment")
                                    
                                    Button {
                                        
                                    } label: {
                                        Text("Allow Comments")
                                            .font(.custom("Urbanist-SemiBold", size: 18))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.leading, 12)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Capsule()
                                            .frame(width:44,height:24)
                                            .foregroundColor(.clear)
                                            .background(toggleOn ?
                                                        LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) :  LinearGradient(colors: [
                                                            Color("grayOne"),
                                                            Color("grayOne"),
                                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(16)
                                        ZStack{
                                            Circle()
                                                .strokeBorder(Color("buttionGradientOne"), lineWidth: 2)
                                                .frame(width:22, height:22)
                                                .overlay(
                                                    Circle()
                                                        .fill(Color.white))
                                        }
                                        .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
                                        .offset(x:toggleOn ? 9.5 : -9.5)
                                    }
                                    .onTapGesture {
                                        self.toggleOn.toggle()
                                        self.postModel.allowComments = self.toggleOn
                                    }
                                    
                                }
                                
                                
                                HStack {
                                    Image("AllowDuet")
                                    
                                    Button {
                                        
                                    } label: {
                                        Text("Allow Duo")
                                            .font(.custom("Urbanist-SemiBold", size: 18))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.leading, 12)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Capsule()
                                            .frame(width:44,height:24)
                                            .foregroundColor(.clear)
                                            .background(toggleOnTwo ?
                                                        LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) :  LinearGradient(colors: [
                                                            Color("grayOne"),
                                                            Color("grayOne"),
                                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(16)
                                        ZStack{
                                            Circle()
                                                .strokeBorder(Color("buttionGradientOne"), lineWidth: 2)
                                                .frame(width:22, height:22)
                                                .overlay(
                                                    Circle()
                                                        .fill(Color.white))
                                        }
                                        .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
                                        .offset(x:toggleOnTwo ? 9.5 : -9.5)
                                    }
                                    .onTapGesture {
                                        self.toggleOnTwo.toggle()
                                        self.postModel.allowDuet = self.toggleOnTwo
                                    }
                                    
                                }
                                
                                
                                HStack {
                                    Image("AllowStitchLogo")
                                    
                                    Button {
                                        
                                    } label: {
                                        Text("Allow Knit")
                                            .font(.custom("Urbanist-SemiBold", size: 18))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.leading, 12)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Capsule()
                                            .frame(width:44,height:24)
                                            .foregroundColor(.clear)
                                            .background(toggleOnThree ?
                                                        LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) :  LinearGradient(colors: [
                                                            Color("grayOne"),
                                                            Color("grayOne"),
                                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(16)
                                        ZStack{
                                            Circle()
                                                .strokeBorder(Color("buttionGradientOne"), lineWidth: 2)
                                                .frame(width:22, height:22)
                                                .overlay(
                                                    Circle()
                                                        .fill(Color.white))
                                        }
                                        .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
                                        .offset(x:toggleOnThree ? 9.5 : -9.5)
                                    }
                                    .onTapGesture {
                                        self.toggleOnThree.toggle()
                                        self.postModel.allowStitch = self.toggleOnThree
                                    }
                                    
                                }
                                
                                
                                HStack {
                                    Image("MoreOptionLogo")
                                    
                                    Button {
                                        bottomSheetMoreOption.toggle()
                                    } label: {
                                        Text("More Option")
                                            .font(.custom("Urbanist-SemiBold", size: 18))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.leading, 12)
                                    
                                    Spacer()
                                    
                                    Image("ArrowLogo")
                                    
                                }
                                
                            }
                            .padding(.top)
                            
                            HStack {
                                Text("Automatically share to:")
                                    .font(.custom("Urbanist-Bold", size: 18))
                                Spacer()
                                
                            }
                            .padding(.top)
                            
                            HStack {
                                ForEach(SocialMediaType.allCases, id: \.self) { type in
                                    SocialMediaIconView(type: type, selectedType: $selectedType)
                                }
                                Spacer()
                            }
                            .padding(.top)
                            
                            HStack {
                                Button {
                                    loadingVideo = true
                                    simulateVideoDownload()
                                    
                                } label: {
                                    Spacer()
                                    HStack {
                                        
                                        Image("DraftLogo")
                                        
                                        Text("Drafts")
                                            .font(.custom("Urbanist-Bold", size: 16))
                                            .foregroundStyle(
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                            .padding()
                                    }
                                    Spacer()
                                }
                                .background(Color("SkipButtonBackground"))
                                .cornerRadius(40)
                                
                                Spacer()
                                Spacer()
                                
                                Button {
                                    loader.toggle()
                                    uploadingVideo = true
                                    if (postModel.description == ""){
                                        print("Description should not be nil")
                                        loader = false
                                        uploadingVideo = false
                                        showMessagePopup(messages: "Description Needed")
                                        return
                                    }
                                    
                                    guard let selectedCat = selectedCat, selectedCat != 0 else {
                                        print("Category should be selected")
                                        loader = false
                                        uploadingVideo = false
                                        showMessagePopup(messages: "Category Needed")
                                        return
                                    }
                                    if let audioURL = postModel.songModel?.preview {
                                        mergeVideoAndAudio(videoUrl: renderUrl!, audioUrl: URL(string: audioURL)!) { error, url in
                                            guard let url = url else {
                                                print("Error merging video and audio.")
                                                return
                                            }
                                            print("Video and audio merge completed, new URL: \(url.absoluteString)")
                                            DispatchQueue.main.async {
                                                renderUrl = url
                                                uploadReelss { isSuccess in
                                                    if isSuccess == true {
                                                        if (self.saveToDevice){
                                                            print("saving video to device: " + self.saveToDevice.description)
                                                            showMessagePopup(messages: "Saving Video")
                                                            Task {
                                                                DispatchQueue.main.async{
                                                                    for videoUrl in uploadReels.contentDetail {
                                                                        if let url = URL(string: videoUrl.name), url.pathExtension.lowercased() == "mp4" {
                                                                            downloadAndSaveWithCaptionVideo(videoUrl: url.absoluteString){ success in
                                                                                if success == true{
                                                                                    print("video is Saved")
                                                                                    showMessagePopup(messages: "Video Saved")
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                                                        loader = false
                                                                                        goBackToHome()
                                                                                        uploadProgress = 0.0
                                                                                        uploadingVideo = false
                                                                                    }
                                                                                }else{
                                                                                    print("Errror Saving Video.....")
                                                                                    showMessagePopup(messages: "Error Saving Video")
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                                                        loader = false
                                                                                        goBackToHome()
                                                                                        uploadProgress = 0.0
                                                                                        uploadingVideo = false
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }else{
                                                            goBackToHome()
                                                            loader = false
                                                            uploadProgress = 0.0
                                                            uploadingVideo = false
                                                        }
                                                        if (selectedType != nil){
                                                            DispatchQueue.main.async{
                                                                print("Sharing To cocial Media")
                                                                for videoUrl in uploadReels.contentDetail {
                                                                    if let url = URL(string: videoUrl.name), url.pathExtension.lowercased() == "mp4" {
                                                                        let videoURL =  URL(string: getImageVideoBaseURL + "/marked" + url.absoluteString)
                                                                        print("shareable Url \(String(describing: videoURL))")
                                                                        shareToFacebook(videoURL: videoURL!)
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    } else {
                                                        print("failed==========")
                                                        isShowPopup = true
                                                        uploadProgress = 0.0
                                                        uploadingVideo = false
                                                        showMessagePopup(messages: "Faild To Uplaod Video")
                                                        loader = false
                                                    }
                                                }
                                            }
                                        }
                                    } else{
                                        if let audioUrl = Bundle.main.url(forResource: "audio", withExtension: "mp3") {
                                            mergeVideoAndAudio(videoUrl: renderUrl!, audioUrl: audioUrl) { error, url in
                                                guard let url = url else {
                                                    print("Error merging video and audio.")
                                                    return
                                                }
                                                print("Video and audio merge completed, new URL: \(url.absoluteString)")
                                                DispatchQueue.main.async {
                                                    renderUrl = url
                                                    uploadReelss { isSuccess in
                                                        if isSuccess == true {
                                                            if (self.saveToDevice){
                                                                print("saving video to device: " + self.saveToDevice.description)
                                                                showMessagePopup(messages: "Saving Video")
                                                                Task {
                                                                    DispatchQueue.main.async{
                                                                        for videoUrl in uploadReels.contentDetail {
                                                                            if let url = URL(string: videoUrl.name), url.pathExtension.lowercased() == "mp4" {
                                                                                downloadAndSaveWithCaptionVideo(videoUrl: url.absoluteString){ success in
                                                                                    if success == true{
                                                                                        print("video is Saved")
                                                                                        showMessagePopup(messages: "Video Saved")
                                                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                                                            loader = false
                                                                                            goBackToHome()
                                                                                            uploadProgress = 0.0
                                                                                            uploadingVideo = false
                                                                                        }
                                                                                    }else{
                                                                                        print("Errror Saving Video.....")
                                                                                        showMessagePopup(messages: "Error Saving Video")
                                                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                                                            loader = false
                                                                                            goBackToHome()
                                                                                            uploadProgress = 0.0
                                                                                            uploadingVideo = false
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }else{
                                                                goBackToHome()
                                                                loader = false
                                                                uploadProgress = 0.0
                                                                uploadingVideo = false
                                                            }
                                                            if (selectedType != nil){
                                                                DispatchQueue.main.async{
                                                                    print("Sharing To cocial Media")
                                                                    for videoUrl in uploadReels.contentDetail {
                                                                        if let url = URL(string: videoUrl.name), url.pathExtension.lowercased() == "mp4" {
                                                                            let videoURL =  URL(string: getImageVideoBaseURL + "/marked" + url.absoluteString)
                                                                            print("shareable Url \(String(describing: videoURL))")
                                                                            shareToFacebook(videoURL: videoURL!)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        } else {
                                                            print("failed==========")
                                                            isShowPopup = true
                                                            uploadProgress = 0.0
                                                            uploadingVideo = false
                                                            showMessagePopup(messages: "Faild To Uplaod Video")
                                                            loader = false
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                } label: {
                                    Spacer()
                                    HStack {
                                        
                                        Image("PostLogo")
                                        
                                        Text("Post")
                                            .font(.custom("Urbanist-Bold", size: 16))
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                    Spacer()
//                                    NavigationLink(destination: HomePageView()
//                                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $homeView) {
//                                            EmptyView()
//                                        }
                                }
                                .background(
                                    LinearGradient(colors: [
                                        Color("buttionGradientTwo"),
                                        Color("buttionGradientOne"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .cornerRadius(40)
                                
                            }
                            .padding(.top, 20)
                            
                        }}
                    
                }
                .padding(.horizontal)
                //                .navigationBarHidden(true)
                //            } CustomeSheetMoreOtptions
                
                
                .overlay{
                    if loadingVideo {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                            .overlay(
                                ZStack {
                                    CircularProgressView(progress: progress)
                                    Text("\(Int(progress * 100))%")
                                        .font(.custom("Urbanist-Regular", size: 22))
                                        .bold()
                                }
                                    .frame(width: 60, height: 60)
                            )
                    }
                    if(self.showPrivacySettings)
                    {
                        PostVisibilityView(
                            currentVisibility: self.postModel.visibility,
                            callback:{type in
                                self.showPrivacySettings = false
                                self.postModel.visibility = type
                            }
                        )
                    }
                }
            }
            .onTapGesture{
                isFocused = false
                self.postModel.description = description
            }
            if bottomSheetShown {
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        bottomSheetShown.toggle()
                    }
            }
            if uploadingVideo {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack{
                            ZStack {
                                UploadProgressView(progress: uploadProgress)
                                    .frame(width: 60, height: 60)
                                Text("\(Int(uploadProgress * 100))%")
                                    .font(.custom("Urbanist-Regular", size: 20))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            Text("Uploading....")
                                .font(.custom("Urbanist-Regular", size: 20))
                                .foregroundColor(.white)
                        }
                            .frame(width: 120, height: 200)
                            .background(LinearGradient(colors: [
                                Color("buttionGradientTwo"),
                                Color("buttionGradientOne"),
                                Color("buttionGradientOne"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                    )
            }
            
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
            
            // More Option
            if bottomSheetMoreOption {
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        bottomSheetMoreOption.toggle()
                    }
            }
            
            GeometryReader { geometry in
                BottomSheetView(
                    isOpen: self.$bottomSheetMoreOption,
                    maxHeight: geometry.size.height * 0.3
                ) {
                    CustomeSheetMoreOtptions(
                        saveToDevice: {val in
                            self.saveToDevice = val
                        }, autoCation: {val in
                            self.autoCaption = val
                        }, captionLang: {val in
                            self.captionLang = val
                        })
                    
                }
            }.edgesIgnoringSafeArea(.all)
            
        }
        .onTapGesture {
            focusedField = nil
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func goBackToHome() {
        reelsVM.getAllReels()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.shouldPopToRootView = false
        }
    }
    
    func shareSocially(){
        if (selectedType != nil){
            DispatchQueue.main.async{
                print("Sharing To cocial Media")
                for videoUrl in uploadReels.contentDetail {
                    if let url = URL(string: videoUrl.name), url.pathExtension.lowercased() == "mp4" {
                        let videoURL =  URL(string: getImageVideoBaseURL + "/marked" + url.absoluteString)
                        print("shareable Url \(String(describing: videoURL))")
                        shareToFacebook(videoURL: videoURL!)
                    }
                }
            }
        }
    }
    
    func mergeVideoAndAudio(videoUrl: URL,audioUrl: URL,shouldFlipHorizontally: Bool = false,
                            completion: @escaping (_ error: Error?, _ url: URL?) -> Void) {
        
        
        let mixComposition = AVMutableComposition()
        var mutableCompositionVideoTrack = [AVMutableCompositionTrack]()
        var mutableCompositionAudioTrack = [AVMutableCompositionTrack]()
        var mutableCompositionAudioOfVideoTrack = [AVMutableCompositionTrack]()
        
        //start merge
        
        let aVideoAsset = AVAsset(url: videoUrl)
        let aAudioAsset = AVAsset(url: audioUrl)
        let compositionAddVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        
        let compositionAddAudio = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
        
        let compositionAddAudioOfVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
        
        let first = CMTimeRange(start: CMTime.zero, duration: aVideoAsset.duration)
        let fullRange = CMTimeRange(start: CMTime.zero, duration: CMTime(value: aVideoAsset.duration.value, timescale: CMTimeScale(speed)))
        compositionAddVideo?.scaleTimeRange(first, toDuration: fullRange.duration)
        compositionAddAudio.scaleTimeRange(first, toDuration: fullRange.duration)
        compositionAddAudioOfVideo.scaleTimeRange(first, toDuration: fullRange.duration)
        
        let aVideoAssetTrack: AVAssetTrack = aVideoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let aAudioOfVideoAssetTrack: AVAssetTrack? = aVideoAsset.tracks(withMediaType: AVMediaType.audio).first
        let aAudioAssetTrack: AVAssetTrack = aAudioAsset.tracks(withMediaType: AVMediaType.audio)[0]
        
        // Default must have tranformation
        compositionAddVideo?.preferredTransform = aVideoAssetTrack.preferredTransform
        
        if shouldFlipHorizontally {
            // Flip video horizontally
            var frontalTransform: CGAffineTransform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            frontalTransform = frontalTransform.translatedBy(x: -aVideoAssetTrack.naturalSize.width, y: 0.0)
            frontalTransform = frontalTransform.translatedBy(x: 0.0, y: -aVideoAssetTrack.naturalSize.width)
            compositionAddVideo?.preferredTransform = frontalTransform
        }
        
        mutableCompositionVideoTrack.append(compositionAddVideo!)
        mutableCompositionAudioTrack.append(compositionAddAudio)
        mutableCompositionAudioOfVideoTrack.append(compositionAddAudioOfVideo)
        
        
        do {
            try mutableCompositionVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                duration: aVideoAssetTrack.timeRange.duration),
                                                                of: aVideoAssetTrack,
                                                                at: CMTime.zero)
            
            //In my case my audio file is longer then video file so i took videoAsset duration
            //instead of audioAsset duration
            try mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                duration: aVideoAssetTrack.timeRange.duration),
                                                                of: aAudioAssetTrack,
                                                                at: CMTime.zero)
            
            // adding audio (of the video if exists) asset to the final composition
            if let aAudioOfVideoAssetTrack = aAudioOfVideoAssetTrack {
                try mutableCompositionAudioOfVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                           duration: aVideoAssetTrack.timeRange.duration),
                                                                           of: aAudioOfVideoAssetTrack,
                                                                           at: CMTime.zero)
            }
            
        } catch {
            print(error.localizedDescription)
        }

        // Exporting
        let savePathUrl: URL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/\(Date()).mp4")
        do { // delete old video
            try FileManager.default.removeItem(at: savePathUrl)
        } catch { print(error.localizedDescription) }
        
        let assetExport: AVAssetExportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)!
        assetExport.outputFileType = AVFileType.mp4
        assetExport.outputURL = savePathUrl
        assetExport.shouldOptimizeForNetworkUse = true
        
        
        assetExport.exportAsynchronously { () -> Void in
            switch assetExport.status {
            case AVAssetExportSession.Status.completed:
                print("success")
                completion(nil, savePathUrl)
            case AVAssetExportSession.Status.failed:
                print("failed \(assetExport.error?.localizedDescription ?? "error nil")")
                completion(assetExport.error, nil)
            case AVAssetExportSession.Status.cancelled:
                print("cancelled \(assetExport.error?.localizedDescription ?? "error nil")")
                completion(assetExport.error, nil)
            default:
                print("complete")
                completion(assetExport.error, nil)
            }
        }
        
    }
    func simulateVideoDownload() {
        DispatchQueue.global(qos: .background).async {
            let totalProgressSteps = 10
            for i in 0..<totalProgressSteps {
                usleep(100_000) // Simulating delay in video download
                
                DispatchQueue.main.async {
                    progress = Double(i + 1) / Double(totalProgressSteps)
                    
                    if i == totalProgressSteps - 1 {
                        // Download completed
                        loadingVideo = false
                        print("Video download completed")
                        
                        // Call the function to save the video or image to the gallery here
                        saveVideoToGallery()
                    }
                }
            }
        }
    }
    
    func saveVideoToGallery(){
        print("Should save to device: "+self.saveToDevice.description)
        guard let renderUrl = self.renderUrl else{
            print("incorrect url, can't save to gallery")
            return
        }
        print("saving to device, url: " + renderUrl.absoluteString)
        if(self.postModel.isImageContent())
        {
            let data = try? Data(contentsOf: renderUrl)
            let image = UIImage(data: data!)
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
        else{
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: renderUrl)
            }) { complete, error in
                if complete {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        print("Saved to gallery")
                    }
                }
            }
        }
    }
    func shareToFacebook(videoURL: URL) {
        let activityItems: [Any] = [videoURL, self.description]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    func showMessagePopup(messages: String) {
        self.message = messages
        self.isShowPopup = true
    }
    
    func extractImageFromVideo(url: URL, completion: @escaping (UIImage?) -> Void) {
        let asset = AVAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        
        generator.appliesPreferredTrackTransform = true
        let time = CMTime(seconds: 0, preferredTimescale: 1)
        
        generator.generateCGImagesAsynchronously(forTimes: [NSValue(time: time)]) { _, image, _, _, _ in
            guard let cgImage = image else {
                completion(nil)
                return
            }
            
            let uiImage = UIImage(cgImage: cgImage)
            completion(uiImage)
        }
    }
    
    private func uploadReelss(completionHandler: @escaping (Bool) -> Void) {
        //    self.postModel.contentUrl = self.renderUrl
        
        if (autoCaption == true) {
            self.subAllow = "true"
            self.subLang = captionLang
        } else {
            self.subAllow = "false"
        }
        
        var overallProgress: Double = 0.0
        
        uploadReels.uploadReels(imageUploadRequest: renderUrl!, paramName: "asset", fileName: renderUrl?.lastPathComponent ?? "default.\(postModel.isImageContent() ? "png" : "mp4")", subtitleLang: self.subLang, subtitle_apply: subAllow, progress: { reelProgress in
            self.reelProgress = reelProgress // Update reelProgress with the latest progress
            
            overallProgress = (self.reelProgress + self.uploadProgress)
            
            // Update uploadProgress within the animation block to ensure smooth animation
            UIView.animate(withDuration: 0.3) {
                self.uploadProgress = overallProgress
            }
        }, complitionHandler: { responsee, errorMessage in
            if (!responsee || errorMessage == nil) {
                uploadProgress = 0.0
                uploadingVideo = false
                print("error uploading video \(String(describing: errorMessage))")
                completionHandler(false)
                return
            }
            
            print("video url \(self.postModel.contentUrl!)")
            let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
            var tag: [String] = []
            self.postModel.tagPeople.forEach { peopleId in
                tag.append(peopleId.uid)
            }
            let musicUrl = UserDefaults.standard.string(forKey: "musicUrl") ?? ""
            print("The musicUrl is======", musicUrl)
            //                let content = ContentDetail(name: fileName, size: reelsSize, thumbnails: thumbnails, thumbsize: thumbsize)
            print("caption and lan: ", self.captionLang, self.autoCaption)
            let postRes = ReelsPostRequest(userUUID: uuid, title: postModel.description, description: self.postModel.description, contentType: postModel.isImageContent() ? "image" : "video", category: self.selectedCat, musicTrack: postModel.songModel?.title, location: "Karachi Sindh Pakistan", visibility: "public", musicURL: musicUrl, content: uploadReels.contentDetail, allowComment: self.postModel.allowComments, allowDuet: self.postModel.allowDuet, allowStitch: self.postModel.allowStitch, subtitleApply: self.autoCaption, subtitleLang: self.captionLang, tags: tag)
            
            uploadReels.uploadPost(post: postRes, progress: { reelProgress in
//                self.reelProgress = reelProgress/2   // Update reelProgress with the latest progress
                
//                overallProgress = (self.reelProgress)
                
                // Update uploadProgress within the animation block to ensure smooth animation
                UIView.animate(withDuration: 0.3) {
//                    self.uploadProgress = overallProgress
                }
            }) { response, error in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if response == true {
                        print("Success......")
                        completionHandler(true)
                    } else {
                        print("Error.....")
                        completionHandler(false)
                    }
                }
            }
        })
    }
}

enum SocialMediaType: String, CaseIterable {
    case WhatsApp
    case Instagram
    case Facebook
    case Twetter
}
struct SocialMediaIconView: View {
    let type: SocialMediaType
    @Binding var selectedType: SocialMediaType?
    
    var isSelected: Bool {
        selectedType == type
    }
    
    var body: some View {
        Image("\(type.rawValue)Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .opacity(isSelected ? 1.0 : 0.5)
            .overlay(
                Circle()
                    .strokeBorder(isSelected ? LinearGradient(colors: [Color("buttionGradientTwo"), Color("buttionGradientOne")], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
            )
            .onTapGesture {
                if isSelected {
                    selectedType = nil
                } else {
                    selectedType = type
                }
            }
    }
}

struct ExtractedImageView: View {
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaledToFill()
            .frame(width: 100, height: 132)
    }
}
struct CircularProgressView: View {
    let progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(0.5),
                    lineWidth: 5
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color("buttionGradientTwo"),
                            Color("buttionGradientOne"),
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
        }
    }
}


struct UploadProgressView: View {
    let progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(0.5),
                    lineWidth: 5
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.white,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
        }
    }
}
