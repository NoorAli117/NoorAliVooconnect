//
//  EditProfileViewModel.swift
//  Vooconnect
//
//  Created by Online Developer on 27/03/2023.
//

import Foundation
import Swinject
import UIKit

class EditProfileViewModel: ObservableObject{
    private var generalManager = Container.default.resolver.resolve(GeneralManager.self)!
    private var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    private var appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!
    
    // Image Picker Values
    @Published var presentActionSheet = false
    @Published var selectedProfilePhoto: UIImage = UIImage(named: "profileicon")!
    @Published var sourceType = UIImagePickerController.SourceType.photoLibrary
    @Published var isProfilePhotoSelected = false
    @Published var isUpdating = false
    @Published var errorString = ""
    @Published var isPresentAlert = false
    
    /// Update User Profile
    func updateUserProfile(type: EditProfileRowType, text: String){
        let model: UpdateProfileModel
        
        switch type {
        case .firstName:
            model = UpdateProfileModel(firstName: text)
        case .lastName:
            model = UpdateProfileModel(lastName: text)
        case .username:
            model = UpdateProfileModel(username: text)
        case .bio:
            model = UpdateProfileModel(bio: text)
        case .instagram:
            model = UpdateProfileModel(instagram: text)
        case .facebook:
            model = UpdateProfileModel(facebook: text)
        case .twitter:
            model = UpdateProfileModel(twitter: text)
        case .facebookId:
            model = UpdateProfileModel(facebookId: text)
        }
        generalManager.updateProfile(model: model) { [weak self] success, error in
            if error == nil{
                logger.info("Successfully update the profile.", category: .profile)
                self?.userAuthanticationManager.refreshUserDetails()
            }else{
                logger.info("Error Updating Profile: \(error ?? "")", category: .profile)
                self?.isPresentAlert = true
                self?.errorString = error ?? "Unknown error"
            }
        }
    }
    
    
    /// Upload Profile Image or Cover Image
    func uploadFile(onComplete: ((String)->())?){
        let params: [String: Any] = ["upload_path": "profile"]
        let image = selectedProfilePhoto
        let imageData = image.jpegData(compressionQuality: 1)!
        let media = Media(withMediaData: imageData, forKey: "asset", withMimeType: .photo)
        NetworkManager.makeEndpointCall(fromEndpoint: .uploadFile, withDataType: UploadFileModel.self, parameters: params, mediaData: media) { [weak self] result in
            switch result {
            case .success(let model):
                logger.error("Successfully uploaded the image", category: .profile)
                if let url = model.data?.first?.name {
                    onComplete?(url)
                }
            case .failure(let error):
                logger.error("Error Uploading the image: \(error.localizedDescription)", category: .profile)
                self?.isUpdating = false
                self?.errorString = "Error Uploading the image: \(error.localizedDescription)"
                self?.isPresentAlert = true
            }
        }
    }
    
    /// Upload the profile or cover iamge to the BE and then update the user profile
    func updateUserProfile(){
        isUpdating = true
        uploadFile { [weak self] url in
            
            let model = UpdateProfileModel(profileImage: url)
            
            self?.generalManager.updateProfile(model: model) { (isSuccess, error) in
                self?.isUpdating = false
                self?.appEventsManager.updateProfileImage.send(true)
                if error == nil{
                    logger.info("Profile updated successfully.", category: .profile)
                    self?.userAuthanticationManager.refreshUserDetails()
                }else{
                    self?.errorString = error ?? "Unknown error."
                    self?.isPresentAlert = true
                }
            }
        }
    }
    
    /// Login With Facebook
    func loginWithFacebook(onComplete: ((String)->())? = nil){
        FacebookLoginManager.shared.login{ [weak self] username, userId, errorString in
            if errorString == nil{
                self?.updateUserProfile(type: EditProfileRowType.facebookId, text: userId)
                onComplete?(username)
            }else{
                self?.errorString = errorString ?? ""
                self?.isPresentAlert = true
            }
        }
    }
    
    /// Login With Twitter
    func loginWithTwitter(onComplete: ((String)->())? = nil){
        TwitterLoginManager.shared.login{ [weak self] username, errorString in
            if errorString == nil{
                onComplete?(username ?? "")
            }else{
                self?.errorString = errorString ?? ""
                self?.isPresentAlert = true
            }
        }
    }
}
