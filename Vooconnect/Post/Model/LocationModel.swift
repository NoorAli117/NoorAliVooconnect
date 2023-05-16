//
//  LocationModel.swift
//  Vooconnect
//
//  Created by JV on 1/03/23.
//

import Foundation
struct LocationModel : Identifiable, Codable{
    var id = UUID().uuidString
    let latitude : Double
    let longitude : Double
    let accuracy : Double
    
    enum CodingKeys: String, CodingKey
    {
        case latitude
        case longitude
        case accuracy
    }
}
