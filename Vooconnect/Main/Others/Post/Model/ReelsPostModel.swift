//
//  ReelsPostModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 15/12/22.
//

import Foundation

// MARK: - Welcome
struct ReelsPostRequest: Codable {
    enum CodingKeys: String, CodingKey {
      case content
      case title
      case category
      case tags
      case musicTrack = "music_track"
      case allowDuet = "allow_duet"
      case visibility
      case allowStitch = "allow_stitch"
      case location
      case allowComment = "allow_comment"
      case userUuid = "user_uuid"
      case contentType = "content_type"
      case descriptionValue = "description"
      case musicUrl = "music_url"
    }

    var content: [ContentDetail]?
    var title: String?
    var category: Int?
    var tags: [String]?
    var musicTrack: String?
    var allowDuet: Bool?
    var visibility: String?
    var allowStitch: Bool?
    var location: String?
    var allowComment: Bool?
    var userUuid: String?
    var contentType: String?
    var descriptionValue: String?
    var musicUrl: String?
}

// MARK: - Content
struct ContentDetail: Codable {
    let name, size: String?
    
}
