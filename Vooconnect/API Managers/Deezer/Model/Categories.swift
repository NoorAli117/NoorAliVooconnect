//
//  Categories.swift
//
//  Created by Mbp on 18/05/2023
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Categories: Codable, Hashable {
    static func == (lhs: Categories, rhs: Categories) -> Bool {
           return lhs.isBundle == rhs.isBundle &&
               lhs.updatedAt == rhs.updatedAt &&
               lhs.slotNo == rhs.slotNo &&
               lhs.title == rhs.title &&
               lhs.division == rhs.division &&
               lhs.level == rhs.level &&
               lhs.descriptionValue == rhs.descriptionValue &&
               lhs.uuid == rhs.uuid &&
               lhs.status == rhs.status &&
               lhs.items == rhs.items
       }
       
       func hash(into hasher: inout Hasher) {
           hasher.combine(isBundle)
           hasher.combine(updatedAt)
           hasher.combine(slotNo)
           hasher.combine(title)
           hasher.combine(division)
           hasher.combine(level)
           hasher.combine(descriptionValue)
           hasher.combine(uuid)
           hasher.combine(status)
           hasher.combine(items)
       }
    

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
