//
//  SoundEditView.swift
//  Vooconnect
//
//  Created by Mac on 08/07/2023.
//

import SwiftUI
import SwiftUIBloc
import AVFoundation
import Foundation


struct SoundEditView: View {
    
    @StateObject var playerVM: PlayerViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var postModel: PostModel
    @State private var isRecording: Bool = false
    @State private var isButton: Bool = false
    @State private var progress: Double = 0
    @State private var videoDuration: Double = 0
    @State private var audioRecorder: AVAudioRecorder?
    @State private var outputUrl: URL?
    @StateObject var cameraModel = CameraViewModel()
//    var callWhenBack : () -> ()
    
    var body: some View{
        NavigationView{
            ZStack {
                MyVideoPlayerView(playerVM: playerVM)
                    .onDisappear{
                        playerVM.player.pause()
                    }
                
                VStack {
                    Spacer()
                    VStack(alignment: .center) {
                        ZStack {
                            ZStack {
                                Spacer()
                                CircularProgressView(progress: progress)
                                Button(action: {
                                    isRecording.toggle()
                                    if isRecording {
                                        startRecording()
                                        simulateVideoDownload()
                                    } else {
                                        stopRecording()
                                    }
                                }) {
                                    Image(systemName: self.isRecording ? "mic.fill" : "mic")
                                        .font(.system(size: 40))
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(width: 50, height: 50)
                            
                            if self.isButton {
                                HStack {
                                    Button(action: {
                                        withAnimation {
                                            cameraModel.previewURL = postModel.contentUrl
//                                            self.callWhenBack()
                                            
                                            isButton = false
                                        }
                                    }) {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(LinearGradient(
                                                gradient: Gradient(colors: [Color("buttionGradientTwo"), Color("buttionGradientOne")]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ))
                                            .frame(width: 98, height: 56)
                                            .overlay(
                                                Text("Done")
                                                    .foregroundColor(.white)
                                            )
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
            }
        }
        .onAppear {
            prepareAudioRecorder()
            let url = postModel.contentUrl?.absoluteString
            print("duration url: \(String(describing: url))")
            if let videoURL = URL(string: url!) {
                videoDuration = getVideoDuration(url: videoURL)!
                print("Video duration: \(videoDuration) seconds")
            } else {
                print("Video file not found.")
            }
        }
    }
    
    func simulateVideoDownload() {
        let stepFrequency = 10 // Number of steps per second (adjust as desired)
        let totalProgressSteps = Int(videoDuration) * stepFrequency
        let stepDuration = 1.0 / Double(totalProgressSteps)

        DispatchQueue.global(qos: .background).async {
            for i in 0..<totalProgressSteps {
                usleep(useconds_t(stepDuration * 1_000_000)) // Simulating delay in audio progress
                
                DispatchQueue.main.async {
                    progress = Double(i + 1) / Double(totalProgressSteps)
                    
                    if i == totalProgressSteps - 1 {
                        isRecording = false
                        print("Audio download completed")
                        stopRecording()
                    }
                }
            }
        }
    }

    
    func prepareAudioRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return
            }
            
            let audioURL = documentDirectory.appendingPathComponent("\(Date()).m4a")
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder?.prepareToRecord()
        } catch {
            print("Failed to prepare audio recorder: \(error.localizedDescription)")
        }
    }
    
    func startRecording() {
        guard let audioRecorder = audioRecorder else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            audioRecorder.record()
            print("Audio recording started")
        } catch {
            print("Failed to start audio recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        guard let audioRecorder = audioRecorder else {
            return
        }
        audioRecorder.stop()
        print("Recording stopped.")
        
        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            
            removeAudioFromVideo(videoURL: postModel.contentUrl!) { outputURL, error in
                if let error = error {
                    print("Failed to remove audio: \(error.localizedDescription)")
                } else {
                    print("Audio removed successfully.")
                    DispatchQueue.main.async {
                        let audioUrlPath = audioRecorder.url.path
                        print("Audio URL Path: \(audioUrlPath)")
                        let videoUrlPath = outputURL?.path
                        print("Video URL Path: \(videoUrlPath ?? "")")
                        
                        mergeAudioToVideo(sourceAudioPath: audioUrlPath, sourceVideoPath: videoUrlPath!) { url, error in
                            if let error = error {
                                print("Error merging audio and video: \(error.localizedDescription)")
                            } else if let mergedURL = url {
                                self.outputUrl = mergedURL
                                print("Merged audio and video URL: \(mergedURL)")
                                postModel.contentUrl = mergedURL
                                print("New URL: \(String(describing: postModel.contentUrl))")
                                playerVM.reset(videoUrl: mergedURL)
                                isButton = true
                            }
                        }
                    }
                }
            }
            
            print("Recording playback started.")
        } catch {
            print("Failed to play the recording: \(error.localizedDescription)")
        }
    }


    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        return paths[0]
    }
    
    
    
    
    
        var backButton: some View {
                Button(action: {
                    // Handle back button action here
                    print("back")
                    presentationMode.wrappedValue.dismiss()
                    playerVM.player.pause()
                }) {
                    Image(systemName: "chevron.left")
    //                Text("Back")
                }
            }
}
class AudioCaptureDelegate: NSObject, AVCaptureAudioDataOutputSampleBufferDelegate {
    private let sampleBufferHandler: (CMSampleBuffer) -> Void
       
       init(sampleBufferHandler: @escaping (CMSampleBuffer) -> Void) {
           self.sampleBufferHandler = sampleBufferHandler
       }
       
       func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
           sampleBufferHandler(sampleBuffer)
       }
}

struct MusicItemView: View {
    @State var songName: String
    @State var songArtist: String
    @Binding var image: String
    @State var songModel : DeezerSongModel
    @EnvironmentObject var soundsViewBloc: SoundsViewBloc
    
    var body: some View {
        VStack {
            BlocBuilderView(bloc: soundsViewBloc) { state in
                ZStack{
                    AsyncImage(url: URL(string: image))
                    //                .resizable()
                    //                .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(16)
                    if(state.wrappedValue.preview != nil && state.wrappedValue.preview == songModel)
                    {
                        Image("PlayWhiteN")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                .frame(alignment: .center)
                .button {
                    soundsViewBloc.playSong(songModel: songModel)
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(songName)
                    .font(.custom("Urbanist-Bold", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.901334851)))
                
                HStack {
                    
                    Text(songArtist)  // Medium
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.6976148593)))
                    
                    Spacer()
                    
                    Text("65.1M")
                        .font(.custom("Urbanist-SemiBold", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.6976148593)))
                }
                
            }
        }
    }
}

