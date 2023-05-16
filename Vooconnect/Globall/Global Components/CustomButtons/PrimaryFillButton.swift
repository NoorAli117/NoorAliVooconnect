//
//  PrimaryFillButton.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI

struct PrimaryFillButton: View{
    let title: String
    var icon = ""
    let isIconExist: Bool
    var height: CGFloat = 40
    var cornerRadius: CGFloat = 20
    var font = Font.urbanist(name: .urbanistBold)
    var gradient: LinearGradient = Color.primaryGradient
    var backgroundOpacity: CGFloat = 1
    var titleColor: Color = .white
    var renderMode: Image.TemplateRenderingMode = .original
    let action: (()->())
    
    var body: some View{
        Button {
            action()
        } label: {
            Spacer()
            if isIconExist{
                Image(icon)
                    .renderingMode(renderMode)
                    .foregroundColor(.white)
            }
            Text(title)
                .font(font)
                .foregroundColor(titleColor)
            Spacer()
        }
        .frame(height: height)
        .background(gradient.opacity(backgroundOpacity))
        .cornerRadius(cornerRadius)
    }
}
