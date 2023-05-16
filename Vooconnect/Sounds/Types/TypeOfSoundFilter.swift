//
//  TypeOfSoundFilter.swift
//  Vooconnect
//
//  Created by JV on 1/03/23.
//

import Foundation

///Type of filters to use on SoudsView
enum TypeOfSoundFilter : String, Codable{
    case all
    case title
    case artist
    
    var description : String {
        switch self {
            case .all: return "All"
            case .title: return "Title"
            case .artist: return "Artist"
        }
    }
}
