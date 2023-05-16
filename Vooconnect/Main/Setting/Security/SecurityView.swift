//
//  SecurityView.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI

struct SecurityView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @StateObject var viewModel = SecurityViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing: 16) {
                Button {
                    presentaionMode.wrappedValue.dismiss()
                } label: {
                    Image("BackButton")
                }
                
                Text("Security")
                    .font(.urbanist(name: .urbanistBold, size: 24))
                Spacer()
            }
            .frame(height: 30)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 24){
                    Text("Control")
                        .font(.urbanist(name: .urbanistBold, size: 20))
                    
                    ControlRowView(title: "Security Alerts")
                    ControlRowView(title: "Manage Devices")
                    
                    Text("Security")
                        .font(.urbanist(name: .urbanistBold, size: 20))
                    
                    SecurityRowView(title: "Remember me", toggle: $viewModel.rememberMe)
                    SecurityRowView(title: "Face ID", toggle: $viewModel.faceId)
                    SecurityRowView(title: "Biometric ID", toggle: $viewModel.biometricId)
                    
                    PrimaryFillButton(
                        title: "Change PIN",
                        isIconExist: false,
                        height: 58,
                        cornerRadius: 29,
                        backgroundOpacity: 0.08,
                        titleColor: .buttionGradientOne){
                            
                        }
                    
                    PrimaryFillButton(
                        title: "Change Password",
                        isIconExist: false,
                        height: 58,
                        cornerRadius: 29,
                        backgroundOpacity: 0.08,
                        titleColor: .buttionGradientOne){
                            
                        }
                    
                }
                .padding(.top, 33)
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
    }
    
    func ControlRowView(title: String) -> some View{
        HStack{
            Text(title)
                .font(.urbanist(name: .urbanistSemiBold, size: 18))
            Spacer()
            Image("ArrowLogo")
        }
    }
    
    func SecurityRowView(title: String, toggle: Binding<Bool>) -> some View{
        HStack{
            Text(title)
                .font(.urbanist(name: .urbanistSemiBold, size: 18))
            Spacer()
            Toggle(isOn: toggle){}
                .tint(Color.buttionGradientOne)
                .padding(.trailing, 5)
        }
    }
}
