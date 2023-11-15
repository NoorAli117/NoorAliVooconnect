//
//  DeezerMusicModel.swift
//  Vooconnect
//
//  Created by JV on 25/02/23.
//

import Foundation
struct DeezerSongModel: Identifiable, Codable, Equatable{
    static func == (lhs: DeezerSongModel, rhs: DeezerSongModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID().uuidString
    let title : String
    let preview : String
    var duration : Int
    let artist : DeezerArtistModel
    let album : DeezerAlbumModel
    enum CodingKeys: String, CodingKey
    {
        case title
        case preview
        case album
        case artist
        case duration
    }
    
    func getDuration() -> String
    {
        let (_,m,s) = secondsToHoursMinutesSeconds(duration)
        let sstr = s < 10 ? "0\(s)" : s.description
        let mstr = m < 10 ? "0\(m)" : m.description
        return "\(mstr):\(sstr)"
    }
    
    private func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

}
