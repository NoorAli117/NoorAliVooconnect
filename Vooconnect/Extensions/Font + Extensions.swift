//
//  Font + Extensions.swift
//  Vooconnect
//
//  Created by Online Developer on 08/03/2023.
//

import SwiftUI

extension Font {
    
    enum Urbanist: String{
        case urbanistBold = "Urbanist-Bold"
        case urbanistRegular = "Urbanist-Regular"
        case urbanistLightItalic = "Urbanist-LightItalic"
        case urbanistExtraLightItalic = "Urbanist-ExtraLightItalic"
        case urbanistExtraBoldItalic = "Urbanist-ExtraBoldItalic"
        case urbanistThin = "Urbanist-Thin"
        case urbanistMediumItalic = "Urbanist-MediumItalic"
        case urbanistSemiBold = "Urbanist-SemiBold"
        case urbanistItalic = "Urbanist-Italic"
        case urbanistBlack = "Urbanist-Black"
        case urbanistBlackItalic = "Urbanist-BlackItalic"
        case urbanistLight = "Urbanist-Light"
        case urbanistSemiBoldItalic = "Urbanist-SemiBoldItalic"
        case urbanistBoldItalic = "Urbanist-BoldItalic"
        case urbanistExtraBold = "Urbanist-ExtraBold"
        case urbanistMedium = "Urbanist-Medium"
        case urbanistExtraLight = "Urbanist-ExtraLight"
        case urbanistThinItalic = "Urbanist-ThinItalic"
    }
    
    static func urbanist(name: Urbanist, size: CGFloat = 16) -> Font {
        return .custom(name.rawValue, size: size)
    }
    
}
