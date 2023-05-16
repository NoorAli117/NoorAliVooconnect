//
//  CustomGradient.swift
//  Vooconnect
//
//  Created by Online Developer on 08/03/2023.
//

import SwiftUI

struct CustomGradient: ViewModifier {
    var start: UnitPoint
    var end: UnitPoint
    var startColor: Color
    var endColor: Color
    
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(colors: [startColor, endColor], startPoint: start, endPoint: end))
    }
}

extension View {
    func customGradient(startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing, startColor: Color = .buttionGradientTwo, endColor: Color = .buttionGradientOne) -> some View {
        modifier(CustomGradient(start: startPoint, end: endPoint, startColor: startColor, endColor: endColor))
    }
}
