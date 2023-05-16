//
//  ProfileViewersView.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 26/04/2023.
//

import SwiftUI

struct ProfileViewersView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @StateObject var profileViewersViewModel = ProfileViewersViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 16) {
                Button {
                    presentaionMode.wrappedValue.dismiss()
                } label: {
                    Image("BackButton")
                }
                
                Text("Profile Viewers")
                    .font(.urbanist(name: .urbanistBold, size: 24))
                Spacer()
            }
            .frame(height: 30)
            
            GeometryReader{ geometry in
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 24){
                        if profileViewersViewModel.profileViewers.count < 1{
                            Spacer()
                            
                            HStack{
                                Spacer()
                                Text("No Profile Viewer")
                                    .font(.urbanist(name: .urbanistLight))
                                Spacer()
                            }
                            
                            Spacer()
                        }else{
                            ForEach(profileViewersViewModel.profileViewers, id:\.self){ user in
                                ProfileViewersCell(user: user) { user in
                                    onSwitchedUserStatus(user: user)
                                }
                            }
                        }
                    }
                    .padding(.top, 33)
                    .frame(height: geometry.size.height)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
    }
    
    /// On Switch User Status update the isSwitched from viewModel
    func onSwitchedUserStatus(user: UserDetail){
        let index = profileViewersViewModel.profileViewers.firstIndex { $0.uuid == user.uuid }
        if let index{
            profileViewersViewModel.profileViewers[index].isSwitched.toggle()
        }
    }
}
