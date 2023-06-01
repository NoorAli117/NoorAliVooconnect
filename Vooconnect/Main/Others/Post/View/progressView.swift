//
//  progressView.swift
//  Vooconnect
//
//  Created by Farooq Haroon on 6/1/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: .large)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}
