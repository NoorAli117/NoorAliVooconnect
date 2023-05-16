//
//  GeneralManager.swift
//  Vooconnect
//
//  Created by Online Developer on 27/03/2023.
//

import Foundation

enum InviteOnSocialMediaType{
    case whatsapp
    case facebook
    case instagram
    case twitter
    case sms(phoneNo: String, message: String)
    case email(url: String)
}

protocol GeneralManager: AnyObject {
    func follow(uuid: String)
    func unFollow(uuid: String)
    func removeFollower(uuid: String, onComplete: @escaping (()->()))
    func inviteOnSocialMedia(url: String, type: InviteOnSocialMediaType, onComplete: ((String?)->())?)
    func blockUser(uuid: String, onComplete: @escaping (()->()))
    func reportUser(uuid: String, onComplete: @escaping (()->()))
    func updateProfile(model: UpdateProfileModel, onComplete: @escaping ((Bool, String?) -> ()))
}

struct UpdateProfileModel{
    var username: String? = nil
    var firstName: String? = nil
    var lastName: String? = nil
    var bio: String? = nil
    var instagram: String? = nil
    var facebook: String? = nil
    var twitter: String? = nil
    var profileImage: String? = nil
    var coverImage: String? = nil
    var facebookId: String? = nil
}
