//
//  Items.swift
//
//  Created by Mbp on 18/05/2023
//  Copyright (c) . All rights reserved.
//

import Foundation

struct ItemData: Codable {

  enum CodingKeys: String, CodingKey {
    case thumbnail
    case descriptionValue = "description"
    case numEffects = "num_effects"
    case numFilters = "num_filters"
    case bigThumbnail = "big_thumbnail"
    case title
    case numBgms = "num_bgms"
    case updatedAt = "updated_at"
    case numStickers = "num_stickers"
    case numMasks = "num_masks"
    case type
    case uuid
    case zipFile = "zip_file"
    case hasTrigger = "has_trigger"
    case status
  }

  var thumbnail: String?
  var descriptionValue: String?
  var numEffects: Int?
  var numFilters: Int?
  var bigThumbnail: String?
  var title: String?
  var numBgms: Int?
  var updatedAt: Int?
  var numStickers: Int?
  var numMasks: Int?
  var type: String?
  var uuid: String?
  var zipFile: String?
  var hasTrigger: Bool?
  var status: String?



}
