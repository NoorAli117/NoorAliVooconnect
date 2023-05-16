//
//  ColorsHelper.swift
//  Vooconnect
//
//  Created by JV on 21/02/23.
//

import Foundation
import SwiftUI
///In this class you can find all the colors that are used in the app, create new color set on `Assets` folder
class ColorsHelper
{
    static let white = Color("White1")
    static let black = Color("Black1")
    static let deepPurple = Color("deepPurple")
    static let midPurple = Color("MidPurple")
    static let lightPurple = Color("LightPurple")
    static let gray1 = Color("Gray1")
    static let gray2 = Color("Gray2")
    static let gray3 = Color("Gray3")
    static let gray4 = Color("Gray4")
    static let gray5 = Color("Gray5")
    static let pink1 = Color("Pink1")
    static let pink2 = Color("Pink2")
    
    
    static func purpleGradient() -> LinearGradient
    {
        let gradientPurple1 = Color("GradientPurple1")
        let gradientPurple2 = Color("GradientPurple2")
        return LinearGradient(gradient: Gradient(colors: [gradientPurple2, gradientPurple1]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static func purpleBlueGradient() -> LinearGradient
    {
        let color1 = Color("DeepBlue")
        let color2 = Color("BlueishPurple")
        return LinearGradient(gradient: Gradient(colors: [color2, color1]), startPoint: .leading, endPoint: .trailing)
    }
    
    static func purpleYellowGradient() -> LinearGradient
    {
        let color1 = Color("GradientPurpleYellow1")
        let color2 = Color("GradientPurpleYellow2")
        return LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .top, endPoint: .bottom)
    }
}
