//
//  SwitchAccountView.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI
import Swinject

struct SwitchAccountView: View {
    private var appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!
    private var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    
    @StateObject var switchAccountViewModel = SwitchAccountViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing: 24){
                Text("Switch Account")
                    .font(.urbanist(name: .urbanistBold, size: 24))
                Divider()
                
                ForEach(switchAccountViewModel.userProfiles, id: \.self){ profile in
                    SwitchAccountRowView(profile: profile, isSelected: userAuthanticationManager.userDetail?.uuid == profile.uuid){
                        UserDefaults.standard.set(profile.uuid, forKey: "uuid")
                        UserDefaults.standard.set(profile.jwt, forKey: "accessToken")
                        userAuthanticationManager.jwt = profile.jwt
                        userAuthanticationManager.refreshUserDetails()
                        appEventsManager.restartApp.send(true)
                        appEventsManager.hideBottomSheet.send(true)
                    }
                }
                
                Button{
                    appEventsManager.hideBottomSheet.send(true)
                    appEventsManager.presentLoginView.send(true)
                } label: {
                    AddAccountRowView()
                }
                
                Spacer()
            }
            .padding(24)
        }
    }
}

struct SwitchAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchAccountView()
    }
}
