//
//  VooconnectApp.swift
//  Vooconnect
//
//  Created by Voconnect on 01/11/22.
//

import SwiftUI

@main
struct VooconnectApp: App {
    
    @State private var showLaunchView: Bool = true
    @State private var isAnimating: Bool = false
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    let uuid = UserDefaults.standard.string(forKey: "uuid")
    let tokenData = UserDefaults.standard.string(forKey: "accessToken")
    
    var body: some Scene {
        
        WindowGroup {
//            CustomeCameraHome()
//            EditTextView()
//            ARContainerView()
//              ARContainerView()
                ZStack {
    
                    if isOnboarding {
    
                        OnBoardingView()
    
                    } else if uuid == nil || tokenData == nil {   //  && tokenData == ""
    //                    if uuid == "" && tokenData == "" {
                            ContentView()
    //                    } else {
    //                        HomePageView()
    //                    }
    
                    } else {
    
                        HomePageView()
    
    //                    FillYourProfileView()
    //                    EqualizerSheet()
    //                    ReelsReportView()
    //                    SecurityView()
    
                    }
    
    
                }
                .overlay {
                    LaunchView()
                }

        }
    }
}
