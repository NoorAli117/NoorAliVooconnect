//
//  BaseClass.swift
//
//  Created by Mbp on 18/05/2023
//  Copyright (c) . All rights reserved.
//

import Foundation

struct FilterData: Codable {

  enum CodingKeys: String, CodingKey {
    case apiKey = "api_key"
    case name
    case status
    case categories
    case descriptionValue = "description"
    case lastUpdatedAt = "last_updated_at"
  }

  var apiKey: String?
  var name: String?
  var status: String?
  var categories: [Categories]?
  var descriptionValue: String?
  var lastUpdatedAt: String?


}
