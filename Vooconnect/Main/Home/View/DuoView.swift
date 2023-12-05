//
//  DuoView.swift
//  Vooconnect
//
//  Created by Mac on 18/09/2023.
//

import Foundation
import AVFoundation
import SwiftUI
import ffmpeg_ios
import Photos

struct DuoView: View{
    var videoUrl: String
    var audioUrl: String
//    var videoDuration: Float = 0.0
    @State var savedVideo: String = ""
    @State var musicURL: String = ""
    @State var newVideoUrl: String = ""
    @State private var circleProgress: CGFloat = 0.2
    @State private var widthAndHeight: CGFloat = 90
    @State private var progressColor: Color = .red
    @Environment(\.presentationMode) var presentaionMode
    @Binding var popToFinalView : Bool
    @StateObject var cameraModel = CameraViewModel()
    @StateObject var duoResource = DuoResource()
    @State private var preview: Bool = false
    @State private var photos: Bool = false
    
    @State private var soundView: Bool = false
    
    @State private var flash: Bool = false
    @State private var timerImage: Bool = false
    @State private var durationImage: Bool = false
    
    @State private var clickPhoto: Bool = true
    
    @StateObject var camera = CameraModelPhoto()
    
    @State var countdownTimerText = 0
    @State var countdownTimer : Int = 0
    @State var countdownText : Int = 0
    @State private var countdownTimer2 = 0
    @State private var progress: Double = 0
    
    @State var timerRunning = false
    @State var tapcount = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var cameraFlip: Bool = false
    
    @State private var filersSheet: Bool = false
    @State private var beautySheet: Bool = false
    @State private var effectsSheet: Bool = false
    @State private var filtersSheet: Bool = false
    @State private var isShowPopup: Bool = false
    @State private var previewURL: String = ""
    @State private var duoVideoURL: String = ""
    @State var isRecording = false
    @State var isPlaying = false
    @State private var recordingDuration: Double = 0.0
    @State private var recordingTimer: Timer?
    @State var songURL: URL? = nil
    @State var audioPlayer: AVAudioPlayer!
    
    @State var player = AVPlayer()
    
    @StateObject var Vm = ViewModel()
    @State private var selectedCategoryIndex = 0
    var cameraInfoData: ((_ content: Any) -> Void)?
    
    @State private var isProcessing = false
    @State private var outputURL: URL?
    
    var body: some View {
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
            
            if let url = URL(string: duoVideoURL){
                NavigationLink(destination: FinalPreview(popToFinalView: $popToFinalView, controller: FinalPreviewController(url: url, speed: cameraModel.speed), songModel: cameraModel.songModel, speed: 1, videoURL: url), isActive: $preview) {
                        EmptyView()
                    }
                    .isDetailLink(false)
            }
            
            
            //                NavigationLink(destination: AllMediaView(callback: {val in
            //                    //                    self.photos = false
            //                    self.cameraModel.previewURL = val.url
            //                    self.cameraModel.speed = 1
            //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            //                        self.cameraModel.showPreview = true
            //                        self.preview = true
            //                    }
            //                })
            //                    .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $photos) {
            //                        EmptyView()
            //                    }
            
            
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
                HStack{
                    CustomVideoPlayer(player: player)
                    MainViewRepresenter(Vm: Vm, cameraInfoData: { content in
                        if let image = content as? UIImage {
                            print(image)
                            // Perform video creation and merging asynchronously
                            let resizedImage = resizeImage(image: image)
                            print("resizedImage size\(resizedImage.size)")
                            if resizedImage != nil {
                                DispatchQueue.global().async {
                                    camera.createVideoFromImage(image: resizedImage, originalSize: resizedImage.size, duration: 30.0) { result in
                                        switch result {
                                        case .success(let outputURL):
                                            print("Video export completed successfully.")
                                            print("Output URL: \(outputURL)")
                                            
                                            if let audioURL = URL(string: (cameraModel.songModel?.preview ?? "")!) {
                                                camera.mergeVideoAndAudio(videoUrl: outputURL, audioUrl: audioURL) { error, url in
                                                    guard let url = url else {
                                                        print("Error merging video and audio.")
                                                        return
                                                    }
                                                    print("Video and audio merge completed, new URL: \(url.absoluteString)")
                                                    DispatchQueue.main.async {
                                                        self.previewURL = url.absoluteString
                                                        cameraModel.previewURL = url
                                                        self.preview.toggle()
                                                    }
                                                }
                                            } else {
                                                DispatchQueue.main.async {
                                                    self.previewURL = outputURL.absoluteString
                                                    cameraModel.previewURL = outputURL
                                                    self.preview.toggle()
                                                }
                                            }
                                            
                                        case .failure(let error):
                                            print("Video export failed with error: \(error.localizedDescription)")
                                        }
                                    }
                                }
                            }
                        } else if let videoInfo = content as? [String: Any] {
                            print(videoInfo)
                            if let filePath = videoInfo["filePath"] as? URL{
                                print(filePath)
                                resizeVideo(url: filePath)
                            }
                        }
                    }, height: 800)
                    .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
                }
                .frame(height: 300)
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
                                            effectsSheet = true
                                            Vm.bottomHide = true
                                        } label: {
                                            Image("Beauty2")
                                        }
                                        // filters
                                        .blurredSheet(.init(.clear), show: $effectsSheet) {
                                            
                                        } content: {
                                            if #available(iOS 16.0, *) {
                                                BeautySheet()
                                                    .presentationDetents([.large,.medium,.height(150)])
                                                    .background(Color.clear)
                                            } else {
                                                // Fallback on earlier versions
                                            }
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
                    
                    
                    
                    
                    VStack(alignment: .leading) {
                        if !filtersSheet {
                            Button {
                                Vm.isVideo = true
                                clickPhoto = false
                            } label: {
                                Image(clickPhoto ? "VideoUnSlected" : "VideoSlected")
                            }
                            
                            HStack {
                                
                                Button {
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
                                        timerRunning = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(countdownTimer)) {
                                            timerRunning = false
                                            Vm.isRecording = true
                                            countdownText = 0
                                        }
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
                                        previewURL = ""
                                        isRecording.toggle()
                                        
                                        if isRecording {
                                            timerRunning = true
                                            
                                            Timer.scheduledTimer(withTimeInterval: Double(countdownTimer), repeats: false) { timer in
                                                
                                                if let songPreview = cameraModel.songModel?.preview {
                                                    timerRunning = false
                                                    Vm.isRecording = true
                                                    startProgressRecording()
                                                    print("songUrl: \(songPreview)")
                                                    cameraModel.playSong(songURL: songPreview)
                                                    player.play()
                                                } else if songURL != nil {
                                                    timerRunning = false
                                                    Vm.isRecording = true
                                                    startProgressRecording()
                                                    isPlaying = true
                                                    player.play()
                                                    if isPlaying {
                                                        if let audioPlayer = audioPlayer {
                                                            audioPlayer.currentTime = 0.0
                                                        }
                                                        self.audioPlayer?.play()
                                                    }
                                                }else{
                                                    timerRunning = false
                                                    Vm.isRecording = true
                                                    startProgressRecording()
                                                    player.play()
                                                }
                                            }
                                        } else {
                                            Vm.isRecording = true
                                            countdownText = 0
                                            invalidateRecordingTimer()
                                            print("stop recording")
                                            if cameraModel.songModel?.preview != nil {
                                                cameraModel.stopSong()
                                            }
                                            isPlaying = false
                                            player.pause()
                                            self.audioPlayer?.stop()
                                        }
                                    } label: {
                                        if isRecording {
                                            Image("CameraRecording")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 58, height: 58)
                                                .offset(x: 10)
                                                .overlay(
                                                    CircularProgressCameraView(progress: progress) // Attach the progress view here
                                                        .frame(height: 54)
                                                        .offset(x: 10)
                                                )
                                        } else {
                                            Image("VideoClick")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 58, height: 58)
                                                .offset(x: 10)
                                                .overlay(
                                                    CircularProgressCameraView(progress: progress) // Attach the progress view here
                                                        .frame(height: 54)
                                                        .offset(x: 10)
                                                )
                                        }
                                    }
                                    .padding(.leading, 8)
                                    .offset(x: -10)
                                }
                                
                                Spacer()
                                
                                
                                // Preview Button
                                if(previewURL != "") {
                                    Button {
                                        self.mergeVideo()
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
                    //                        .navigationDestination(isPresented: $preview){
                    //                            if let url = URL(string: previewURL) {
                    //                                let isImage = !(url.absoluteString.lowercased().contains(".mp4") || url.absoluteString.lowercased().contains(".mov"))
                    //                                FinalPreview(controller: FinalPreviewController(url: url, isImage: isImage, speed: cameraModel.speed), songModel: cameraModel.songModel, speed: 1, showPreview: $cameraModel.showPreview,
                    //                                             url: .constant(url))
                    //                            }
                    //                            EmptyView()
                    //                        }
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
                //                    .opacity(!cameraModel.recordedURLs.isEmpty && cameraModel.previewURL != nil && !cameraModel.isRecording ? 1 : 0)
                
                
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
                
                if !filtersSheet{
                    Button {
                        photos.toggle()
                    } label: {
                        Image("UploadGalery")
                    }
                    
                    Spacer()
                    
                    Button {
                        Vm.bottomHide = true
                        filtersSheet.toggle()
                    } label: {
                        Image("CameraEffact")
                    }
                }
                
                
                
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            // filters
            .blurredSheet(.init(.clear), show: $filtersSheet) {
                
            } content: {
                if #available(iOS 16.0, *) {
                    FiltersSheet(Vm: Vm)
                        .presentationDetents([.large,.medium,.height(150)])
                        .background(Color.clear)
                } else {
                    // Fallback on earlier versions
                }
            }
            
        }
        
        //            .animation(.easeInOut, value: cameraModel.showPreview)
        .navigationBarHidden(true)
        .onAppear{
            player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: videoUrl)!))
            Vm.isVideo = true
            if let songUrl = URL(string: "\(getImageVideoBaseURL + audioUrl)") {
                // Create an AVAudioPlayer instance.
                print("songUrl: \(songUrl)")
                duoResource.downloadMusic(url: songUrl){audio in
                    self.musicURL = audio
                    print("audio: \(audio)")
                }
            }
            let asset = AVAsset(url: URL(string: videoUrl)!)
            self.cameraModel.maxDuration = asset.duration.seconds
            print("duration: \(self.cameraModel.maxDuration)")
        }
        .onDisappear{
            player.pause()
        }
        .background(Color.black)
    }
    
    func mergeVideo(){
        let video1URL = URL(string: videoUrl)
        let video2URL = URL(string: newVideoUrl)!
        let audioUrl = URL(string: musicURL)
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputURL = documentsDirectory.appendingPathComponent("\(Date())_mergevideo.mp4")
        let size = UIScreen.main.bounds.size
        
        duoResource.combineVideosWithAudio(video1URL: video1URL!, video2URL: video2URL, outputURL: outputURL) { error in
            if let error = error {
                print("Error combining videos: \(error.localizedDescription)")
            } else {
                // Input URL of the original video
                let size = UIScreen.main.bounds.size
                
                print("new size will be: \(size)")
                // Output URL for the resized video in the Documents directory
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let outputurl = documentsDirectory.appendingPathComponent("\(Date())_duovideo.mp4")
                
                cameraModel.resizeVideo(inputURL: outputURL, outputURL: outputurl, newWidth: size.width, newHeight: size.height) { success in
                    if success {
                        print("Merged video saved at: \(outputurl)")
                        previewURL = outputurl.absoluteString
                        self.duoVideoURL = outputurl.absoluteString
                        preview = true
                    } else {
                        print("Failed to resize video")
                    }
                }
            }
        }
    }
    
    func resizeVideo(url: URL) {
        // Input URL of the original video
        let size = UIScreen.main.bounds.size
        
        print("new size will be: \(size)")
        // Output URL for the resized video in the Documents directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputURL = documentsDirectory.appendingPathComponent("\(Date())_resized_video.mp4")
        
        cameraModel.resizeVideo(inputURL: url, outputURL: outputURL, newWidth: size.width, newHeight: size.height) { success in
            if success {
                print("Video resized successfully")
                previewURL = outputURL.absoluteString
                cameraModel.previewURL = outputURL
                newVideoUrl = previewURL
            } else {
                print("Failed to resize video")
            }
        }
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        
        let targetSize = UIScreen.main.bounds.size
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Use the minimum ratio to fit the image within the target size
        let ratio = min(widthRatio, heightRatio)
        
        // Calculate the new size for the image
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        // Calculate the center position offset
        let xOffset = (targetSize.width - newSize.width) / 2.0
        let yOffset = (targetSize.height - newSize.height) / 2.0
        
        // Create a new bitmap context with the new size
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        
        // Draw the image at the centered position
        image.draw(in: CGRect(x: xOffset, y: yOffset, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? UIImage()
    }
    
    func startProgressRecording() {
        progress = 0.0
        recordingDuration = 0.0
        let intervalDuration = 10.0 // Interval duration in seconds

        recordingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            recordingDuration += 1.0
            progress = recordingDuration / cameraModel.maxDuration

            if recordingDuration >= cameraModel.maxDuration {
                stopRecording()
                timer.invalidate()
            } else if recordingDuration.truncatingRemainder(dividingBy: intervalDuration) == 0 {
                // Implement interval-specific logic here
                // For example, you can show a message or take actions at intervals
            }
        }

        // Add the timer to the run loop to ensure it runs properly, and remove it when you're done with it.
        RunLoop.current.add(recordingTimer!, forMode: .common)
    }
    
    func stopRecording() {
        if isRecording {
            isRecording = false
            Vm.isRecording = true
            countdownText = 0
            print("stop recording")
            if cameraModel.songModel?.preview != nil {
                cameraModel.stopSong()
            }
            isPlaying = false
            self.audioPlayer?.stop()
            player.pause()
            if previewURL != ""{
                print(("video recorded"))
                print("previewURL: \(previewURL)")
                countdownTimer = self.countdownTimer2
                preview = true
            }
        }
    }
    
    func invalidateRecordingTimer() {
        recordingTimer?.invalidate()
    }


}


//struct Duo_Previews: PreviewProvider {
//    @State var url: String = ""
//    static var previews: some View {
//        DuoView(videoUrl: $url)
//    }
//}
