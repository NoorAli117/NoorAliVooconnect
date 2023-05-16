//
//  StatsModel.swift
//  Vooconnect
//
//  Created by Online Developer on 25/03/2023.
//

import Foundation

struct StatsModel: Codable {
    let status: Bool?
    let stats: Stats?
}

struct Stats: Codable {
    let postsCount: Int?
    let likesCount: Int?
    let followersCount: Int?
    let followingsCount: Int?
}
