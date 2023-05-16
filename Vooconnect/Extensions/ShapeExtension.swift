//
//  ShapeExtension.swift
//  Vooconnect
//
//  Created by JV on 22/02/23.
//

import Foundation
import SwiftUI

// Need this to let the extension know that the Shape
// can be instantiated without additional params.
protocol ParameterlessInitable {
  init()
}

// Make existing Shapes conform to the new protocol.
extension Circle: ParameterlessInitable { }
extension Rectangle: ParameterlessInitable { }
extension Capsule: ParameterlessInitable {
  init() {
    self.init(style: .circular)
  }
}

extension Shape where Self: ParameterlessInitable {
  func stroke<StrokeStyle, FillStyle>(
      _ strokeStyle: StrokeStyle,
      lineWidth: CGFloat = 1,
      fill fillStyle: FillStyle
  ) -> some View where StrokeStyle: ShapeStyle, FillStyle: ShapeStyle {
    Self()
      .stroke(strokeStyle, lineWidth: lineWidth)
      .background(Self().fill(fillStyle))
  }
}
