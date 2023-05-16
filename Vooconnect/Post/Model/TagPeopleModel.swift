//
//  TagPeopleModel.swift
//  Vooconnect
//
//  Created by JV on 1/03/23.
//

import Foundation
struct TagPeopleModel : Identifiable, Codable{
    var id = UUID().uuidString
    let uid : String
    let name : String
    let value : String
    
    enum CodingKeys: String, CodingKey
    {
        case uid
        case name
        case value
    }
}
