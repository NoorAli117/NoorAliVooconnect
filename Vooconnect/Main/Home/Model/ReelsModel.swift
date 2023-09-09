//
//  ReelsModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 03/12/22.
//

import Foundation
import AVKit

// MARK: - Welcome
struct ReelsModel: Codable {
    let status: Bool?
    let data: ReelsData?
}

// MARK: - DataClass
struct ReelsData: Codable {
    let nextPage: Int?
    var player: AVPlayer?
    let posts: [Post]?

    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page"
        case posts
    }
}

// MARK: - Post
struct Post: Codable, Hashable {
    let postID: Int?
    let title, postDescription: String?
    let location: String?
    let contentURL: String?
    let contentType: String?
    let musicTrack: String?
    let musicURL: String?
    let musicUUID: String?;
    let allowComment, allowDuet, allowStitch: String?
    let creatorUUID: String?
    let creatorFirstName, creatorLastName, creatorUsername, creatorProfileImage: String?
    let isBookmarked: Int
    let isLiked: Int
    let reactionType: Int?
    var likeCount, shareCount, bookmarkCount, commentCount: Int?
    var player: AVPlayer?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title
        case postDescription = "description"
        case location
        case contentURL = "content_url"
        case contentType = "content_type"
        case musicUUID = "music_uuid"
        case musicTrack = "music_track"
        case musicURL = "music_url"
        case allowComment = "allow_comment"
        case allowDuet = "allow_duet"
        case allowStitch = "allow_stitch"
        case creatorUUID = "creator_uuid"
        case creatorFirstName = "creator_first_name"
        case creatorLastName = "creator_last_name"
        case creatorUsername = "creator_username"
        case creatorProfileImage = "creator_profile_image"
        case isBookmarked = "is_bookmarked"
        case isLiked = "is_liked"
        case reactionType = "reaction_type"
        case likeCount = "like_count"
        case shareCount = "share_count"
        case bookmarkCount = "bookmark_count"
        case commentCount = "comment_count"
    }
    
    var likeCountt: Int {
        return Int(likeCount ?? 0)
    }
    mutating func incrementLikeCount() {
        likeCount = likeCount! + 1
        }
    mutating func decrementLikeCount() {
        likeCount = likeCount! - 1
        }
    
}


struct LikeRequest: Encodable {
    let user_uuid: String
    let post_id, reaction_type: Int
}

struct BlockPostRequest: Encodable {
    let uuid: String
    let post_id: Int
}
struct BlockUserRequest: Encodable {
    let uuid: String
    let user_uuid: String
}

struct FollowingUser: Encodable {
    let uuid: String
}

struct ReportPostRequest: Encodable {
    let uuid: String
    let post_id: Int
    let description: String
}

struct BookMarkRequest: Encodable {
    let user_uuid: String
    let post_id: Int
}

struct bookMarkSuccesResponse: Codable {
    let status: Bool?
    let message: String?
}

struct CommentRequest: Encodable {
    let user_uuid: String
    let post_id: Int
    let comment: String
}

struct FollowRequest: Encodable {
    let user_uuid: String
    let uuid: String
}

struct ReplyToCommentRequest: Encodable {
    let user_uuid: String
    let post_id: Int
    let comment: String
    let reply_to_comment_id: Int
}

struct ReplyToReplyRequest: Encodable {
    let user_uuid: String
    let post_id: Int
    let comment: String
    let reply_to_comment_id: Int
    let reply_to_reply: String
}

struct CommentResponse: Decodable {
    let id: Int
    let user_uuid: String
    let post_id: Int
    let reply_to_comment_id: Int
    let comment: String
    let reply_to_reply: String
}

struct InterestCateg: Decodable {
    let id: Int
    let category_name: String
}

struct UserInterestCateg: Decodable {
    let id: Int
    let user_uuid: String
    let category_id: Int
}


// MARK: - Welcome
struct Following: Codable {
    let status: Bool
    let data: [FollowingUsers]
}

// MARK: - Datum
struct FollowingUsers: Codable {
    let id: Int?
    let uuid, username, firstName, lastName: String?
    let middleName: String?
    let gender: String
    let birthdate: String?
    let phone: String?
    let phoneVerifiedAt: String?
    let email, emailVerifiedAt, password: String
    let profileImage, coverImage, bio: String?
    let followerCount, lat, lon: Int?
    let instagram, facebook, twitter: String?
    let address: String
    let otp: String?
    let rememberMe, verifyType, status: String?
    let isLive: Int?
    let deviceType: String?
    let deviceToken, city, state, country: String?
    let deletedAt: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case uuid = "uuid"
        case username = "username"
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case gender = "gender"
        case birthdate = "birthdate"
        case phone = "phone"
        case phoneVerifiedAt = "phone_verified_at"
        case email = "email"
        case emailVerifiedAt = "email_verified_at"
        case password = "password"
        case profileImage = "profile_image"
        case coverImage = "cover_image"
        case bio = "bio"
        case followerCount = "follower_count"
        case lat, lon, instagram, facebook, twitter, address, otp
        case rememberMe = "remember_me"
        case verifyType = "verify_type"
        case status = "status"
        case isLive = "is_live"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case city = "city"
        case state = "state"
        case country = "country"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


//"user_uuid": "{{user_uuid}}",
//    "post_id": 1,
//    "comment": "TEst comment"

