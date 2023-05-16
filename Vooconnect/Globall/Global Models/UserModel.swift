//
//  UserModel.swift
//  Vooconnect
//
//  Created by Online Developer on 12/03/2023.
//

import Foundation

struct UserModel: Codable {
    let status: Bool
    let user: UserDetail
}

struct UserDetail: Codable, Hashable {
    let uuid, username, firstName, lastName, bio: String?
    let middleName: String?
    let gender, birthdate: String?
    let phone, phoneVerifiedAt: String?
    let email, emailVerifiedAt, password: String?
    let profileImage: String?
    let coverImage: String?
    let address: String?
    let otp: Int?
    let rememberMe, verifyType, status: String?
    let lat: Double?
    let lon: Double?
    let followerCount: Int?
    let instagram, facebook, twitter: String?
    
    // Used for Follow or Unfollow state
    var isSwitched = false

    enum CodingKeys: String, CodingKey {
        case uuid, username
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case gender, birthdate, phone, bio
        case phoneVerifiedAt = "phone_verified_at"
        case email
        case emailVerifiedAt = "email_verified_at"
        case password
        case profileImage = "profile_image"
        case coverImage = "cover_image"
        case address, otp
        case rememberMe = "remember_me"
        case verifyType = "verify_type"
        case status, lat, lon
        case followerCount = "follower_count"
        case instagram, facebook, twitter
    }
}
