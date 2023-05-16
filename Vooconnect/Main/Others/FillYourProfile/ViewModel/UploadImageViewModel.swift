//
//  UploadImageViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/11/22.
//

import Foundation
import SwiftUI

struct UploadImageDataModel {
    
    var image = UIImage()
    var isPresentingErrorAlert: Bool = false
    var isPresentingSuccess: Bool = false
    var errorMessage: String = String()
    
}

class UploadImageViewModel : ObservableObject {
    
    @Published var uploadImageDataModel: UploadImageDataModel = UploadImageDataModel()
    private let uploadProfileImageResource: UploadProfileImageResource = UploadProfileImageResource()
    
    func authenticateProfileImage() {
        
    }
    
}
