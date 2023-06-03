//
//  PostCategoriesModel.swift
//  Vooconnect
//
//  Created by JV on 1/03/23.
//

import Foundation

struct GetCategoryResponse: Codable {
    let status: Bool
    let data: [PostCategoriesModel]
}

// MARK: - Datum
struct PostCategoriesModel: Codable {
    let id: Int
    let categoryName: String

    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
    }
}

