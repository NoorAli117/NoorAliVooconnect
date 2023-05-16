//
//  ButtonWithBorder.swift
//  Vooconnect
//
//  Created by Online Developer on 11/03/2023.
//

import SwiftUI

struct ButtonWithBorder: View {
    let title: String
    let icon: String
    var isIconExist: Bool = true
    var width: CGFloat = 150
    var height: CGFloat = 45
    let action: (()->())
    
    var body: some View {
        Button{
            action()
        } label: {
            HStack(spacing: 9.6){
                if isIconExist{
                    Image(icon)
                        .resizable()
                        .frame(width: 16.6, height: 16.6)
                }
                Text(title)
                    .font(.urbanist(name: .urbanistBold, size: 18))
                    .gradientForeground(colors: [Color.buttionGradientTwo, Color.buttionGradientOne])
            }
            .frame(width: width, height: height)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.primaryGradient, lineWidth: 2)
            )
        }
    }
}
