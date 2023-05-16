//
//  LogOutSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI
import Swinject

struct LogOutView: View {
    var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    var appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!
    
    var body: some View {
        VStack(spacing: 0){
            Text("Logout")
                .font(.urbanist(name: .urbanistBold, size: 24))
                .gradientForeground(colors: [.buttionGradientTwo, .buttionGradientOne])
                .padding(.top, 35)
            
            Divider()
                .padding(.top, 24)
            
            Text("Are you sure you want to log out?")
                .font(.urbanist(name: .urbanistBold, size: 20))
                .padding(.top, 24)
            
            HStack(spacing: 12){
                PrimaryFillButton(
                    title: "Cancel",
                    isIconExist: false,
                    height: 58,
                    cornerRadius: 29,
                    backgroundOpacity: 0.08,
                    titleColor: .buttionGradientOne){
                        appEventsManager.hideBottomSheet.send(true)
                    }
                
                PrimaryFillButton(
                    title: "Yes, Logout",
                    isIconExist: false,
                    height: 58,
                    cornerRadius: 29){
                        UserDefaults.standard.set(nil, forKey: "uuid")
                        UserDefaults.standard.set(nil, forKey: "accessToken")
                        userAuthanticationManager.logout()
                        appEventsManager.hideBottomSheet.send(true)
                        appEventsManager.logoutButtonPressed.send(true)
                    }
            }
            .padding([.top, .bottom], 24)
        }
        .padding(.horizontal, 24)
    }
}
