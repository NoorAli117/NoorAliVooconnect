//
//  LaunchView.swift
//  Vooconnect
//
//  Created by Vooconnect on 25/11/22.
//

import SwiftUI

struct LaunchView: View {
    
//    @Binding var showLaunchView: Bool
    
    @State var isAnimating: Bool = false
    
    func foreverAnimation(_ thisDelay:Double = 0) -> Animation{
        
        return Animation.easeInOut(duration: 1.5)
            .repeatForever(autoreverses: false)
            .delay(thisDelay/8)
    }
    
    var numberOfCircles = 7
    @State var isFinished = false
    
    @State var totalAngle:Double = 0
    
    var body: some View {
        
        if !isFinished {
            
            ZStack {
                Color.white
                    .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    Spacer()
                    Image("vooconnectLogoTwo")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 95)
                        .padding(.horizontal, 20)
                    Spacer()
//                    Image("Vector")
                    
                    ZStack{
                        ForEach(0..<numberOfCircles){i in
//                            VStack{
//                                Circle().frame(width:15, height:15)
////                                    .fill(
////                                        LinearGradient(colors: [
////                                            Color("YelloOne"),
////                                            Color("YelloTwo"),
////                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
////                                    )
//                                    .foregroundColor(Color("YelloTwo"))
//
//
//                                Spacer()
//                            }
//                            .frame(width:70, height:70)
////                                .opacity(1 - (Double(i)/Double(self.numberOfCircles)))
                        Image("Vector")
                                .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
                                .animation(self.foreverAnimation(Double(5))) // 5 i
                        }
                    }
                    .onAppear {
                        self.isAnimating.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isFinished.toggle()
                        }
                    }
                    Spacer()
                    
                }
               
            }
            
        } else {
            
        }
        
        
            
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
