//
//  OnBoardingView.swift
//  Vooconnect
//
//  Created by Vooconnect on 07/11/22.
//

import SwiftUI

struct OnBoardingStep {
    let image: String
    let title: String
    let description: String
}

private let onBoardingSteps = [
OnBoardingStep(image: "OnBordingOneImg", title: "Watch interesting videos from around the world", description: ""),
OnBoardingStep(image: "OnBordingTwoImg", title: "Connect with friends, family, find new friends, find creators", description: ""),
OnBoardingStep(image: "OnBordingThreeImg", title: "Chat, call, video call, video conference, and walkie talkie", description: "")
]

struct OnBoardingView: View {
    @State private var currentStep = 0
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
//    init() {
//        UIScrollView.appearance().bounces = false
//    }
    
    var body: some View {
        
        ZStack {
            Color(.white)
                    .ignoresSafeArea()
            VStack {
                
                TabView(selection: $currentStep) {
                    ForEach(0..<onBoardingSteps.count) { it in
                        VStack {
                            Image(onBoardingSteps[it].image)
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                                .padding(.horizontal)
                                .padding(.top, 55)
                            
//                            Spacer()
                            
                            Text(onBoardingSteps[it].title)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("Black"))
                                .font(.custom("Urbanist-Bold", size: 36))
                                .padding(.horizontal)
                            
                        }
                        .tag(it)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    ForEach(0..<onBoardingSteps.count) { it in
                        if it == currentStep {
                            Rectangle()
                                .fill(LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                                .frame(width: 28, height: 8)
                                .cornerRadius(10)
                            
                        } else {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(Color("GrayTwo"))
                        }
                    }
                }
                .padding(.bottom, 50)
                
                Button {
                    if self.currentStep < onBoardingSteps.count - 1 {
                        self.currentStep += 1
                    } else {
                        isOnboarding = false
                    }
                } label: {
                    Text(currentStep < onBoardingSteps.count - 1 ? "Next" : "Get Started")
                        .font(.custom("Urbanist-Bold", size: 16))
                        .padding(18)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(colors: [
                                Color("buttionGradientTwo"),
                                Color("buttionGradientOne"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .cornerRadius(40)
                        .padding(.horizontal, 16)
                        .foregroundColor(.white)
                    
                }
                Spacer()
            }
        }
//        .overlay {
//            LaunchView()
//        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
