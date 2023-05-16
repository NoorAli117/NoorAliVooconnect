//
//  DeezerArtistModel.swift
//  Vooconnect
//
//  Created by JV on 25/02/23.
//

import Foundation
struct DeezerArtistModel: Identifiable, Codable{
    var id = UUID().uuidString
    let name : String
    let type : String
    enum CodingKeys: String, CodingKey
    {
        case name
        case type
    }

}
