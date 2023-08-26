//
//  DeepARCameraRepresentable.swift
//  Vooconnect
//
//  Created by Mac on 22/08/2023.
//

import Foundation
import SwiftUI
struct DeepARView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Mains", bundle: nil)
            let controller = storyboard.instantiateViewController(identifier: "ViewController")
                return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    
}
