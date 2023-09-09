//
//  UserProfileView.swift
//  Vooconnect
//
//  Created by Mac on 07/09/2023.
//

import Foundation

struct UserProfileModel: Codable{
    let status: Bool
    let data: UserProfile
}

struct UserProfile: Codable{
    let phone: String?
    let email, uuid, gender, birthdate: String?
    let username, firstName, lastName, profileImage: String?
    let middleName: String?
    let totalFollowers, isFollowed, postCount, totalFollowings, totalLikes: Int
    
    enum CodingKeys: String, CodingKey{
        case phone, email, uuid, gender, birthdate, username
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
        case middleName = "middle_name"
        case totalFollowers = "total_followers"
        case isFollowed = "is_followed"
        case postCount = "post_count"
        case totalFollowings = "total_followings"
        case totalLikes = "total_likes"
    }
}
