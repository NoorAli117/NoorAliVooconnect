//
//  Categories.swift
//
//  Created by Mbp on 18/05/2023
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Categories: Codable {

  enum CodingKeys: String, CodingKey {
    case isBundle = "is_bundle"
    case updatedAt = "updated_at"
    case slotNo = "slot_no"
    case title
    case division
    case level
    case descriptionValue = "description"
    case uuid
    case status
    case items
  }

  var isBundle: Bool?
  var updatedAt: Int?
  var slotNo: Int?
  var title: String?
  var division: Int?
  var level: Int?
  var descriptionValue: String?
  var uuid: String?
  var status: String?
  var items: [ItemData]?

}
