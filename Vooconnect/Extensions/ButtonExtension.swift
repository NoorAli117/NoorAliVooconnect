//
//  ButtonExtension.swift
//  Vooconnect
//
//  Created by JV on 22/02/23.
//

import Foundation
import SwiftUI
extension View{
    func button(action: @escaping () -> Void) -> some View{
        return Button(action: action, label: {self})
    }
    func label(text: String,fontSize:Double=6,spacing:Double=0,textColor:Color = ColorsHelper.white) -> some View{
        return VStack(spacing:spacing){
            self
            Text(text)
                .foregroundColor(textColor)
                .urbanistRegular(fontSize: fontSize)
        }
    }
    func topLabel(text: String,fontSize:Double=8,spacing:Double=3,textColor:Color = ColorsHelper.black) -> some View{
        return VStack(spacing:spacing){
            Text(text)
                .foregroundColor(textColor)
                .urbanistRegular(fontSize: fontSize)
                //.font(.system(size: fontSize, weight: .regular, design: .serif))
            self
        }
    }
    func hLabel(text: String,fontSize:Double=18,textColor:Color = ColorsHelper.black,spacing:Double=10) -> some View
    {
        return HStack(spacing:spacing){
            Text(text)
                .urbanistRegular(fontSize: fontSize)
                .multilineTextAlignment(.leading)
                .foregroundColor(textColor)
                //.font(.system(size: fontSize, weight: .light, design: .serif))
            self
           
        }
    }
}
