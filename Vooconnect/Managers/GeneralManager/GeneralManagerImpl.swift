//
//  GeneralManagerImpl.swift
//  Vooconnect
//
//  Created by Online Developer on 27/03/2023.
//

import Foundation
import Swinject
import UIKit

class GeneralManagerFactory {

    static func register(with container: Container) {
        let threadSafeResolver = container.synchronize()
        container.register(GeneralManager.self) { _ in
            logger.debug("Creating user authentication manager...", category: .userContext)
            return GeneralManagerImpl(with: threadSafeResolver)
        }
        .initCompleted { resolver, initialUserAuthenticationManager in
            // Set up dependencies like Push Notifications
        }
        .inObjectScope(.container)
    }
    
}

private final class GeneralManagerImpl: GeneralManager {
        
    // MARK: - Lifecycle
    
    init(with resolver: Resolver) {
        logger.debug("Constructing GeneralManager...", category: .lifecycle)
    }
    
    deinit {
        logger.debug("~GeneralManager.", category: .lifecycle)
    }
    
    // MARK: - Functions
    
    /// Follow other user
    /// - Parameter uuid: other user id
    func follow(uuid: String) {
        let params : [String: Any] = [
            "user_uuid": uuid
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .follow, withDataType: NilModel.self, parameters: params) { result in
            switch result {
            case .success(_):
                logger.info("Successfully follow the user.", category: .general)
            case .failure(let error):
                logger.error("Error Follow User: \(error.localizedDescription)", category: .general)
            }
        }
    }
    
    /// Unfollow other user
    /// - Parameter uuid: other user id
    func unFollow(uuid: String) {
        let params : [String: Any] = [
            "user_uuid": uuid
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .unfollow, withDataType: NilModel.self, parameters: params) { result in
            switch result {
            case .success(_):
                logger.info("Successfully unfollow the user.", category: .general)
            case .failure(let error):
                logger.error("Error UnFollow User: \(error.localizedDescription)", category: .general)
            }
        }
    }
    
    /// Remove a follower
    /// - Parameters:
    ///   - uuid: other user id
    ///   - onComplete: when api call complete will show the toast message
    func removeFollower(uuid: String, onComplete: @escaping (()->())) {
        let params : [String: Any] = [
            "user_uuid": uuid
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .removeFollower, withDataType: NilModel.self, parameters: params) { result in
            onComplete()
            switch result {
            case .success(_):
                logger.info("Successfully remove the follower.", category: .general)
            case .failure(let error):
                logger.error("Error Remove Follower: \(error.localizedDescription)", category: .general)
            }
        }
    }
    
    /// Invite on socials media
    /// - Parameters:
    ///   - url: user profile url
    ///   - type: type of social media
    func inviteOnSocialMedia(url: String, type: InviteOnSocialMediaType, onComplete: ((String?)->())? = nil) {
        switch type {
        case .whatsapp:
            let escapedString = url.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
            let url  = URL(string: "whatsapp://send?text=\(escapedString!)")
            
            if UIApplication.shared.canOpenURL(url! as URL){
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            }
        case .facebook:
            print("Share On Facebook")
        case .instagram:
            let instagram = URL(string: "instagram://sharesheet?text=\(url)")!
            if UIApplication.shared.canOpenURL(instagram) {
                UIApplication.shared.open(instagram, options: [:], completionHandler: nil)
            } else {
                onComplete?("Instagram not installed.")
            }
        case .twitter:
            print("Share On Twitter")
        case .sms(let phoneNo, let message):
            let sms = "sms:\(phoneNo)&body=\(message)"
            let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            UIApplication.shared.open(URL(string: strURL)!, options: [:], completionHandler: nil)
        case .email(let profileUrl):
            let subject = "Share Profile"
            let email = ""
            let encodedParams = "subject=\(subject)&body=\(profileUrl)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = "mailto:\(email)?\(encodedParams)"
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
    }
    
    /// Report User
    /// - Parameters:
    ///   - uuid: user id
    ///   - onComplete: when api call complete will show the toast message
    func reportUser(uuid: String, onComplete: @escaping (()->())) {
        let params : [String: Any] = [
            "user_uuid": uuid
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .reportUser, withDataType: NilModel.self, parameters: params) { result in
            onComplete()
            switch result {
            case .success(_):
                logger.info("Successfully report abused user.", category: .general)
            case .failure(let error):
                logger.error("Error Reporting Abused User: \(error.localizedDescription)", category: .general)
            }
        }
    }
    
    /// Block User
    /// - Parameters:
    ///   - uuid: user id
    ///   - onComplete: when api call complete will show the toast message
    func blockUser(uuid: String, onComplete: @escaping (()->())) {
        let params : [String: Any] = [
            "user_uuid": uuid
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .blockUser, withDataType: NilModel.self, parameters: params) { result in
            onComplete()
            switch result {
            case .success(_):
                logger.info("Successfully blocked user.", category: .general)
            case .failure(let error):
                logger.error("Error Blocking User: \(error.localizedDescription)", category: .general)
            }
        }
    }
    
    /// Update User Profile
    func updateProfile(model: UpdateProfileModel, onComplete: @escaping ((Bool, String?) -> ())) {
        var params: [String: Any] = [:]
        if model.username != nil{
            params["username"] = model.username!
        }
        if model.firstName != nil{
            params["first_name"] = model.firstName
        }
        if model.lastName != nil{
            params["last_name"] = model.lastName
        }
        if model.bio != nil{
            params["bio"] = model.bio
        }
        if model.instagram != nil{
            params["instagram"] = model.instagram
        }
        if model.facebook != nil{
            params["facebook"] = model.facebook
        }
        if model.twitter != nil{
            params["twitter"] = model.twitter
        }
        if model.profileImage != nil{
            params["profile_image"] = model.profileImage
        }
        if model.coverImage != nil{
            params["cover_image"] = model.coverImage
        }
        
        NetworkManager.makeEndpointCall(fromEndpoint: .updateProfile, withDataType: NilModel.self, parameters: params) { result in
            switch result {
            case .success(_):
                logger.info("Successfully updated the user.", category: .general)
                onComplete(true, nil)
            case .failure(let error):
                logger.error("Error While Updating User: \(error.localizedDescription)", category: .general)
                onComplete(false, error.localizedDescription)
            }
        }
    }
}
