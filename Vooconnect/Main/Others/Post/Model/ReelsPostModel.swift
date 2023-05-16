//
//  ReelsPostModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 15/12/22.
//

import Foundation

// MARK: - Welcome
struct ReelsPostRequest: Codable {
    let userUUID, title, welcomeDescription, location: String
    let visibility, contentType, musicTrack: String
    let musicURL: String
    let allowComment, allowDuet, allowStitch: String
    let forPlanID: Int
    let content: [ContentDetail]

    enum CodingKeys: String, CodingKey {
        case userUUID = "user_uuid"
        case title
        case welcomeDescription = "description"
        case location, visibility
        case contentType = "content_type"
        case musicTrack = "music_track"
        case musicURL = "music_url"
        case allowComment = "allow_comment"
        case allowDuet = "allow_duet"
        case allowStitch = "allow_stitch"
        case forPlanID = "for_plan_id"
        case content
    }
}

// MARK: - Content
struct ContentDetail: Codable {
    let name, size: String
}
