//
//  EqualizerSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 04/01/23.
//

import SwiftUI
import Foundation
import AVFoundation

struct EqualizerSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentValue1 = 50.0
    @State private var isPlaying = false
    @State private var custome: Bool = false
    @State private var dance: Bool = false
    @State private var jazz: Bool = true
    @State private var pop: Bool = false
    @State private var hipHop: Bool = false
    @State private var pitch: Double = 1.0
    
    // Variables
    private let player = AVAudioPlayerNode()
    private let audioEngine = AVAudioEngine()
    @State private var audioFileBuffer: AVAudioPCMBuffer?
    @State private var EQNode: AVAudioUnitEQ?
    
    var body: some View {
        VStack {
            Text("Equalizer")
                .font(.custom("Urbanist-Bold", size: 24))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                .padding(.top)
            
            ScrollView {
                
                VStack(spacing: 23) {
                    
                    // 1
                    VStack {
                        
                        HStack {
                            
                            Text("32 HZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                    
                    // 2
                    VStack {
                        
                        HStack {
                            
                            Text("63 HZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                    
                    // 3
                    VStack {
                        
                        HStack {
                            
                            Text("125 HZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                    
                    // 4
                    VStack {
                        
                        HStack {
                            
                            Text("250 HZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                    
                    // 5
                    VStack {
                        
                        HStack {
                            
                            Text("500 HZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                    
                    // 6
                    VStack {
                        
                        HStack {
                            
                            Text("1 KHZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                    
                    // 7
                    VStack {
                        
                        HStack {
                            
                            Text("2 KHZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                    
                    // 8
                    VStack {
                        
                        HStack {
                            
                            Text("4 KHZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                    
                    // 9
                    VStack {
                        
                        HStack {
                            
                            Text("8 KHZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                    
                    // 10
                    VStack {
                        
                        HStack {
                            
                            Text("16 KHZ")
                                .font(.custom("Urbanist-Bold", size: 18))
                                .offset(y: 5)
                            Spacer()
                            //                        Text("80")
                            Text("\(currentValue1, specifier: "%.0F")")
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("GradientOne"),
                                        Color("GradientTwo"),
                                    ], startPoint: .top, endPoint: .bottom))
                        }
                        CustomeSliderView(value: $currentValue1,
                                          sliderRange: 0...100)
                        .frame(height: 6)
                        .padding(.top, -10)
                        .padding(.trailing, 0.5)
                    }
                }
            }
            .padding(.horizontal, 50)
            
            // custome jazz
            HStack {
                
                Button {
                    custome = true
                    dance = false
                    jazz = false
                    pop = false
                    hipHop = false
                } label: {
                    if custome {
                    Text("Custom")
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundColor(.white)
                        .padding()
//                        .padding(.horizontal)
                        .background(
                            LinearGradient(colors: [
                                Color("EqualizerButtonGOne"),
                                Color("EqualizerButtonGTwo"),
                            ], startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(16)
                        
                    } else {
                        Text("Custom")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                            .padding(.leading)
                    }
                    
                }
                
                Spacer()
                
                Button {
                    custome = false
                    dance = true
                    jazz = false
                    pop = false
                    hipHop = false
                } label: {
                    
                    if dance {
                        Text("Dance")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                            .padding()
//                            .padding(.horizontal)
                            .background(
                                LinearGradient(colors: [
                                    Color("EqualizerButtonGOne"),
                                    Color("EqualizerButtonGTwo"),
                                ], startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(16)
                    } else {
                        Text("Dance")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                    }
                    
                }
                
                Spacer()
                
                Button {
                    custome = false
                    dance = false
                    jazz = true
                    pop = false
                    hipHop = false
                } label: {
                    if jazz {
                        Text("Jazz")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                            .padding()
//                            .padding(.horizontal)
                            .background(
                                LinearGradient(colors: [
                                    Color("EqualizerButtonGOne"),
                                    Color("EqualizerButtonGTwo"),
                                ], startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(16)
                    } else {
                        Text("Jazz")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Button {
                    custome = false
                    dance = false
                    jazz = false
                    pop = true
                    hipHop = false
                } label: {
                    if pop {
                        Text("Pop")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                            .padding()
//                            .padding(.horizontal)
                            .background(
                                LinearGradient(colors: [
                                    Color("EqualizerButtonGOne"),
                                    Color("EqualizerButtonGTwo"),
                                ], startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(16)
                    } else {
                        Text("Pop")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Button {
                    custome = false
                    dance = false
                    jazz = false
                    pop = false
                    hipHop = true
                } label: {
                    if hipHop {
                        Text("hip Hop")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                            .padding()
//                            .padding(.horizontal)
                            .background(
                                LinearGradient(colors: [
                                    Color("EqualizerButtonGOne"),
                                    Color("EqualizerButtonGTwo"),
                                ], startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(16)
                    } else {
                        Text("hip Hop")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }
                }
                
                
                

            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color(#colorLiteral(red: 0.4039215686, green: 0.2274509804, blue: 0.7019607843, alpha: 1)))
            .padding(.bottom, 10)
            
            // cancell Button
            HStack {
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
//                    Spacer()
                    Text("Cancel")
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundStyle(
                            LinearGradient(colors: [
                                Color("buttionGradientTwo"),
                                Color("buttionGradientOne"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding()
                        .padding(.horizontal, 40)
//                    Spacer()
                }
                .background(Color("SkipButtonBackground"))
                .cornerRadius(40)
                
                Spacer()
                
                Button {
                    
                } label: {
//                    Spacer()
                    Text("Submit")
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 40)
//                    Spacer()
                }
                .background(
                    LinearGradient(colors: [
                        Color("buttionGradientTwo"),
                        Color("buttionGradientOne"),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(40)
                
            }
            .padding(.horizontal, 20)
            
        }
    }
    
    fileprivate func setUpEngine(with name: String, frequencies: [Int]) {
        // Load a music file
        do {
          guard let musicUrl = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
          let audioFile = try AVAudioFile(forReading: musicUrl)
          self.audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: UInt32(audioFile.length))
          try audioFile.read(into: audioFileBuffer!)
        } catch {
          assertionFailure("failed to load the music. Error: \(error)")
          return
        }
         
        // initial Equalizer.
        EQNode = AVAudioUnitEQ(numberOfBands: frequencies.count)
        EQNode!.globalGain = 1
        for i in 0...(EQNode!.bands.count-1) {
          EQNode!.bands[i].frequency = Float(frequencies[i])
          EQNode!.bands[i].gain    = 0
          EQNode!.bands[i].bypass   = false
          EQNode!.bands[i].filterType = .parametric
        }
         
        // Attach nodes to an engine.
        audioEngine.attach(EQNode!)
        audioEngine.attach(player)
         
        // Connect player to the EQNode.
        let mixer = audioEngine.mainMixerNode
        audioEngine.connect(player, to: EQNode!, format: mixer.outputFormat(forBus: 0))
         
        // Connect the EQNode to the mixer.
        audioEngine.connect(EQNode!, to: mixer, format: mixer.outputFormat(forBus: 0))
         
        // Schedule player to play the buffer on a loop.
        if let audioFileBuffer = audioFileBuffer {
          player.scheduleBuffer(audioFileBuffer, at: nil, options: .loops, completionHandler: nil)
        }
      }
    
    private func playAudio() {
            do {
                try audioEngine.start()
                player.play()
            } catch {
                print("Error playing audio: \(error)")
            }
        }
        
        private func stopAudio() {
            player.stop()
            audioEngine.stop()
        }
}

struct EqualizerSheet_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerSheet()
    }
}

struct CustomeSliderView: View {
    @Binding var value: Double
    
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100
    var thumbColor: Color = .yellow
    var minTrackColor: Color = .blue
    var maxTrackColor: Color = .gray
    
    var body: some View {
        GeometryReader { gr in
            let thumbHeight = gr.size.height * 1.1
            let thumbWidth = gr.size.width * 0.05 // 0.03
            let radius = gr.size.height * 0.5
            let minValue = gr.size.width * 0.00 // 0.015
            let maxValue = (gr.size.width * 0.98) - thumbWidth //0.98
            
            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            
            ZStack {
                Rectangle()
                    .foregroundColor(maxTrackColor)
                    .frame(width: gr.size.width, height: gr.size.height * 0.95)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                HStack {
                    Rectangle()
                        .foregroundColor(Color("GradientOne"))
//                        .foregroundColor(Color(#colorLiteral(red: 0.4823529412, green: 0.1215686275, blue: 0.6078431373, alpha: 1)))
                    .frame(width: sliderVal, height: gr.size.height * 0.95) // 0.95
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: radius))
                HStack {
                    Circle()
                        .fill(
                            LinearGradient(colors: [
                                Color("GradientOne"),
                                Color("GradientTwo"),
                            ], startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: 24, height: 24)
                        .offset(x: sliderVal)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { v in
                                    if (abs(v.translation.width) < 0.1) {
                                        self.lastCoordinateValue = sliderVal
                                    }
                                    if v.translation.width > 0 {
                                        let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
                                    } else {
                                        let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                    }
                               }
                        )
                    Spacer()
                }
            }
        }
    }
}
