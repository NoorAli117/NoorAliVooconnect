//
//  DuoView.swift
//  Vooconnect
//
//  Created by Mac on 18/09/2023.
//

import Foundation
import AVFoundation
import SwiftUI
//import FFmpeg

struct DuoView: View{
    
    @Binding var videoUrl: String
    @State var newVideoUrl: String = ""
    @State private var circleProgress: CGFloat = 0.2
    @State private var widthAndHeight: CGFloat = 90
    @State private var progressColor: Color = .red
    @Environment(\.presentationMode) var presentaionMode
    
    @StateObject var cameraModel = CameraViewModel()
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
    @State private var isShowPopup: Bool = false
    @State private var previewURL: String = ""
    var toast_main_position = CGPoint(x: 0, y: 0)
    
    @State var player = AVPlayer()
    
    var Vm = ViewModel()
    var cameraInfoData: ((_ content: Any) -> Void)?
    
    @State private var isProcessing = false
    @State private var outputURL: URL?
    
    
    var body: some View {
        
        NavigationView {
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
                
                if let url = cameraModel.previewURL ,cameraModel.showPreview {
                    let isImage = !(url.absoluteString.lowercased().contains(".mp4") || url.absoluteString.lowercased().contains(".mov"))
                    NavigationLink(
                        destination: FinalPreview(controller: FinalPreviewController(url: url, isImage: isImage, speed: cameraModel.speed), songModel: cameraModel.songModel, speed: cameraModel.speed, showPreview: $cameraModel.showPreview,
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
                    HStack{
                        CustomVideoPlayer(player: player)
                        MainViewRepresenter(Vm: Vm, cameraInfoData: { content in
                            if let image = content as? UIImage {
                                print(image)
                                let videoPath = "output_video.mp4"
                                // Perform video creation and merging asynchronously
                                DispatchQueue.global().async {
                                    camera.createVideoFromImage(image: image, originalSize: image.size, duration: 30.0) { result in
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
                            } else if let videoInfo = content as? [String: Any] {
                                print(videoInfo)
                                if let filePath = videoInfo["filePath"] as? URL{
                                    print(filePath)
//                                    runFFmpegCommand(originalVideo: videoUrl, newVideo: filePath){ url in
//                                        previewURL = url.absoluteString
//                                        cameraModel.previewURL = url
//                                        print("url---------\(filePath)")
//                                    }
                                    previewURL = filePath.absoluteString
                                    cameraModel.previewURL = filePath
                                }
                            }
                        }, height: 200)
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
                            if !Vm.bottomHide {
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
                                            if tapcount == 0{
                                                timerRunning = true
                                                tapcount = 1
                                                DispatchQueue.main.asyncAfter(deadline: .now() + Double(countdownTimer)) {
                                                    timerRunning = false
                                                    Vm.isRecording = true
                                                }
                                            }else{
                                                Vm.isRecording = true
                                                countdownText = 0
                                                tapcount = 0
                                            }
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
            .onAppear{
                player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: getImageVideoBaseURL + videoUrl)!))
                Vm.isVideo = true
            }
            .background(Color.black)
        }
        
        
    }
    
//    func runFFmpegCommand(originalVideo: URL, newVideo: URL, completion: @escaping (URL?) -> Void) {
//        // Create a unique output file path.
//        let outputPath = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
//
//        // Create a new FFmpeg instance.
//        let ffmpeg = FFmpeg()
//
//        // Add the input and output files to the FFmpeg queue.
//        ffmpeg.addInputFile(originalVideo)
//        ffmpeg.addInputFile(newVideo)
//        ffmpeg.addOutputFile(outputPath)
//
//        // Set the output codec to MP4.
//        ffmpeg.setOutputCodec("mp4")
//
//        // Add the hstack filter to the FFmpeg queue.
//        ffmpeg.addFilter("hstack=inputs=2")
//
//        // Start the transcoding process asynchronously.
//        DispatchQueue.global(qos: .background).async {
//            ffmpeg.startTranscoding()
//
//            // Wait for the transcoding process to finish.
//            let success = ffmpeg.waitForTranscodingToFinish()
//            
//            // Return the output URL or nil if the operation failed.
//            DispatchQueue.main.async {
//                completion(success ? outputPath : nil)
//            }
//        }
//    }


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


//struct Duo_Previews: PreviewProvider {
//    @State var url: String = ""
//    static var previews: some View {
//        DuoView(videoUrl: $url)
//    }
//}
