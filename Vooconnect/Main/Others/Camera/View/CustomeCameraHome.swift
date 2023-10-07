//
//  CustomeCameraHome.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/12/22.
//

import SwiftUI
import ARGear
import ARKit
//import DeepAR

struct CustomeCameraHome: View {
    
    @State private var circleProgress: CGFloat = 0.2
    @State private var widthAndHeight: CGFloat = 90
    @State private var progressColor: Color = .red
    @Environment(\.presentationMode) var presentaionMode
    
    @StateObject var cameraModel = CameraViewModel()
    //    @EnvironmentObject var cameraModel: CameraViewModel
    @State private var preview: Bool = false
    @State private var photos: Bool = false
    
    @State private var soundView: Bool = false
    
    @State private var flash: Bool = false
    @State private var timerImage: Bool = false
    @State private var durationImage: Bool = false
    
    @State private var clickPhoto: Bool = false
    
    @StateObject var camera = CameraModelPhoto()
    
    @State var countdownTimerText = 0
    @State var countdownTimer : Int = 0
    @State var countdownText : Int = 0
    @State private var countdownTimer2 = 0
    @State private var progress: Double = 0
    
    @State var timerRunning = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var cameraFlip: Bool = false
    
    @State private var filersSheet: Bool = false
    @State private var beautySheet: Bool = false
    @State private var effectsSheet: Bool = false
    @State private var isShowPopup: Bool = false
    var toast_main_position = CGPoint(x: 0, y: 0)
    @State var previewURL: String = ""
    @State private var hide: Bool = true
    
    @State private var delegate: MainBottomFunctionDelegate?
    
    @ObservedObject var Vm = ViewModel()
    var cameraInfoData: ((_ content: Any) -> Void)?
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                if self.isShowPopup {
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            Spacer()
                            Text("Beauty")
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
                
                if let url = URL(string: previewURL) {
                    let isImage = !(url.absoluteString.lowercased().contains(".mp4") || url.absoluteString.lowercased().contains(".mov"))
                    NavigationLink(
                        destination: FinalPreview(
                            
                            controller: FinalPreviewController(url: url, isImage: isImage, speed: cameraModel.speed), songModel: cameraModel.songModel, speed: 1, showPreview: $cameraModel.showPreview,
                            url: .constant(url))
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                        
                        ,
                        isActive: $preview) {
                            EmptyView()
                        }
                    
                }
                
                NavigationLink(destination: AllMediaView(callback: {val in
                    //                    self.photos = false
                    self.cameraModel.previewURL = val.url
                    self.cameraModel.speed = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self.cameraModel.showPreview = true
                        self.preview = true
                    }
                })
                    .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $photos) {
                        EmptyView()
                    }
                
                NavigationLink(destination: SoundsView(
                    pickSong: {song in
                        cameraModel.songModel = song
                        print("new song added to video: "+(cameraModel.songModel?.preview ?? ""))
                    }
                )
                    .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $soundView) {
                        EmptyView()
                    }
                
                HStack {
                    Spacer()
                    Button {
                        presentaionMode.wrappedValue.dismiss()
                    } label: {
                        Image("CameraBack")
                    }
                    
                }
                .padding(.trailing)
                
                
                ZStack {
                    MainViewRepresenter(Vm: Vm, cameraInfoData: { content in
                        if let image = content as? UIImage {
                            print(image)
                            let videoPath = "output_video.mp4"
                            cameraModel.writeImagesAsMovie(allImages: [image], videoPath: videoPath, videoSize: image.size, videoFPS: 30)
                        } else if let videoInfo = content as? [String: Any] {
                            print(videoInfo)
                            if let filePath = videoInfo["filePath"] as? URL{
                                print(filePath)
                                previewURL = filePath.absoluteString
                                cameraModel.previewURL = filePath
                            }
                        }
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(.top,10)
                    .padding(.bottom,30)
                    
                    if timerRunning == true {
                        
                        Text("\(countdownText)")
                            .foregroundColor(.white)
                            .padding()
                            .onReceive(timer) { _ in
                                if countdownText < countdownTimer && timerRunning {
                                    countdownText += 1
                                } else {
                                    timerRunning = false
                                }
                                
                            }
                            .font(.system(size: 40, weight: .bold))
                    }
                    
                    // MARK: Controls
                    ZStack{
                        
                        if clickPhoto == true {
                            
                            VStack(alignment: .leading) {
                                
                                VStack {
                                    
                                    VStack {
                                        
                                        VStack(spacing: 12) {
                                            
                                            VStack {
                                                
                                                
                                                Button {
                                                    Vm.cameraChannge = true
                                                    
                                                } label: {
                                                    VStack{
                                                        Text("Flip")
                                                            .font(.custom("Urbanist-Regular", size: 10))
                                                            .foregroundColor(cameraFlip ? ColorsHelper.deepPurple : .white)
                                                            .padding(.bottom, -5)
                                                        Image(cameraFlip ? "FlipCameraPurple" :"CameraFlip2") //FlipCameraPurple
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Flash")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    if self.cameraModel.isBackCamera == false {
                                                        flash.toggle()
                                                        self.cameraModel.toggleFlash()
                                                    } else {
                                                        print("Flash===========")
                                                    }
                                                    
                                                } label: {
                                                    Image(flash ? "Flash2" : "Flash3") //Flash3
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Timer")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    print("Timer===========")
                                                    
                                                    timerImage = true
                                                    
                                                    if countdownTimer == 0 {
                                                        countdownTimer = 3
                                                        countdownTimerText = 3
                                                    } else if countdownTimer == 3 {
                                                        countdownTimer = 5
                                                        countdownTimerText = 5
                                                    } else if countdownTimer == 5 {
                                                        countdownTimer = 10
                                                        countdownTimerText = 10
                                                    } else if countdownTimer == 10 {
                                                        countdownTimer = 15
                                                        countdownTimerText = 15
                                                    } else if countdownTimer == 15 {
                                                        countdownTimer = 20
                                                        countdownTimerText = 20
                                                    } else if countdownTimer == 20 {
                                                        countdownTimer = 25
                                                        countdownTimerText = 25
                                                    } else if countdownTimer == 25 {
                                                        countdownTimer = 30
                                                        countdownTimerText = 30
                                                    } else {
                                                        countdownTimer = 0
                                                        countdownTimerText = 0
                                                    }
                                                    countdownTimer2 = countdownTimer
                                                    
                                                } label: {
                                                    //                                            VStack {
                                                    Image(timerImage ? "TimerPurple" : "Timer2") // TimerPurple
                                                        .overlay {
                                                            Circle()
                                                                .strokeBorder(.white, lineWidth: 1)
                                                                .frame(width: 23, height: 23)
                                                                .background(Circle().fill(LinearGradient(colors: [
                                                                    Color("GradientOne"),
                                                                    Color("GradientTwo"),
                                                                ], startPoint: .top, endPoint: .bottom)
                                                                ))
                                                                .overlay {
                                                                    //                                                                    Text("5")
                                                                    Text("\(countdownTimerText)")
                                                                        .foregroundColor(.white)
                                                                        .font(.custom("Urbanist-Bold", size: 8))
                                                                }
                                                                .offset(x: 10, y: 13)
                                                        }
                                                    
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Duration")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    print("Duration2===========")
                                                    durationImage = true
                                                    //                                                    print(cameraModel.maxDuration)
                                                    if cameraModel.maxDuration == 10 {
                                                        cameraModel.maxDuration = 20
                                                    } else if cameraModel.maxDuration == 20 {
                                                        cameraModel.maxDuration = 30
                                                    } else if cameraModel.maxDuration == 30 {
                                                        cameraModel.maxDuration = 60
                                                    } else if cameraModel.maxDuration == 60 {
                                                        cameraModel.maxDuration = 90
                                                    } else if cameraModel.maxDuration == 90 {
                                                        cameraModel.maxDuration = 120
                                                    } else {
                                                        cameraModel.maxDuration = 10
                                                    }
                                                    
                                                } label: {
                                                    Image(durationImage ? "DurationPurple" : "Duration2")
                                                        .overlay {
                                                            Circle()
                                                                .strokeBorder(.white, lineWidth: 1)
                                                                .frame(width: 23, height: 23)
                                                                .background(Circle().fill(LinearGradient(colors: [
                                                                    Color("GradientOne"),
                                                                    Color("GradientTwo"),
                                                                ], startPoint: .top, endPoint: .bottom)
                                                                ))
                                                                .overlay {
                                                                    Text("\(Int(cameraModel.maxDuration))")
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
                                            
                                            VStack {
                                                
                                                Text("Speed")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    switch(cameraModel.speed)
                                                    {
                                                    case 0.25 : cameraModel.speed = 0.5
                                                    case 0.5 : cameraModel.speed = 1.0
                                                    case 1.0 : cameraModel.speed = 2.0
                                                    case 2.0 : cameraModel.speed = 3.0
                                                    default : cameraModel.speed = 0.25
                                                    }
                                                    print("speed: " + cameraModel.speed.description)
                                                    
                                                } label: {
                                                    Image("Speed2")
                                                        .overlay {
                                                            Circle()
                                                                .strokeBorder(.white, lineWidth: 1)
                                                                .frame(width: 23, height: 23)
                                                                .background(Circle().fill(LinearGradient(colors: [
                                                                    Color("GradientOne"),
                                                                    Color("GradientTwo"),
                                                                ], startPoint: .top, endPoint: .bottom)
                                                                ))
                                                                .overlay {
                                                                    Text(
                                                                        cameraModel.speed < 1 ?
                                                                        "\(String(format: "%.2f", cameraModel.speed))":
                                                                            "\(Int(cameraModel.speed))")
                                                                    .foregroundColor(.white)
                                                                    .font(.custom("Urbanist-Bold", size: 8))
                                                                }
                                                                .offset(x: 10, y: 13)
                                                        }
                                                }
                                                
                                            }
                                            .padding(.bottom, 6)
                                            
                                            VStack {
                                                
                                                Text("Add Sound")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    if(cameraModel.songModel != nil)
                                                    {
                                                        cameraModel.songModel = nil
                                                    }
                                                    flash = false
                                                    soundView.toggle()
                                                    print("AddSound2===========")
                                                } label: {
                                                    if(cameraModel.songModel == nil)
                                                    {
                                                        Image("AddSound2")
                                                    }else
                                                    {
                                                        Image("AddSound2")
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Beauty")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    print("Beauty2===========")
                                                    Vm.openBeauty = true
                                                    Vm.bottomHide = true
                                                } label: {
                                                    Image("Beauty2")
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Filter")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    Vm.openFilter = true
                                                    Vm.bottomHide = true
                                                    print("Filter2===========")
                                                    
                                                } label: {
                                                    Image("Filter2")
                                                }
                                                
                                            }
                                            
                                        }
                                    }
                                    .padding(.vertical)
                                    .padding(.horizontal, 10)
                                    //                            .background(Color.gray)
                                    //                                    .background(.ultraThinMaterial)
                                    //                            .opacity(0.8)
                                    //                            .opacity(1.0)
                                    .background(
                                        LinearGradient(colors: [ // GraySix
                                            Color("GrayFour"),    //  GrayFive // GrayFour // GrayFourR
                                            Color("GrayFour"),
                                                               ], startPoint: .leading, endPoint: .trailing)) // GrayOneC
                                    .cornerRadius(50)
                                    
                                }
                                .frame(maxWidth: .infinity,alignment: .trailing)
                                .padding(.bottom, -20)
                                .padding(.trailing, 6)
                                
                            }
                            .padding(.leading)
                            .padding(.bottom)
                            
                        } else {
                            
                            VStack(alignment: .leading) {
                                
                                VStack {
                                    
                                    VStack {
                                        
                                        VStack(spacing: 12) {
                                            
                                            VStack {
                                                
                                                
                                                Button {
                                                    Vm.cameraChannge = true
                                                } label: {
                                                    VStack{
                                                        Text("Flip")
                                                            .font(.custom("Urbanist-Regular", size: 10))
                                                            .foregroundColor(cameraFlip ? ColorsHelper.deepPurple : .white)
                                                            .padding(.bottom, -5)
                                                        Image(cameraFlip ? "FlipCameraPurple" :"CameraFlip2") //FlipCameraPurple
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Flash")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    if self.cameraModel.isBackCamera == false {
                                                        flash.toggle()
                                                        self.cameraModel.toggleFlash()
                                                    } else {
                                                        print("Flash===========")
                                                    }
                                                    
                                                } label: {
                                                    Image(flash ? "Flash2" : "Flash3") //Flash3
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Timer")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    print("Timer===========")
                                                    
                                                    timerImage = true
                                                    
                                                    if countdownTimer == 0 {
                                                        countdownTimer = 3
                                                        countdownTimerText = 3
                                                    } else if countdownTimer == 3 {
                                                        countdownTimer = 5
                                                        countdownTimerText = 5
                                                    } else if countdownTimer == 5 {
                                                        countdownTimer = 10
                                                        countdownTimerText = 10
                                                    } else if countdownTimer == 10 {
                                                        countdownTimer = 15
                                                        countdownTimerText = 15
                                                    } else if countdownTimer == 15 {
                                                        countdownTimer = 20
                                                        countdownTimerText = 20
                                                    } else if countdownTimer == 20 {
                                                        countdownTimer = 25
                                                        countdownTimerText = 25
                                                    } else if countdownTimer == 25 {
                                                        countdownTimer = 30
                                                        countdownTimerText = 30
                                                    } else {
                                                        countdownTimer = 0
                                                        countdownTimerText = 0
                                                    }
                                                    countdownTimer2 = countdownTimer
                                                    
                                                } label: {
                                                    //                                            VStack {
                                                    Image(timerImage ? "TimerPurple" : "Timer2") // TimerPurple
                                                        .overlay {
                                                            Circle()
                                                                .strokeBorder(.white, lineWidth: 1)
                                                                .frame(width: 23, height: 23)
                                                                .background(Circle().fill(LinearGradient(colors: [
                                                                    Color("GradientOne"),
                                                                    Color("GradientTwo"),
                                                                ], startPoint: .top, endPoint: .bottom)
                                                                ))
                                                                .overlay {
                                                                    //                                                                    Text("5")
                                                                    Text("\(countdownTimerText)")
                                                                        .foregroundColor(.white)
                                                                        .font(.custom("Urbanist-Bold", size: 8))
                                                                }
                                                                .offset(x: 10, y: 13)
                                                        }
                                                    
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Duration")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    print("Duration2===========")
                                                    durationImage = true
                                                    //                                                    print(cameraModel.maxDuration)
                                                    if cameraModel.maxDuration == 10 {
                                                        cameraModel.maxDuration = 20
                                                    } else if cameraModel.maxDuration == 20 {
                                                        cameraModel.maxDuration = 30
                                                    } else if cameraModel.maxDuration == 30 {
                                                        cameraModel.maxDuration = 60
                                                    } else if cameraModel.maxDuration == 60 {
                                                        cameraModel.maxDuration = 90
                                                    } else if cameraModel.maxDuration == 90 {
                                                        cameraModel.maxDuration = 120
                                                    } else {
                                                        cameraModel.maxDuration = 10
                                                    }
                                                    
                                                } label: {
                                                    Image(durationImage ? "DurationPurple" : "Duration2")
                                                        .overlay {
                                                            Circle()
                                                                .strokeBorder(.white, lineWidth: 1)
                                                                .frame(width: 23, height: 23)
                                                                .background(Circle().fill(LinearGradient(colors: [
                                                                    Color("GradientOne"),
                                                                    Color("GradientTwo"),
                                                                ], startPoint: .top, endPoint: .bottom)
                                                                ))
                                                                .overlay {
                                                                    Text("\(Int(cameraModel.maxDuration))")
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
                                            
                                            VStack {
                                                
                                                Text("Speed")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    switch(cameraModel.speed)
                                                    {
                                                    case 0.25 : cameraModel.speed = 0.5
                                                    case 0.5 : cameraModel.speed = 1.0
                                                    case 1.0 : cameraModel.speed = 2.0
                                                    case 2.0 : cameraModel.speed = 3.0
                                                    default : cameraModel.speed = 0.25
                                                    }
                                                    print("speed: " + cameraModel.speed.description)
                                                    
                                                } label: {
                                                    Image("Speed2")
                                                        .overlay {
                                                            Circle()
                                                                .strokeBorder(.white, lineWidth: 1)
                                                                .frame(width: 23, height: 23)
                                                                .background(Circle().fill(LinearGradient(colors: [
                                                                    Color("GradientOne"),
                                                                    Color("GradientTwo"),
                                                                ], startPoint: .top, endPoint: .bottom)
                                                                ))
                                                                .overlay {
                                                                    Text(
                                                                        cameraModel.speed < 1 ?
                                                                        "\(String(format: "%.2f", cameraModel.speed))":
                                                                            "\(Int(cameraModel.speed))")
                                                                    .foregroundColor(.white)
                                                                    .font(.custom("Urbanist-Bold", size: 8))
                                                                }
                                                                .offset(x: 10, y: 13)
                                                        }
                                                }
                                                
                                            }
                                            .padding(.bottom, 6)
                                            
                                            VStack {
                                                
                                                Text("Add Sound")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    if(cameraModel.songModel != nil)
                                                    {
                                                        cameraModel.songModel = nil
                                                    }
                                                    flash = false
                                                    soundView.toggle()
                                                    print("AddSound2===========")
                                                } label: {
                                                    if(cameraModel.songModel == nil)
                                                    {
                                                        Image("AddSound2")
                                                    }else
                                                    {
                                                        Image("AddSound2")
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Beauty")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    print("Beauty2===========")
                                                    Vm.openBeauty = true
                                                    Vm.bottomHide = true
                                                } label: {
                                                    Image("Beauty2")
                                                }
                                                
                                            }
                                            
                                            VStack {
                                                
                                                Text("Filter")
                                                    .font(.custom("Urbanist-Regular", size: 10))
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, -5)
                                                Button {
                                                    Vm.openFilter = true
                                                    Vm.bottomHide = true
                                                    print("Filter2===========")
                                                    
                                                } label: {
                                                    Image("Filter2")
                                                }
                                                
                                            }
                                            
                                        }
                                    }
                                    .padding(.vertical)
                                    .padding(.horizontal, 10)
                                    .background(
                                        LinearGradient(colors: [ // GraySix
                                            Color("GrayFour"),    //  GrayFive // GrayFour // GrayFourR
                                            Color("GrayFour"),
                                                               ], startPoint: .leading, endPoint: .trailing)) // GrayOneC
                                    .cornerRadius(50)
                                    
                                }
                                .frame(maxWidth: .infinity,alignment: .trailing)
                                .padding(.bottom, -20)
                                .padding(.trailing, 6)
                                
                            }
                            .padding(.leading)
                            .padding(.bottom)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            if !Vm.bottomHide {
                                Button {
                                    Vm.isVideo = true
                                    clickPhoto = false
                                } label: {
                                    Image(clickPhoto ? "VideoUnSlected" : "VideoSlected")
                                }
                                
                                HStack {
                                    
                                    Button {
                                        //                                    clickPhoto = true
                                        //                                    self.cameraModel.previewURL = nil
                                        Vm.isPhoto = true
                                        clickPhoto = true
                                    } label: {
                                        Image(clickPhoto ? "PhotoSlected" : "PhotoUnSlected") // PhotoSlected
                                    }
                                    
                                    Spacer()
                                    Spacer()
                                    
                                    if Vm.isPhoto{
                                        Button {
                                            
                                            print("Photo click")
                                            Vm.isRecording = true
                                        } label: {
                                            Image("CameraClick")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 58, height: 58)
                                                .offset(x: 10)
                                                .overlay(
                                                    CircularProgressCameraView(progress: progress)
                                                        .frame(height: 54)
                                                        .offset(x: 10)
                                                )
                                        }
                                        .padding(.leading, 8) // 8
                                        .offset(x: -10)
                                    }else{
                                        Button {
                                            
                                            print("Video click")
                                            Vm.isRecording = true
                                            previewURL = ""
                                        } label: {
                                            Image("CameraRecording")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 58, height: 58)
                                                .offset(x: 10)
                                                .overlay(
                                                    CircularProgressCameraView(progress: progress)
                                                        .frame(height: 54)
                                                        .offset(x: 10)
                                                )
                                        }
                                        .padding(.leading, 8) // 8
                                        .offset(x: -10)
                                    }
                                    
                                    Spacer()
                                    
                                    
                                    // Preview Button
                                    if(previewURL != "") {
                                        Button {
                                            if let videoURL = URL(string: previewURL){
                                                
//                                                if ((cameraModel.songModel?.preview) != nil){
//                                                    self.cameraModel.removeAudioFromVideo(videoURL: videoURL){url, error in
//                                                        if let error = error {
//                                                            print("Failed to remove audio: \(error.localizedDescription)")
//                                                        } else {
//                                                            cameraModel.previewURL = url
//                                                            print("Audio removed video, new url: " + url!.absoluteString)
//                                                            DispatchQueue.main.async {
//                                                                print(("video recorded"))
//                                                                countdownTimer = self.countdownTimer2
//                                                                cameraModel.showPreview.toggle()
//                                                                preview.toggle()
//                                                            }
//                                                        }
//                                                    }
//                                                } else {
                                                    DispatchQueue.main.async {
                                                        print(("video recorded"))
                                                        print("previewURL: \(previewURL)")
                                                        countdownTimer = self.countdownTimer2
                                                        cameraModel.showPreview = true
                                                        preview = true
                                                    }
//                                                }
                                            }
                                        } label: {
                                            Group{
                                                Label {
                                                    Image(systemName: "chevron.right")
                                                        .font(.callout)
                                                } icon: {
                                                    Text("Preview")
                                                }
                                                .foregroundColor(.black)
                                            }
                                            .padding(.horizontal,20)
                                            .padding(.vertical,8)
                                            .background{
                                                Capsule()
                                                    .fill(.white)
                                            }
                                        }
                                        //                                    .opacity((cameraModel.previewURL == nil && cameraModel.recordedURLs.isEmpty) || cameraModel.isRecording ? 0 : 1)
                                    }else{
                                        HStack{Text("                         ")}
                                    }
                                    
                                    
                                }
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                    .frame(maxHeight: .infinity,alignment: .bottom)
                    .padding(.bottom,10)
                    .padding(.bottom,30)
                    
                    Button {
                        countdownTimer = 3
                        cameraModel.recordedDuration = 0
                        cameraModel.previewURL = nil
                        cameraModel.recordedURLs.removeAll()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                    .padding()
                    .padding(.top)
                    .opacity(!cameraModel.recordedURLs.isEmpty && cameraModel.previewURL != nil && !cameraModel.isRecording ? 1 : 0)
                    
                    
                    //                    if cameraModel.isRecording {
                    //                        Text("Recording")
                    //                            .font(.custom("Urbanist-Regular", size: 14))
                    //                            .foregroundColor(.white)
                    //                            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                    //                            .padding(.top, 40)
                    //                    } else {
                    //
                    //                    }
                    //                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                    
                }
                .padding(.top, -10)
                
                .padding(.bottom, -35)
                
                HStack {
                    
                    Button {
                        photos.toggle()
                    } label: {
                        Image("UploadGalery")
                    }
                    
                    Spacer()
                    
                    Button {
                        //                        effectsSheet.toggle()
                        Vm.openCategory = true
                        Vm.bottomHide = true
                    } label: {
                        Image("CameraEffact")
                    }
                    
                    
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                //                // Filters
                //                .blurredSheet(.init(.white), show: $filersSheet) {
                //
                //                } content: {
                //                    if #available(iOS 16.0, *) {
                //                        FiltersSheet(cameraModel: cameraModel, filters: cameraModel.filter)
                //                            .presentationDetents([.large,.medium,.height(300)])
                //                            .onAppear {
                //                                cameraModel.getFilterData()
                //                            }
                //                    } else {
                //                        // Fallback on earlier versions
                //                    }
                //                }
                //                .blurredSheet(.init(.white), show: $beautySheet) {
                //
                //                } content: {
                //                    if #available(iOS 16.0, *) {
                //                        BeautyView()
                //
                //                            .presentationDetents([.large,.medium,.height(140)])
                //                            .onAppear {
                //                                cameraModel.getFilterData()
                //                            }
                //                    } else {
                //                        // Fallback on earlier versions
                //                    }
                //                }
                
                .onAppear{
                    Vm.isVideo = true
                    Vm.bottomHide = false
                }
                
                // Effects
                .blurredSheet(.init(.white), show: $effectsSheet) {
                    
                } content: {
                    if #available(iOS 16.0, *) {
                        EffectsSheets()
                            .presentationDetents([.large,.medium,.height(500)])
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
            }
            
            .animation(.easeInOut, value: cameraModel.showPreview)
            .navigationBarHidden(true)
        }
        
        
    }
    
    
    func simulateVideoProgress() {
        let stepFrequency = 13.899 // Number of steps per second (adjust as desired)
        let totalProgressSteps = cameraModel.maxDuration * stepFrequency
        let stepDuration = 1.0 / totalProgressSteps
        
        DispatchQueue.global(qos: .background).async {
            var shouldStop = false // Flag to indicate if the progress should be stopped
            var i = 0.0
            while i < totalProgressSteps {
                i += 1.0
                usleep(useconds_t(stepDuration * 1_000_000)) // Simulating delay in audio progress
                
                DispatchQueue.main.async {
                    if !cameraModel.isRecording {
                        shouldStop = true // Set the flag to stop the progress
                    }
                    
                    if !shouldStop {
                        progress = Double(i + 1) / Double(totalProgressSteps)
                    }
                    
                    if shouldStop || i == totalProgressSteps - 1 {
                        cameraModel.isRecording = false
                        print("Video Recording completed")
                        cameraModel.stopRecording()
                    }
                }
                
                if shouldStop {
                    break // Exit the loop if the progress should be stopped
                }
            }
        }
    }
}


struct CustomeCameraHome_Previews: PreviewProvider {
    static var previews: some View {
        CustomeCameraHome( Vm: ViewModel())
    }
}



struct circleee : View {
    
    var percent : Double = 0
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .trim(from: 1, to: 1)
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .fill(.white)
                .frame(width: 90, height: 90)
                .overlay(
                    
                    Circle()
                        .trim(from: 0, to: percent * 0.01) //10 means 0.1
                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                        .fill(Color(.red))
                        .rotationEffect(.init(degrees: -90))
                )
        }
    }
}


struct CircleeTwo: View {
    
    @Binding var circleProgress: CGFloat
    
    var widthAndHeight: CGFloat
    var labelSize: CGFloat?
    var staticColor: Color?
    var progressColor: Color
    var showLabel: Bool?
    var lineWidth: CGFloat?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(self.staticColor ?? Color.gray, lineWidth: self.lineWidth ?? 15)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                Circle()
                    .trim(from: 0.0, to: self.circleProgress)
                    .stroke(self.progressColor, lineWidth: self.lineWidth ?? 15)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .rotationEffect(Angle(degrees: -90))
                if self.showLabel ?? true {
                    Text("\(Int(self.circleProgress*100))%")
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .font(.custom("HelveticaNeue", size: self.labelSize ?? 20.0))
                }
            }
        }
        .frame(width: widthAndHeight, height: widthAndHeight)
    }
    
}



