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
    let title, description, location, contentURL: String?
    let thumbnailURL, contentType, musicUUID, musicTrack: String?
    let musicURL: String?
    let allowComment, allowDuet, allowStitch, creatorUUID: String?
    let forPlanID: Int?
    let creatorFirstName, creatorLastName, creatorUsername, creatorProfileImage: String?
    let isFollowed, isLiked: Int?
    let reactionType: Int?
    let likeCount, shareCount, isBookmarked, bookmarkCount: Int?
    let commentCount, viewCount: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title, description, location
        case contentURL = "content_url"
        case thumbnailURL = "thumbnail_url"
        case contentType = "content_type"
        case musicUUID = "music_uuid"
        case musicTrack = "music_track"
        case musicURL = "music_url"
        case allowComment = "allow_comment"
        case allowDuet = "allow_duet"
        case allowStitch = "allow_stitch"
        case creatorUUID = "creator_uuid"
        case forPlanID = "for_plan_id"
        case creatorFirstName = "creator_first_name"
        case creatorLastName = "creator_last_name"
        case creatorUsername = "creator_username"
        case creatorProfileImage = "creator_profile_image"
        case isFollowed = "is_followed"
        case isLiked = "is_liked"
        case reactionType = "reaction_type"
        case likeCount = "like_count"
        case shareCount = "share_count"
        case isBookmarked = "is_bookmarked"
        case bookmarkCount = "bookmark_count"
        case commentCount = "comment_count"
        case viewCount = "view_count"
    }
    
    var likeCountt: Int {
        return Int(likeCount!)
    }
    
}


struct LikeRequest: Encodable {
    let user_uuid: String
    let post_id, reaction_type: Int
}
struct CommentLikeRequest: Encodable {
    let user_uuid: String
    let comment_id, reaction_type: Int
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
    let uuid: String
    let user_uuid: String
}

struct ReplyToComment: Encodable {
    let post_id: Int
    let parent_comment_id: Int
}

struct NotInterested: Codable {
    let post_id: Int
    let user_uuid: String
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

struct CommentsModel: Codable {
    let status: Bool
    let data: [CommentsData]
}

// MARK: - Datum
struct CommentsData: Codable {
    let id: Int?
    let userUUID: String?
    let postID, replyToCommentID: Int?
    let comment, createdAt, updatedAt: String?
    let deletedAt: String?
    let userFirstName, userLastName, userUsername: String?
    let userProfileImage: String?
    let isLiked: Int?
    let reactionType: Int?
    let likeCount, replyCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userUUID = "user_uuid"
        case postID = "post_id"
        case replyToCommentID = "reply_to_comment_id"
        case comment
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case userFirstName = "user_first_name"
        case userLastName = "user_last_name"
        case userUsername = "user_username"
        case userProfileImage = "user_profile_image"
        case isLiked = "is_liked"
        case reactionType = "reaction_type"
        case likeCount = "like_count"
        case replyCount = "reply_count"
    }
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


struct Following: Codable {
    let status: Bool
    let users: [FollowingUsers]
}

struct FollowingUsers: Codable {
    let id: Int?
    let uuid, username, firstName, lastName: String?
    let middleName: String?
    let gender, birthdate: String?
    let phone, phoneVerifiedAt: String?
    let email: String?
    let emailVerifiedAt: String?
    let password, profileImage: String?
    let coverImage, bio: String?
    let followerCount: Int?
    let lat: Double?
    let instagram, facebook: String?
    let faceboolID, twitter: String?
    let lon: Double?
    let address: String?
    let otp: Int?
    let rememberMe: String?
    let isLive: Int?
    let deviceType: String?
    let deviceToken: String?
    let verifyType, status: String?
    let deletedAt: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, uuid, username
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case gender, birthdate, phone
        case phoneVerifiedAt = "phone_verified_at"
        case email
        case emailVerifiedAt = "email_verified_at"
        case password
        case profileImage = "profile_image"
        case coverImage = "cover_image"
        case bio
        case followerCount = "follower_count"
        case lat, instagram, facebook
        case faceboolID = "facebool_id"
        case twitter, lon, address, otp
        case rememberMe = "remember_me"
        case isLive = "is_live"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case verifyType = "verify_type"
        case status
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
