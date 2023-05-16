//
//  Reel.swift
//  ReelsTest
//
//  Created by Vooconnect on 05/11/22.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
