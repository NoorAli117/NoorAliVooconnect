//
//  DeezerArtistModel.swift
//  Vooconnect
//
//  Created by JV on 25/02/23.
//

import Foundation
import Foundation
struct DeezerAlbumModel: Identifiable, Codable{
    var id = UUID().uuidString
    let cover : String
    let coverSmall : String
    enum CodingKeys: String, CodingKey
    {
        case cover
        case coverSmall = "cover_small"
    }

}
