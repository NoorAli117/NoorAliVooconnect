//
//  PostModel.swift
//  Vooconnect
//
//  Created by JV on 25/02/23.
//

import Foundation
import AVPlayerViewController_Subtitles

///Model of video and image post
class PostModel: Identifiable, Codable{

    var id = UUID().uuidString
    var contentUrl : URL?
    var songModel : DeezerSongModel?
    var coverUrl : URL?
    var description : String
    var tagPeople : [TagPeopleModel]
    var location : LocationModel
    var visibility : TypeOfVisibility
    var allowComments : Bool
    var allowDuet : Bool
    var allowStitch : Bool
    var categories : [PostCategoriesModel]
    var contentOverlay : [ContentOverlayModel]
    var typeContent = TypeContent.video
    var enableCaptions = false
    var audioContentUrl : URL?
    var speed : Float
    
    enum CodingKeys: String, CodingKey
    {
        case contentUrl
        case songModel
        case coverUrl
        case description
        case tagPeople
        case location
        case visibility
        case allowComments
        case allowDuet
        case allowStitch
        case categories
        case contentOverlay
        case typeContent
        case enableCaptions
        case audioContentUrl
        case speed
    }
    
    init() {
        self.id = UUID().uuidString
        self.contentUrl = nil
        self.songModel = nil
        self.coverUrl = nil
        self.description = ""
        self.tagPeople = []
        self.location = LocationModel(latitude: 0, longitude: 0, accuracy: 0)
        self.visibility = TypeOfVisibility.everyone
        self.allowComments = true
        self.allowDuet = false
        self.allowStitch = false
        self.categories = []
        self.contentOverlay = []
        self.enableCaptions = false
        self.audioContentUrl = nil
        self.speed = 1
    }
    
    ///Check if content is an image or a video using [contentUrl] extension
    func isImageContent() -> Bool{
        let isImage = self.contentUrl?.absoluteString.lowercased().contains(".mp4") == false && self.contentUrl?.absoluteString.lowercased().contains(".mov") == false
//        print("is image \(isImage)")
        return isImage
    }
    
    ///Convert model in to dictonary
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
          guard let label = label else { return nil }
          return (label, value)
        }).compactMap { $0 })
        return dict
    }
    
    ///Get text overlay content
    var getTextOverlayContent : ContentOverlayModel? {
        let t = contentOverlay.first(where: {val in val.type == TypeOfOverlay.text})
        return t;
    }
    
}
