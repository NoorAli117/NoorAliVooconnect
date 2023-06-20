//
//  AdjustVideoView.swift
//  Vooconnect
//
//  Created by Mac on 16/06/2023.
//



import SwiftUI
import CoreMedia

struct SliderView: View {
    @ObservedObject var playerManager: PlayerViewModel
    @ObservedObject var slider: CustomSlider
    @Binding var frames: [UIImage]
    @State private var sliderCurrentValue = 0.0
    @Binding var isEditingSlider: Bool
    @Binding var validError: Bool
    var handleMoved: Bool {
        return slider.lowHandle.currentValue > 1 || slider.highHandle.currentValue < playerManager.player.currentItem!.asset.duration.seconds
    }
    
    var body: some View {
        ZStack {
//            if validError {
//                Color.black.opacity(0.8)
//                    .ignoresSafeArea()
//                    .overlay(MyAlertInfo(title: "Rognage impossible", message: "Veuillez sélectionner un zone de rognage correcte", ok: "OK",
//                                         showAlert: $validError))
//                    .zIndex(20.0)
//            }
            //Path between both handles
            SliderPathBetweenView(frames: $frames, handleMoved: handleMoved, slider: slider)
            
            //Low Handle
            SliderHandleView(handle: slider.lowHandle, handelImage: handleMoved ? "lower_bound_moved" : "lowerBound")
                .highPriorityGesture(slider.lowHandle.sliderDragGesture)
                .onChange(of: slider.lowHandle.currentValue) { value in
                    if value >= slider.highHandle.currentValue {
                        validError.toggle()
                        slider.reset(start: 1, end: playerManager.player.currentItem!.asset.duration.seconds)
                    } else {
                        playerManager.seekVideo(toPosition: CGFloat(value - 1.0))
                        slider.middleHandle.currentLocation = slider.lowHandle.currentLocation
                    }
                }
            
            //High Handle
            SliderHandleView(handle: slider.highHandle, handelImage: handleMoved ? "higher_bound_moved" : "upperBound")
                .highPriorityGesture(slider.highHandle.sliderDragGesture)
                .onChange(of: slider.highHandle.currentValue) { value in
                    if value <= slider.lowHandle.currentValue {
                        validError.toggle()
                        slider.reset(start: 1, end: playerManager.player.currentItem!.asset.duration.seconds)
                    } else {
                        playerManager.seekVideo(toPosition: CGFloat(value - 1.0))
                        slider.middleHandle.currentLocation.x = slider.highHandle.currentLocation.x - 20.0
                    }
                }
            
            //Middle Handle
//            SliderCursorView(handle: slider.middleHandle, handelImage: "ic_video_cursor")
//                .highPriorityGesture(slider.middleHandle.sliderDragGesture)
//                .onChange(of: slider.middleHandle.currentValue) { value in
//                    if value > slider.lowHandle.currentValue && value < slider.highHandle.currentValue {
//                        playerManager.seekVideo(toPosition: CGFloat(value - 1.0))
//                    } else {
//                        slider.middleHandle.currentLocation = slider.lowHandle.currentLocation
//                    }
//                }
//                .onChange(of: playerManager.currentTime) { time in
//                    if
////                        slider.middleHandle.currentLocation.x < slider.lowHandle.currentLocation.x ||
//                            slider.middleHandle.currentLocation.x + 20.0 > slider.highHandle.currentLocation.x {
//                        if playerManager.isPlaying {
//                            playerManager.playPause()
//                        }
//                        return
//                    }
//                    if let currentItem = playerManager.player.currentItem {
//                        slider.middleHandle.currentLocation.x = (time / currentItem.duration.seconds) * 280
//                    }
//                }
//                .onChange(of: playerManager.isFinishedPlaying) { finished in
//                    if finished {
////                        playerManager.seekVideo(toPosition: 0.0)
//                        slider.middleHandle.currentLocation = slider.lowHandle.currentLocation
//                    }
//                }
        }
        .frame(width: slider.width, height: slider.lineWidth)
    }
}

struct SliderHandleView: View {
    @ObservedObject var handle: SliderHandle
    var handelImage: String
    
    var body: some View {
        Image(handelImage)
            .resizable()
            .frame(width: 23.95, height: 71)
            .position(x: handle.currentLocation.x, y: handle.currentLocation.y + 29)
    }
}

struct SliderCursorView: View {
    @ObservedObject var handle: SliderHandle
    var handelImage: String
    var body: some View {
        Image(handelImage)
            .position(x: handle.currentLocation.x + 10, y: handle.currentLocation.y + 29)
    }
}

struct SliderPathBetweenView: View {
    @Binding var frames: [UIImage]
    var handleMoved: Bool
    @ObservedObject var slider: CustomSlider
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(frames, id: \.self) { frame in
                Image(uiImage: frame)
                    .resizable()
                    .scaledToFill()
                    .frame(width:17, height: 65)
                    .clipped()
            }
        }
        .overlay(VStack {
            HStack {
                Rectangle()
                    .foregroundColor(handleMoved ? Color(uiColor: UIColor(red: 0.29, green: 0.27, blue: 0.29, alpha: 1.00)) : .black)
                    .frame(width: slider.highHandle.currentLocation.x - 2.0 - slider.lowHandle.currentLocation.x, height: 5.5)
                    .offset(x: slider.lowHandle.currentLocation.x, y: 11)
                Spacer()
            }
            HStack {
                Rectangle()
                    .foregroundColor(.white.opacity(0.35))
                    .frame(width: slider.lowHandle.currentLocation.x, height: 65)
                Spacer()
                Rectangle()
                    .foregroundColor(.white.opacity(0.35))
                    .frame(width: slider.width - slider.highHandle.currentLocation.x, height: 65)
            }
            HStack {
                Rectangle()
                    .foregroundColor(handleMoved ? Color(uiColor: UIColor(red: 0.29, green: 0.27, blue: 0.29, alpha: 1.00)) : .black)
                    .frame(width: slider.highHandle.currentLocation.x - 2.0 - slider.lowHandle.currentLocation.x, height: 5.5)
                    .offset(x: slider.lowHandle.currentLocation.x, y: -10)
                Spacer()
            }
        })
    }
}
