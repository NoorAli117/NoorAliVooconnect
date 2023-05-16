//
//  MediaFile.swift
//  ReelsTest
//
//  Created by Vooconnect on 05/11/22.
//

import Foundation

// Sample Model And Reels Videos...
struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
}

var MediaFileJSON = [

    MediaFile(url: "Reel1", title: "Apple"),
    MediaFile(url: "Reel2", title: "Apple..."),
    MediaFile(url: "Reel3", title: "Apple..........."),
    MediaFile(url: "Reel4", title: "Apple......."),
    MediaFile(url: "Reel5", title: "Apple"),
    MediaFile(url: "Reel6", title: "Apple"),
    MediaFile(url: "Reel7", title: "Apple"),
    MediaFile(url: "Reel8", title: "Apple"),
    MediaFile(url: "Reel9", title: "Apple"),
    MediaFile(url: "Reel10", title: "Apple"),
    MediaFile(url: "Reel11", title: "Apple.......rekljheilwhfeiufhgieghful........kjefirjehgir"),
    
]
