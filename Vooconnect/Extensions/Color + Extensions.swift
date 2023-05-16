//
//  Color + Extensions.swift
//  Vooconnect
//
//  Created by Online Developer on 08/03/2023.
//

import SwiftUI

extension Color{
    static let pink1 = Color("Pink1")
    static let customBlack = Color("Black")
    static let customGray = Color("gray") // #9E9E9E
    static let grayThree = Color("GrayThree")
    static let grayEight = Color("GrayEight")
    static let grayNine = Color("GrayNine") // #F5F5F5
    static let grayTen = Color("GrayTen") //#C8C8C8
    static let green1 = Color("Green1") //#007E42
    static let buttionGradientTwo = Color("buttionGradientTwo")
    static let buttionGradientOne = Color("buttionGradientOne")
    static let grayOne = Color("grayOne")
    static let gradientOne = Color("GradientOne")
    static let gradientTwo = Color("GradientTwo")
    static let primaryGradient = LinearGradient(colors: [buttionGradientTwo, buttionGradientOne], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let grayGradient = LinearGradient(colors: [grayOne, grayOne], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let customGrayGradient = LinearGradient(colors: [customGray, customGray], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let grayThreeGradient = LinearGradient(colors: [grayThree, grayThree], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let purpleYellowGradient = LinearGradient(colors: [gradientOne, gradientTwo], startPoint: .top, endPoint: .bottom)
    static let pinkGradient = LinearGradient(colors: [pink1, pink1], startPoint: .top, endPoint: .bottom)
}
