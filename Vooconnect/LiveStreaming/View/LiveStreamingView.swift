//
//  LiveStreamingView.swift
//  Vooconnect
//
//  Created by Vooconnect on 21/12/22.
//

import SwiftUI
import AgoraVideoSwiftUI
import AgoraRtcKit


struct LiveStreamingView: View {
    
    //Agora Start
    @State var isLocalInSession = false
    @State var isLocalAudioMuted = false
    
    @State var isRemoteInSession = false
    @State var isRemoteVideoMuted = true
    
    let localCanvas = VideoCanvas()
    let remoteCanvas = VideoCanvas()
    
    private let videoEngine = HostVideoEngine()
    private var rtcEngine: AgoraRtcEngineKit {
        get {
            return videoEngine.agoraEngine
        }
    }
    
    @State var idArr = [UInt]()
    //Agora End
    
    @StateObject var cameraModel = CameraViewModel()
    
    @Environment(\.presentationMode) var presentaionMode
    
    
    @State private var hideEditingParentView: Bool = false
    @State private var flash: Bool = false
    @State private var beauty: Bool = false
    @State private var filter: Bool = false
    @State private var effects: Bool = false

    @State var countdownTimerText = 5
    @State var countdownTimer = 5
    @State var inviteSheet: Bool = false
    @State var shareSheet: Bool = false
    @State var settingSheet: Bool = false
    @State var creatorDetaiSheet: Bool = false
    
    @State var goLiveToFollowers: Bool = false
    @State var goLiveToPlanOne: Bool = true
    @State var goLiveToPlanTwo: Bool = true
    
    @State var goToLive: Bool = false
    @State var titleToggle: Bool = false
    @State var titleValue: String = ""
    @FocusState private var titleFocused: Bool

    @State private var questionAnswerSheet: Bool = false
    
    @State private var comment: String = ""
    @State private var commentFocused: Bool = false
    @State private var isEmoji: Bool = false
    
    @State private var selectedTopic: String?
    
    @State var showTopicView = false
    @State private var alert: Bool = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                ZStack {

                    if idArr.count <= 0 {
                        VideoSessionView(
                            backColor: Color("remoteBackColor"),
                            backImage: Image("vooconnectLogo"),
                            hideCanvas: !isLocalInSession,
                            canvas: localCanvas
                        )
                        //.edgesIgnoringSafeArea(.all)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(.top, -50)
                        .padding(.bottom,35)
                        .onTapGesture {
                            if titleValue.isEmpty == false {
                                UserDefaults.standard.setValue(titleValue, forKey: UserdefaultsKey.streamTitle)
                            }
                            titleToggle = false
                            titleFocused = false
                        }
                    } else {
                        VideoSessionView(
                            backColor: Color("remoteBackColor"),
                            backImage: Image("vooconnectLogo"),
                            hideCanvas: isRemoteVideoMuted || !isRemoteInSession || !isLocalInSession,
                            canvas: remoteCanvas
                        )
                        //.edgesIgnoringSafeArea(.all)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(.top, -50)
                        .padding(.bottom,35)
                        .onTapGesture {
                            if titleValue.isEmpty == false {
                                UserDefaults.standard.setValue(titleValue, forKey: UserdefaultsKey.streamTitle)
                            }
                            titleToggle = false
                            titleFocused = false
                        }
                    }
                    
//                    VStack {
//                        HStack {
//                            Spacer()
//                            VideoSessionView(
//                                backColor: Color("remoteBackColor"),
//                                backImage: Image("vooconnectLogo"),
//                                hideCanvas: !isLocalInSession,
//                                canvas: remoteCanvas
//                            ).edgesIgnoringSafeArea(.all)
//                        }
//                        Spacer()
//                    }
                    
                    // BackButton
                    HStack {
                        Spacer()
                        if goToLive {
                            Text("LIVE")
                                .frame(width: percentWidth(percentage: 25), height: 40, alignment: .center)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(20)
                                .blinking()
                                .padding(.leading, 35)
                            
                        }
                        
                        Spacer()
                        Button {
//                            agoraManager.engine.leaveChannel()
                            leaveChannel()
                            UserDefaults.standard.removeObject(forKey: UserdefaultsKey.streamTitle)
                            UserDefaults.standard.removeObject(forKey: UserdefaultsKey.selectedTopics)
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("CameraBack")
                                .frame(width: 25, height: 25)
                        }
                        
                    }
                    .frame(maxHeight: .infinity,alignment: .top)
                    .padding(.trailing)
                    
                    // Add Title
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image("CategoriesTwoLS")
                                    if titleToggle == false {
                                        if titleValue.isEmpty == false {
                                            Text(titleValue)
                                                .font(.custom("Urbanist-SemiBold", size: 14))
                                                .foregroundColor(.white)
                                        } else {
                                            Text("Add Title")
                                                .font(.custom("Urbanist-SemiBold", size: 14))
                                                .foregroundColor(.white)
                                        }
                                    } else {
                                        TextField("Add Title", text: $titleValue)  //SemiBold
                                            .focused($titleFocused)
                                            .font(.custom("Urbanist-SemiBold", size: 14))
                                            .foregroundColor(.white)
                                            .fixedSize()
                                    }
                                    Button {
                                        if titleValue.isEmpty == false {
                                            UserDefaults.standard.setValue(titleValue, forKey: UserdefaultsKey.streamTitle)
                                        }
                                        if titleToggle == false {
                                            titleToggle = true
                                            titleFocused = true
                                        } else {
                                            titleToggle = false
                                            titleFocused = false
                                        }
                                    } label: {
                                        Image("CategoriesThreeLS")
                                    }
                                    
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color(#colorLiteral(red: 0.2694437504, green: 0.284270972, blue: 0.3148175478, alpha: 0.6004501242)))
                                .cornerRadius(20)
                                
                                HStack {
                                    //                                NavigationLink {
                                    //                                    showTopicView = true
                                    //                                } label: {
                                    Image("CategoriesFourLS")
                                    Text(selectedTopic ?? "Choose a Topic")
                                        .font(.custom("Urbanist-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                    Button {
                                        showTopicView = true
                                    } label: {
                                        Image(selectedTopic == nil ? "CategoriesFiveLS" : "CheckBoxLogoM")
                                        //                                        if selectedTopic == nil {
                                        //                                            Image("CategoriesFiveLS")
                                        //                                        } else {
                                        //                                            Image("CheckBoxLogoM")
                                        //                                        }
                                    }
                                    //                                }
                                    
                                    
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color(#colorLiteral(red: 0.2694437504, green: 0.284270972, blue: 0.3148175478, alpha: 0.6004501242)))
                                .cornerRadius(20)
                            }
                            Spacer()
                            
                        }
                        .frame(maxHeight: .infinity,alignment: .top)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        
                        if goToLive {
                            
                            VStack {
                                ScrollView(showsIndicators: false) {
                                    
                                    LazyVGrid(columns: gridLayoutCommentLS, alignment: .center, spacing: columnSpacingCommentLS, pinnedViews: []) {
                                        Section()
                                        {
                                            ForEach(0..<8) { people in
                                                CommentListOnLive(creatorDetaiSheet: $creatorDetaiSheet)
                                            }
                                        }
                                    }
                                }
                                .frame(height: percentHeight(percentage: 22))
                            }
//                            .background(
//                                Color.white
//                            )
//                            .padding(.top, 500)
                            
                            .frame(alignment: .bottom)
                            .padding(.leading)
                            .padding(.bottom, 250)
                            .mask(LinearGradient(gradient: Gradient(stops: [
                                        .init(color: .clear, location: 0),
                                        .init(color: .black, location: 0.25),
                                        .init(color: .black, location: 0.75),
                                        .init(color: .clear, location: 1)
                                    ]), startPoint: .top, endPoint: .bottom))
                        }
                    }
                    
                    // Flip
                    if hideEditingParentView == false {
                        HStack {
                            
                            Spacer()
                            // Flip
                            VStack {
                                
                                VStack(spacing: 12) {
                                    
                                    // Flip
                                    VStack {
                                        
                                        Text("Flip")
                                            .font(.custom("Urbanist-Regular", size: 10))
                                            .foregroundColor(.white)
                                            .padding(.bottom, -5)
                                        Button {
                                            
                                            print("Flip===========")
                                            
                                            //                                        if goToLive {
                                            switchCamera()
                                            //                                        } else {
                                            self.cameraModel.isBackCamera.toggle()
                                            //                                        }
                                            //                                        self.cameraModel.isBackCamera.toggle()
                                            //                                        if self.cameraModel.isBackCamera == false {
                                            //                                            self.cameraModel.switchCamera()
                                            //                                        } else {
                                            //                                            self.cameraModel.checkPermission(isBackCamera: self.cameraModel.isBackCamera)
                                            //                                        }
                                            
                                        } label: {
                                            Image(self.cameraModel.isBackCamera ? "CameraFlip2" : "CameraFlip")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25, height: 25, alignment: .center)
                                        }
                                        
                                    }
                                    
                                    // Flash
                                    VStack {
                                        
                                        Text("Flash")
                                            .font(.custom("Urbanist-Regular", size: 10))
                                            .foregroundColor(.white)
                                            .padding(.bottom, -5)
                                        Button {
                                            flash.toggle()
                                            self.cameraModel.toggleFlash()
                                            print("Flash===========")
                                        } label: {
                                            Image(flash ? "Flash2" : "Flash3")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25, height: 25, alignment: .center)
                                        }
                                        
                                    }
                                    
                                    // Timer
                                    VStack {
                                        
                                        Text("Timer")
                                            .font(.custom("Urbanist-Regular", size: 10))
                                            .foregroundColor(.white)
                                            .padding(.bottom, -5)
                                        Button {
                                            print("Timer===========")
                                            //                                        countdownTimer = 7
                                            
                                            if countdownTimer == 5 {
                                                countdownTimer = 7
                                                countdownTimerText = 7
                                            } else if countdownTimer == 7 {
                                                countdownTimer = 3
                                                countdownTimerText = 3
                                            } else {
                                                countdownTimer = 5
                                                countdownTimerText = 5
                                            }
                                            
                                        } label: {
                                            Image(countdownTimer == 5 ? "Timer2" : "TimerPurple")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25, height: 25, alignment: .center)
                                                .overlay {
                                                    Circle()
                                                        .strokeBorder(.white, lineWidth: 1)
                                                        .frame(width: 15, height: 15)
                                                        .background(Circle().fill(LinearGradient(colors: [
                                                            Color("GradientOne"),
                                                            Color("GradientTwo"),
                                                        ], startPoint: .top, endPoint: .bottom)
                                                        ))
                                                        .overlay {
                                                            //                                                        Text("5")
                                                            Text("\(countdownTimerText)")
                                                                .foregroundColor(.white)
                                                                .font(.custom("Urbanist-Bold", size: 8))
                                                        }
                                                        .offset(x: 10, y: 13)
                                                }
                                            
                                        }
                                        
                                    }
                                    
                                    
                                }
                                .padding(.bottom, 12)
                                
                                VStack(spacing: 12) {
                                    
                                    // Beauty
                                    VStack {
                                        
                                        Text("Beauty")
                                            .font(.custom("Urbanist-Regular", size: 10))
                                            .foregroundColor(.white)
                                            .padding(.bottom, -5)
                                        Button {
                                            print("Beauty2===========")
                                            beauty.toggle()
                                        } label: {
                                            Image(beauty ? "Beauty2" : "Beauty")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25, height: 25, alignment: .center)
                                        }
                                        
                                    }
                                    
                                    // Filter
                                    VStack {
                                        
                                        Text("Filter")
                                            .font(.custom("Urbanist-Regular", size: 10))
                                            .foregroundColor(.white)
                                            .padding(.bottom, -5)
                                        Button {
                                            print("Filter2===========")
                                            filter.toggle()
                                        } label: {
                                            Image(filter ? "Filter2" : "Filter")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25, height: 25, alignment: .center)
                                        }
                                        
                                    }
                                    
                                    // Effects
                                    VStack {
                                        
                                        Text("Effects")
                                            .font(.custom("Urbanist-Regular", size: 10))
                                            .foregroundColor(.white)
                                            .padding(.bottom, -5)
                                        Button {
                                            print("Filter2===========")
                                            effects.toggle()
                                        } label: {
                                            Image(effects ? "effect2" : "VectorLS")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25, height: 25, alignment: .center)
                                        }
                                        
                                    }
                                    
                                    // Settings
                                    VStack {
                                        
                                        Text("Settings")
                                            .font(.custom("Urbanist-Regular", size: 10))
                                            .foregroundColor(.white)
                                            .padding(.bottom, -5)
                                        Button {
                                            print("settingSheet===========")
                                            settingSheet.toggle()
                                        } label: {
                                            Image("CategoriesLS")
                                        }
                                        
                                    }
                                    
                                }
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 10)
                            .background(LinearGradient(colors: [Color("GrayFour").opacity(0.3),Color("GrayFour").opacity(0.3) ], startPoint: .top, endPoint: .bottom))
//                            .background(Color.black)//.opacity(0.3)
                            .cornerRadius(50)
                            
                        }
                        .frame(maxHeight: .infinity,alignment: .top)
                        .padding(.trailing, 5)
                        .padding(.top, 120)
                    }
                    
//                    if goToLive {
//
//                        VStack {
//                            ScrollView(showsIndicators: false) {
//
//                                LazyVGrid(columns: gridLayoutCommentLS, alignment: .center, spacing: columnSpacingCommentLS, pinnedViews: []) {
//                                    Section()
//                                    {
//                                        ForEach(0..<8) { people in
//                                            CommentListOnLive(creatorDetaiSheet: $creatorDetaiSheet)
//                                        }
//                                    }
//                                }
//                            }
//                            .frame(height: 300)
//                        }
//                        .background(
//                            Color.white
//                        )
//                        .frame(alignment: .bottom)
//                        .padding(.leading)
//                        .padding(.bottom, 200)
//                        .padding(.top, 500)
//                    }
                    
                    // Go live with followers And GoLive Button
                    VStack {
                        
                        if goToLive == true {
                            
                            VStack {
                                
                                VStack {

//                                    if goLiveToPlanOne == true && goLiveToPlanTwo == true && goLiveToFollowers == true {
//                                        VStack(alignment: .leading, spacing: -1) {
//
//                                            HStack {
//                                                Image("UserLS")
//                                                Text("LIVE to Premium Plan 1 followers")
//                                            }
//                                            HStack {
//                                                Image("UserLS")
//                                                Text("LIVE to Premium Plan 2 followers ")
//                                            }
//                                            HStack {
//                                                Image("UserLS")
//                                                Text("Go LIVE to Followers")
//                                            }
//
//                                        }
//                                        .font(.custom("Urbanist-Bold", size: 12))
//                                        .foregroundColor(.white)
//                                    } else if goLiveToPlanOne == true && goLiveToPlanTwo == true {
//                                        VStack(alignment: .leading, spacing: -1) {
//
//                                            HStack {
//                                                Image("UserLS")
//                                                Text("LIVE to Premium Plan 1 followers")
//                                            }
//                                            HStack {
//                                                Image("UserLS")
//                                                Text("LIVE to Premium Plan 2 followers ")
//                                            }
//
//                                        }
//                                        .font(.custom("Urbanist-Bold", size: 12))
//                                        .foregroundColor(.white)
//                                    } else
                                    if goLiveToPlanOne == true {
                                        HStack {
                                            Image("UserLS")
                                            Text("LIVE to Premium Plan 1 followers")
                                                .font(.custom("Urbanist-Bold", size: 12))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    if goLiveToPlanTwo == true {
                                        HStack {
                                            Image("UserLS")
                                            Text("LIVE to Premium Plan 2 followers")
                                                .font(.custom("Urbanist-Bold", size: 12))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    if goLiveToFollowers == true {
                                        HStack {
                                            Image("UserLS")
                                            Text("Go LIVE to Followers")
                                                .font(.custom("Urbanist-Bold", size: 12))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                }
                                .padding(.horizontal, 20)
                                .background(Color(#colorLiteral(red: 0.2694437504, green: 0.284270972, blue: 0.3148175478, alpha: 0.6004501242)))
                                .cornerRadius(20)
                                
                                Image("UplosdLS")
                                    .onTapGesture {
                                        goToLive = false
                                        toggleLocalSession()
                                    }
                                
                                HStack {  // CustomTextFieldTwo
                                    
                                    
                                    
                                    HStack {
                                        EmojiTextField(text: $comment, isEmoji: $isEmoji, resignClosur: { isEdit in
                                            commentFocused = isEdit
                                            hideEditingParentView = isEdit
                                        })
                                        .placeholder(when: comment.isEmpty) {
                                            Text("Comments...").foregroundColor(.gray)
                                        }
                                        .frame(height: 46)
                                        
                                        Button(action: {
                                            isEmoji.toggle()
                                        }) {
                                            
                                            Image("emoji")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20, alignment: .center)
                                        }
                                        
                                        Button(action: {
                                            //                                            isEmoji.toggle()
                                        }) {
                                            
                                            Image("send")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20, alignment: .center)
                                                .padding(.trailing)
                                        }
                                    }
                                    .padding(.leading)
                                    .background(commentFocused ? Color(red: 244/255, green: 236/255, blue: 255/255) : Color(#colorLiteral(red: 0.1618552804, green: 0.1789564192, blue: 0.2178981602, alpha: 1)))
                                    .cornerRadius(12)
                                    .overlay(commentFocused ? RoundedRectangle(cornerRadius: 10).stroke(Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color("buttionGradientTwo"), lineWidth: 0).cornerRadius(10))
                                    
                                    
                                    Image("QnALS")
                                        .onTapGesture {
                                            questionAnswerSheet.toggle()
                                        }
                                    
                                }
                                .padding(.horizontal)
                            }
                            
                        } else {
                            // Go live with followers And GoLive Button
                            VStack {
                                
                                VStack {
                                    
                                    HStack {
                                        Image("UserLS")
                                        Text("3000 Followers active now")
                                            .font(.custom("Urbanist-Bold", size: 12))
                                            .foregroundColor(.white)
                                    }
                                    
                                    HStack {
                                        Text("Go LIVE to Followers")
                                            .font(.custom("Urbanist-Bold", size: 12))
                                            .foregroundColor(.white)
                                        Button {
                                            goLiveToFollowers.toggle()
                                        } label: {
                                            Image(goLiveToFollowers ? "CategoriesEightLS" : "CategoriesSevenLS")
                                        }
                                        
                                    }
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 8)
                                    .background(Color(#colorLiteral(red: 1, green: 0.4038823843, blue: 0.4780470729, alpha: 1)))
                                    .cornerRadius(20)
                                    
                                    HStack {
                                        Image("UserLS")
                                        Text("1300 Premium Plan 1 followers active now")
                                            .font(.custom("Urbanist-Bold", size: 12))
                                            .foregroundColor(.white)
                                    }
                                    
                                    HStack {
                                        Text("Go LIVE to Premium Plan 1 Followers")
                                            .font(.custom("Urbanist-Bold", size: 12))
                                            .foregroundColor(.white)
                                        Button {
                                            goLiveToPlanOne.toggle()
                                        } label: {
                                            Image(goLiveToPlanOne ? "CategoriesEightLS" : "CategoriesSevenLS")
                                        }
                                        
                                    }
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 8)
                                    .background(Color(#colorLiteral(red: 1, green: 0.4038823843, blue: 0.4780470729, alpha: 1)))
                                    .cornerRadius(20)
                                    
                                    HStack {
                                        Image("UserLS")
                                        Text("200 Premium Plan 2 followers active now")
                                            .font(.custom("Urbanist-Bold", size: 12))
                                            .foregroundColor(.white)
                                    }
                                    
                                    HStack {
                                        Text("Go LIVE to Premium Plan 2 Followers")
                                            .font(.custom("Urbanist-Bold", size: 12))
                                            .foregroundColor(.white)
                                        Button {
                                            goLiveToPlanTwo.toggle()
                                        } label: {
                                            Image(goLiveToPlanTwo ? "CategoriesEightLS" : "CategoriesSevenLS")
                                        }
                                        
                                    }
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 8)
                                    .background(Color(#colorLiteral(red: 1, green: 0.4038823843, blue: 0.4780470729, alpha: 1)))
                                    .cornerRadius(20)
                                    
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .background(Color(#colorLiteral(red: 0.2694437504, green: 0.284270972, blue: 0.3148175478, alpha: 0.6004501242)))
                                .cornerRadius(20)
                                
                                Button {
                                    //                                if goLiveToFollowers == true || goLiveToPlanOne == true || goLiveToPlanTwo == true {
                                    //                                }
                                    
                                    //                                    agoraManager
                                    
                                    if titleValue.isEmpty == false && UserDefaults.standard.value(forKey: UserdefaultsKey.selectedTopics) != nil {
                                        goToLive = true
                                        toggleLocalSession()
                                    } else {
                                        alert = true
                                    }
                                } label: {
                                    HStack {
                                        Image("VideoLS")
                                        Text("GO LIVE")
                                            .font(.custom("Urbanist-SemiBold", size: 14))
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.horizontal, 12)
                                .overlay {
                                    Capsule()
                                        .strokeBorder(Color((#colorLiteral(red: 1, green: 0.4038823843, blue: 0.4780470729, alpha: 1))), lineWidth: 2)
                                }
                                .padding(.top)
                                
                            }
                            
                        }
                        
                    }
                    .frame(maxHeight: .infinity,alignment: .bottom)
                    .padding(.bottom, 50)
                    
                    
                    // Invite And Share Button
                    HStack {
                        
                        VStack(spacing: 0) {
                            
                            Text("Invite") // Medium
                                .font(.custom("Urbanist-Medium", size: 12))
                                .foregroundColor(.black)
                            Button {
                                    inviteSheet.toggle()
                            } label: {
                                Image("CategoriesNineLS")
                            }
                            
                        }
                        
                         Spacer()
                        
                        VStack(spacing: 0) {
                            
                            Text("Share")
                                .font(.custom("Urbanist-Medium", size: 12))
                                .foregroundColor(.black)
                            Button {
                                shareSheet.toggle()
                            } label: {
                                Image("CategoriesTenLS")
                            }

                           
                        }
                    }
                    .frame(maxHeight: .infinity,alignment: .bottom)
                    .padding(.horizontal)
                    .padding(.bottom, -15)
                    
                    .blurredSheet(.init(.white), show: $inviteSheet) {
                        
                    } content: {
                        if #available(iOS 16.0, *) {
                            GoLiveTogetherSheetView()
//                            SearchView()
//                            Text("Hello From Sheets")
//                                .foregroundColor(.black)
                                .presentationDetents([.large,.medium,.height(500)])
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    .blurredSheet(.init(.white), show: $shareSheet) {
                        
                    } content: {
                        if #available(iOS 16.0, *) {
                            SendtoJoinLiveSheet()
//                            SearchView()
//                            Text("Hello From Sheets")
//                                .foregroundColor(.black)
                                .presentationDetents([.large,.medium,.height(500)])
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    .blurredSheet(.init(.white), show: $settingSheet) {
                        
                    } content: {
                        if #available(iOS 16.0, *) {
                            LiveSettingsSheet()
//                            SearchView()
//                            Text("Hello From Sheets")
//                                .foregroundColor(.black)
                                .presentationDetents([.large,.medium,.height(500)])
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    .blurredSheet(.init(.white), show: $questionAnswerSheet) {
                        
                    } content: {
                        if #available(iOS 16.0, *) {
                            QuestionAnswerSheet()
                                .presentationDetents([.large,.medium,.height(500)])
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    .blurredSheet(.init(.white), show: $creatorDetaiSheet) {
                        
                    } content: {
                        if #available(iOS 16.0, *) {
                            UserDetailSheet()
//                            SearchView()
//                            Text("Hello From Sheets")
//                                .foregroundColor(.black)
                                .presentationDetents([.large,.medium,.height(500)])
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                }
                
            }
            .onAppear {
                    // This is our usual steps for joining
                    // a channel and starting a call.
                self.initializeAgoraEngine()
                self.setupVideo()
                self.setupLocalVideo()
//                self.toggleLocalSession()
                rtcEngine.startPreview()
                rtcEngine.setClientRole(.broadcaster)
                
                if let sT = UserDefaults.standard.value(forKey: UserdefaultsKey.selectedTopics) as? [String] {
                    selectedTopic = sT.joined(separator: ", ")
                }
            }
            .onDisappear {
                if goToLive {
//                    agoraManager.engine.leaveChannel()
                    leaveChannel()
                    UserDefaults.standard.removeObject(forKey: UserdefaultsKey.streamTitle)
                    UserDefaults.standard.removeObject(forKey: UserdefaultsKey.selectedTopics)
                }
            }
            .alert(isPresented: $alert, content: {
                Alert(title: Text("Alert"), message: Text("Please add title and choose topic"), dismissButton: .cancel(Text("Ok")))
            })
            .sheet(isPresented: $showTopicView, onDismiss: {
                
                if let sT = UserDefaults.standard.value(forKey: UserdefaultsKey.selectedTopics) as? [String] {
                    selectedTopic = sT.joined(separator: ", ")
                }
                
            }, content: {
                ChooseYourTopicView(presentedAsModal: self.$showTopicView)
            })
//            .sheet(isPresented: $showTopicView) { ChooseYourTopicView(presentedAsModal: self.$showTopicView) }

            
        }
    }
}


fileprivate extension LiveStreamingView {
   func initializeAgoraEngine() {
       // init AgoraRtcEngineKit
       videoEngine.contentView = self
   }
   
   func setupVideo() {
       // In simple use cases, we only need to enable video capturing
       // and rendering once at the initialization step.
       // Note: audio recording and playing is enabled by default.
       rtcEngine.enableVideo()
       
       // Set video configuration
       // Please go to this page for detailed explanation
       // https://docs.agora.io/en/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:
       rtcEngine.setVideoEncoderConfiguration(
           AgoraVideoEncoderConfiguration(
               size: AgoraVideoDimension640x360,
               frameRate: .fps15,
               bitrate: AgoraVideoBitrateStandard,
               orientationMode: .adaptative, mirrorMode: AgoraVideoMirrorMode(rawValue: 0)!
       ))
   }
   
   func setupLocalVideo() {
       // This is used to set a local preview.
       // The steps setting local and remote view are very similar.
       // But note that if the local user do not have a uid or do
       // not care what the uid is, he can set his uid as ZERO.
       // Our server will assign one and return the uid via the block
       // callback (joinSuccessBlock) after
       // joining the channel successfully.
       let videoCanvas = AgoraRtcVideoCanvas()
       videoCanvas.view = localCanvas.rendererView
       videoCanvas.renderMode = .hidden
       rtcEngine.setupLocalVideo(videoCanvas)
   }
   
   func joinChannel() {
       // Set audio route to speaker
       rtcEngine.setDefaultAudioRouteToSpeakerphone(false)
       
       // 1. Users can only see each other after they join the
       // same channel successfully using the same app id.
       // 2. One token is only valid for the channel name that
       // you use to generate this token.
       rtcEngine.joinChannel(byToken: Token, channelId: "nTest", info: nil, uid: 0) { str, value, val in
           print(str)
           print(value)
           print(val)

       }
   }

   func leaveChannel() {
       // leave channel and end chat
       rtcEngine.leaveChannel(nil)
   }
}

extension LiveStreamingView {
   func log(content: String) {
       print(content)
   }
}

fileprivate extension LiveStreamingView {
   func toggleLocalSession() {
       isLocalInSession.toggle()
       if isLocalInSession {
           joinChannel()
       } else {
           leaveChannel()
       }
   }
   
   func switchCamera() {
       rtcEngine.switchCamera()
   }
   
   func toggleLocalAudio() {
       isLocalAudioMuted.toggle()
       // mute/unmute local audio
       rtcEngine.muteLocalAudioStream(isLocalAudioMuted)
   }
}

  

struct LiveStreamingView_Previews: PreviewProvider {
    static var previews: some View {
        LiveStreamingView()
    }
}





