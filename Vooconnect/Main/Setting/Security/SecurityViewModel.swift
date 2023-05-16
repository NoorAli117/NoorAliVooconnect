//
//  SecurityViewModel.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 24/04/2023.
//

import SwiftUI

class SecurityViewModel: ObservableObject{
    @Published var rememberMe = true
    @Published var biometricId = false
    @Published var faceId = true
}
