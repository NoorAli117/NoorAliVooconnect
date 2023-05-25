//
//  ReelsPostViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 15/12/22.
//

import Foundation

struct ReelPostDataModel {
    
    var userUUID: String = String()
    var title: String = String()
    var description: String = String()
    var location: String = String()
    var visibility: String = String()
    var contentType: String = String()
    var musicTrack: String = String()
    var musicURL: String = String()
    var allowComments: Bool = Bool()
    var allowDuet: Bool = Bool()
    var allowStitch: Bool = Bool()
    var forPlanID: Int = Int()
    var reelsName: String = String()
    var reelsSize: String = String()
    
}

class ReelsPostViewModel: ObservableObject {
    
    @Published var reelPostDataModel: ReelPostDataModel = ReelPostDataModel()
    private let uploadReelsDetailResource = UploadReelsDetailResource()
//    var post = PostModel()
    
    // call The API to post Reels
    func uploadReelsDetails(post: PostModel) {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        
        let reelsName = UserDefaults.standard.string(forKey: "imageName") ?? ""
        print("THE reelsName is======", reelsName )
        
        let reelsSize = UserDefaults.standard.string(forKey: "reelSize") ?? ""
        print("THE reelsSize is=======", reelsSize)
        
        let contentRequest = ContentDetail(name: reelsName, size: reelsSize)
        
        let request = ReelsPostRequest(content: [contentRequest], title: "The Title of Post", category: 2, tags: [], musicTrack: "this is Audio file", allowDuet: post.allowDuet, visibility: post.visibility.rawValue, allowStitch: post.allowStitch, location: "karachi sindh", allowComment: post.allowComments, userUuid: uuid, contentType: "video", descriptionValue: " this is DesCription mention @irfhnh.1 @irfhnh.2 and Hash Tag #irfhnh.1 #irfhnh.2 ", musicUrl: "music track")
        
        print("RQUEST======================",request)
        
        uploadReelsDetailResource.uploadReelsDeatils(reelsPostRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    print("Success=============")
                }
            } else {
                DispatchQueue.main.async {
                    print("Failure=============")
                }
            }
        }
        
    }
    
    
    
}
