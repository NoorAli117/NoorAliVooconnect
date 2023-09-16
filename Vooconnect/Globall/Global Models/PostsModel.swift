//
//  PostsModel.swift
//  Vooconnect
//
//  Created by Online Developer on 25/03/2023.
//

import Foundation

struct PostsModel: Codable {
    let status: Bool
    let posts: [UserPost]
}

struct UserPost: Codable, Hashable {
    let postID: Int?
    let title, description, location, contentURL: String?
    let thumbnailURL, contentType, musicTrack: String?
    let musicURL: String?
    let createdAt, allowComment, allowDuet, allowStitch: String?
    let creatorUUID: String?
    let forPlanID: Int?
    let creatorFirstName, creatorLastName, creatorUsername, creatorProfileImage: String?
    let likeCount, shareCount, bookmarkCount, commentCount: Int?
    let viewCount: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title, description, location
        case contentURL = "content_url"
        case thumbnailURL = "thumbnail_url"
        case contentType = "content_type"
        case musicTrack = "music_track"
        case musicURL = "music_url"
        case createdAt = "created_at"
        case allowComment = "allow_comment"
        case allowDuet = "allow_duet"
        case allowStitch = "allow_stitch"
        case creatorUUID = "creator_uuid"
        case forPlanID = "for_plan_id"
        case creatorFirstName = "creator_first_name"
        case creatorLastName = "creator_last_name"
        case creatorUsername = "creator_username"
        case creatorProfileImage = "creator_profile_image"
        case likeCount = "like_count"
        case shareCount = "share_count"
        case bookmarkCount = "bookmark_count"
        case commentCount = "comment_count"
        case viewCount = "view_count"
    }
}
