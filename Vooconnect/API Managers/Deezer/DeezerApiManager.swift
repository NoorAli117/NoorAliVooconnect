//
//  DeezerApiManager.swift
//  Vooconnect
//
//  Created by JV on 25/02/23.
//

import Foundation
///Deezer api manager tp connect to deezer api
class DeezerApiManager{

    ///Load music from deezer using search function, use `query` to add parameters or just send a search query
    func loadMusic(query : String, callback : @escaping ([DeezerSongModel]) -> ())
    {
        let _query = query.replacingOccurrences(of: " ", with: "%20")
        let jsonURL = URL(string: "https://api.deezer.com/search?q=\(_query)")
        jsonURL?.asyncDownload { data, response, error in
            do{
                guard let data = data else { return }
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
                print("song JSON data: \(json)")
                let data2 = try JSONSerialization.data(withJSONObject: json["data"] as Any)
                let deezerMusicList = try JSONDecoder().decode([DeezerSongModel].self, from: data2)
                print("song data: \(deezerMusicList)")
                DispatchQueue.main.async {
                    callback(deezerMusicList)
                }
            }catch{
                print("song error: \(error)")
            }
            
        }
    }
}
