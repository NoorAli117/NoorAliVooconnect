//
//  FinalVideoToPostView.swift
//  Vooconnect
//
//  Created by Vooconnect on 06/12/22.
// ReelsPostViewModel

import SwiftUI
import Photos

struct FinalVideoToPostView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    @State private var navigateToNextView = false
    @State private var showPreview = false
    @State private var bottomSheetShown = false
    @State private var bottomSheetMoreOption = false
    @State private var homeView = false
    @State var text2: String = ""
    @State var description: String = ""
    
    @State var text = ""
    @State var didStartEditing = false
    
    @State var placeholder: String = "Hi everyone, in this video I will sing a song #song #music #love #beauty Thanks to @Vooconnect Video credit to"
    
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
    
    //    var url: URL
    @State var postModel : PostModel
    @State var renderUrl : URL?
    @State private var saveToDevice = false
    @State private var videoData: Data?
    
    init(postModel : PostModel, renderUrl : URL?){
        _postModel = State(initialValue: postModel)
        _renderUrl = State(initialValue: renderUrl)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                //                NavigationView {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
                    NavigationLink(destination: HomePageView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $homeView) {
                            EmptyView()
                        }
                    
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Post")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    //                    .padding(.leading)
                    
                    ScrollView(showsIndicators: false) {
                        
                        HStack {
                            
                            //                            Text("Hi everyone, in this video I will sing a song #song #music #love #beauty Thanks to @Vooconnect Video credit to ")
                            
                            //                            TextView(text: $text2).frame(numLines: 5)
                            //                            TextViewTwo(text: $description, didStartEditing: $didStartEditing, placeholder: $placeholder
                            //                            )
                            TextField(placeholder, text: $description)
                                .focused($focusedField, equals: .captionn)
                                .onChange(of: description){val in
                                    print("ON CHANGE DESCRIPTION: " + self.postModel.description)
                                    self.postModel.description = val
                                }
                                .onTapGesture {
                                    didStartEditing = true
                                }
                            
                            
                                .padding(.horizontal)
                                .padding(.top, 5)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .strokeBorder((LinearGradient(colors: [
                                            Color("GradientOne"),
                                            Color("GradientTwo"),
                                        ], startPoint: .top, endPoint: .bottom)
                                        ), lineWidth: 2)
                                        .frame(height: 136)
                                }
                                .padding(.trailing)
                            
                            //                            Image("SelectCover")
                            testCover()
                                .cornerRadius(15)
                            
                            
                        }
                        .padding(.top,2)
                        
                        
                        
                        // Hastag
                        HStack {
                            
                            HStack {
                                
                                Image("HastagLogo")
                                
                                Button {
                                    self.description = self.postModel.description + "/n" + " #"
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
                                    self.description = self.postModel.description + " @"
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
                                
                                Image("VideoLogo")
                                
                                Button {
                                    
                                } label: {
                                    Text("Videos")
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
                                
                                Image("CategorieLogo")
                                
                                Button {
                                    
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
                        
                        
                        
                        RoundedRectangle(cornerRadius: 0)
                            .frame(height: 1)
                            .foregroundColor(Color("GrayThree"))
                            .padding(.top)
                        
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
                                    
                                } label: {
                                    Text("Location")
                                        .font(.custom("Urbanist-SemiBold", size: 18))
                                        .foregroundColor(.black)
                                }
                                .padding(.leading, 12)
                                
                                Spacer()
                                
                                Image("ArrowLogo")
                                
                            }
                            
                            HStack {
                                Image("VisibalLogo")
                                
                                Button {
                                    bottomSheetShown.toggle()
                                } label: {
                                    Text("Visible to Everyone")
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
                                    Text("Allow Duet")
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
                                    Text("Allow Stitch")
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
                        
                        HStack{
                            Image("WhatsAppLogo")
                            Image("InstagramLogo")
                            Image("FacebookLogo")
                            Image("TwetterLogo")
                            Spacer()
                        }
                        .padding(.top)
                        
                        HStack {
                            Button {
                                
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
                                //                                print("Should save to device: "+self.saveToDevice.description)
                                //                                if(self.saveToDevice){
//                                                                    guard let renderUrl = self.renderUrl else{
//                                                                        print("incorrect url, can't save to gallery")
//                                                                        return
//                                                                    }
//                                                                    print("saving to device, url: " + renderUrl.absoluteString)
//                                                                    if(self.postModel.isImageContent())
//                                                                    {
//                                                                        let data = try? Data(contentsOf: renderUrl)
//                                                                        let image = UIImage(data: data!)
//                                                                        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
//                                                                    }
//                                                                    else{
//                                                                        PHPhotoLibrary.shared().performChanges({
//                                                                            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: renderUrl)
//                                                                        }) { complete, error in
//                                                                            if complete {
//                                                                                print("Saved to gallery")
//                                                                            }
//                                                                        }
//                                                                    }
                                //                                }
                                uploadReelss { isSuccess in
                                    if isSuccess {
                                        print("success=========")
                                        navigateToNextView = true
                                        //                                        if (self.saveToDevice){
                                        //                                            let fileName = UserDefaults.standard.string(forKey: "imageName") ?? ""
                                        //                                            let videoURL = URL(string: getImageVideoBaseURL + "/marked" + fileName)!
                                        //                                            print(videoURL)
                                        //                                            //                            downloadAndSaveVideo(videoURL: videoURL)
//                                                                                    downloadVideoFromURL(url: videoURL) { videoURL, error in
                                        //                                                if let videoURL = videoURL {
                                        //                                                    DispatchQueue.main.async{
                                        //                                                        saveVideoToPhotosLibrary(videoURL: videoURL)
                                        //                                                    }
                                        //                                                } else if let error = error {
                                        //                                                    print("Error downloading video: \(error.localizedDescription)")
                                        //                                                }
                                        //                                            }
                                        //                                        }
                                        
                                        print("Should save to device: "+self.saveToDevice.description)
                                        if(self.saveToDevice){
                                            downloadVideo()
                                        }
                                            
                                            //                                        reelsPostVM.uploadReelsDetails()
                                            
                                        } else {
                                            print("failed==========")
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
                                    NavigationLink(destination: HomePageView()
                                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $navigateToNextView) {
                                            EmptyView()
                                        }
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
                            
                        }
                        //                    .toolbar(content: {
                        //                        ToolbarItem(placement: .keyboard) {
                        //                            Spacer()
                        //                        }
                        //                        ToolbarItem(placement: .keyboard) {
                        //                            Button("Done") {
                        //                                focusedField = nil
                        //                            }
                        //                        }
                        //                    })
                        
                    }
                    .padding(.horizontal)
                    //                .navigationBarHidden(true)
                    //            } CustomeSheetMoreOtptions
                    
                    if bottomSheetShown {
                        Rectangle()
                            .fill(Color.black)
                            .opacity(0.7)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                bottomSheetShown.toggle()
                            }
                    }
                    
                    GeometryReader { geometry in
                        BottomSheetView(
                            isOpen: self.$bottomSheetShown,
                            maxHeight: geometry.size.height * 0.5
                        ) {
                            CustomeSheetView(callback: {type in
                                self.postModel.visibility = type
                                print("type of visibility")
                                print(self.postModel.visibility)
                            })
                        }
                    }.edgesIgnoringSafeArea(.all)
                    
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
                                }
                            )
                            
                        }
                    }.edgesIgnoringSafeArea(.all)
                    
                }
                .onTapGesture {
                    focusedField = nil
                }
                .navigationBarHidden(true)
            }
        }
        
        func testCover() -> some View{
            let data = try? Data(contentsOf: self.renderUrl!)
            let image = UIImage(data: data!)
            return Image(uiImage: image ?? UIImage(imageLiteralResourceName: "SelectCover"))
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 132)
        }
        
        //    func stickerView(content : ContentOverlayModel) -> some View{
        //        Image(content.value)
        //            .resizable()
        //            .scaledToFit()
        //            .frame(width: 100 * content.scale, height: 100 * content.scale)
        ////            .offset(content.size)
        ////            .offset(CGSize(width: -content.size.width, height: -content.size.height))
        //    }
        //
        //    func textView(content : ContentOverlayModel) -> some View{
        //        Text(content.value)
        //            .urbanistBlack(fontSize: content.fontSize)
        //            .foregroundColor(content.color == .white ? .black : .white)
        //            .padding(.horizontal,12)
        //            .padding(.vertical,8)
        //            .background{
        //                if(content.enableBackground){
        //                    content.color
        //                        .cornerRadius(16)
        //                }
        //            }
        //            .fixedSize()
        //            .frame(maxWidth: UIScreen.main.screenWidth() - 36)
        //    }
        
        private func uploadReelss(complitionHandler : @escaping(Bool) -> Void) {
            self.postModel.contentUrl = self.renderUrl
            uploadReels.uploadReels(imageUploadRequest: self.postModel.contentUrl!, paramName: "asset", fileName: renderUrl?.lastPathComponent ?? "default.\(postModel.isImageContent() ? "png" : "mp4")") { responsee, errorMessage in
                if(!responsee || errorMessage == nil)
                {
                    
                    print("error uploading video")
                    complitionHandler(false)
                    return
                }
                let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
                let reelsSize = UserDefaults.standard.string(forKey: "reelSize") ?? ""
                let fileName = UserDefaults.standard.string(forKey: "imageName") ?? ""
                var tag: [String] = []
                self.postModel.tagPeople.forEach { peopleId in
                    tag.append(peopleId.uid)
                }
                let content = ContentDetail(name: fileName, size: reelsSize)
                let postRes = ReelsPostRequest(userUUID: uuid, title: "ok", description: self.postModel.description, contentType: postModel.isImageContent() ? "image" : "video", category: 2, musicTrack: postModel.songModel?.title, location: postModel.location.id, visibility: "public", musicURL: postModel.songModel?.preview, content: [content], allowComment: self.postModel.allowComments, allowDuet: self.postModel.allowDuet, allowStitch: self.postModel.allowStitch, tags: tag )
                uploadReels.uploadPost(post: postRes, complitionHandler: {response, error in
                    DispatchQueue.main.async {
                        if(responsee == true) {
                            print("Sucessss......")
                            complitionHandler(true)
                            
                        } else {
                            print("Errror.....")
                            complitionHandler(false)
                        }
                    }
                })
            }
        }
    }

//struct FinalVideoToPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        FinalVideoToPostView(url: URL (string: "http://www.example.com/image.jpg")!)
//    }
//}
//getImageVideoBaseURL + "/marked" + fileName
