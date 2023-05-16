//
//  PostCategoriesModel.swift
//  Vooconnect
//
//  Created by JV on 1/03/23.
//

import Foundation
struct PostCategoriesModel : Identifiable, Codable{
    var id = UUID().uuidString
    let value : String
    
    enum CodingKeys: String, CodingKey
    {
        case value
    }
}
