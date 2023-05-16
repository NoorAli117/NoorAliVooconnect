//
//  VideoOverlayModel.swift
//  Vooconnect
//
//  Created by JV on 25/02/23.
//

import Foundation
import SwiftUI

///Model of overlay content
struct ContentOverlayModel: Identifiable, Codable{
//    static func == (lhs: VideoOverlayModel, rhs: VideoOverlayModel) -> Bool {
//        lhs.id == rhs.id
//    }
    var id = UUID().uuidString
    let type : TypeOfOverlay
    var size : CGSize
    let scale : Double
    let value : String
    let color : Color
    let fontSize : Double
    let enableBackground : Bool
    let font : TypeFont
    
    enum CodingKeys: String, CodingKey
    {
        case type
        case size
        case scale
        case value
        case color
        case fontSize
        case enableBackground
        case font
    }
    
}
