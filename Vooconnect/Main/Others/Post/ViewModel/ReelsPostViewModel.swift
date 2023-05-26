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
    var allowComments: String = String()
    var allowDuet: String = String()
    var allowStitch: String = String()
    var forPlanID: Int = Int()
    var reelsName: String = String()
    var reelsSize: String = String()
    
}

class ReelsPostViewModel: ObservableObject {
    
    @Published var reelPostDataModel: ReelPostDataModel = ReelPostDataModel()
    private let uploadReelsDetailResource = UploadReelsDetailResource()
    
    // call The API to post Reels
//    func uploadReelsDetails() {
//        
//        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
//        
//        let reelsName = UserDefaults.standard.string(forKey: "imageName") ?? ""
//        print("THE reelsName is======", reelsName )
//        
//        let reelsSize = UserDefaults.standard.string(forKey: "reelSize") ?? ""
//        print("THE reelsSize is=======", reelsSize)
//        
//        let contentRequest = ContentDetail(name: reelsName, size: reelsSize)
//        
//        let request = ReelsPostRequest(userUUID: uuid, title: "test", welcomeDescription: "test", location: "India", visibility: "public", contentType: "video", musicTrack: "Test Stream", musicURL: "https://cdns-preview-4.dzcdn.net/stream/c-4de93405ed0774e43f6e3fb15ab47e04-2.mp3", allowComment: "yes", allowDuet: "yes", allowStitch: "yes", forPlanID: 1, content: [contentRequest])
//        
//        print("RQUEST======================",request)
//        
//        uploadReelsDetailResource.uploadReelsDeatils(reelsPostRequest: request) { isSuccess, sussesMessage in
//            if isSuccess {
//                DispatchQueue.main.async {
//                    print("Success=============")
//                }
//            } else {
//                DispatchQueue.main.async {
//                    print("Failure=============")
//                }
//            }
//        }
//        
//    }
//    
    
    
}
