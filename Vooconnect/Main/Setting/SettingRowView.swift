//
//  SettingRowView.swift
//  Vooconnect
//
//  Created by OnlineDeveloper on 19/02/2023.
//

import SwiftUI

struct SettingRowView: View {
    
    let settingRowType: SettingRowType
    @StateObject var settingViewModel: SettingViewModel
    let action: (()->())
    
    var body: some View {
        Button{
            action()
        } label: {
            HStack(spacing: 8){
                
                Image(settingRowType.iconName)
                Text(settingRowType.title)
                
                Spacer()
                
                if settingRowType == .language {
                    Text("English (US)")
                }
                
                if settingRowType == .darkMode{
                    Toggle(isOn: $settingViewModel.isDarkModeOn) {}
                        .tint(Color.buttionGradientOne)
                }
                
                Image("ArrowLogo")
            }
            .font(.custom("Urbanist-SemiBold", size: 18))
            .foregroundStyle(
                LinearGradient(colors: [
                    Color(settingRowType == .logout ? "buttionGradientTwo" : "Black"),
                    Color(settingRowType == .logout ? "buttionGradientOne" : "Black"),
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
    }
}
