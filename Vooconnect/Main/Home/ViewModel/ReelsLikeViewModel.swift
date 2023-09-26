//
//  ReelsLikeViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 17/12/22.
//

import Foundation

struct ReelsLikeDataModel {
    
    var userUUID: String = ""
    var postID: Int = 0
    var reactionType: Int = 0
    
}

struct BlockPostDataModel {
    
    var uuid: String = ""
    var postID: Int = 0
    
    var successMessage: String = String()
    var isPresentingSuccess: Bool = false
    
}

struct AbuseReportPostDataModel {
    
    var uuid: String = ""
    var postID: Int = 0
    
    var successMessage: String = String()
    var isPresentingSuccess: Bool = false
    
}

struct BookMarkDataModel {
    
    var userUUID: String = ""
    var postID: Int = 0
    
    var successMessage: String = String()
    var isPresentingSuccess: Bool = false
    
}

struct CommentDataModel {
    
    var userUUID: String = ""
    var postID: Int = 0
    var commentText: String = ""
    var replyText: String = ""
    var replyToCommentId: Int = 0
    var showEmoji: Bool = false
    var showAtTheRate: Bool = false
    
}


class ReelsLikeViewModel: ObservableObject {
    
    @Published var reelsLikeDataModel: ReelsLikeDataModel = ReelsLikeDataModel()
    @Published var blockPostDataModel: BlockPostDataModel = BlockPostDataModel()
    @Published var abuseReportPostDataModel: AbuseReportPostDataModel = AbuseReportPostDataModel()
    @Published var bookMarkDataModel: BookMarkDataModel = BookMarkDataModel()
    @Published var commentDataModel: CommentDataModel = CommentDataModel()
    @Published var postComments: [CommentResponse] = []
    @Published var postComment: [CommentsData] = []
    @Published var commentReplies: [CommentsData] = []
    @Published var interestCategory: [InterestCateg] = []
    @Published var userInterestCategory: [UserInterestCateg] = []
    @Published var followingUsers: [FollowingUsers] = []
    @Published var profile: UserProfile?
    
    private let reelsLikeResource = ReelsLikeResource()
    
    init(){
        fetchCommentsApi()
        fetchInterestCategoryApi()
        fetchUICategoryApi()
        UserFollowingUsers()
        }
    
    func commentLikeApi(reactionType: Int, comment_id: Int) {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        
        let request = CommentLikeRequest(user_uuid: uuid, comment_id: comment_id, reaction_type: reactionType)
        
        print("REQUEST=========",request)
        
        reelsLikeResource.hittingLikeCommentApi(commentLikeRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    print("Success=========")
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Faileur===========")
                    
                }
                
            }
        }
        
    }
    func reelsLikeApi(reactionType: Int, postID: Int) {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        
        let request = LikeRequest(user_uuid: uuid, post_id: postID, reaction_type: reactionType)
        
        print("REQUEST=========",request)
        
        reelsLikeResource.hittingLikeApi(likeRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    print("Success=========")
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Faileur===========")
                    
                }
                
            }
        }
        
    }
    func commentReactionApi(reactionType: Int, commentId: Int) {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        
        let request = CommentLikeRequest(user_uuid: uuid, comment_id: commentId, reaction_type: reactionType)
        
        print("REQUEST=========",request)
        
        reelsLikeResource.hittingCommentReactionApi(commentLikeRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    print("Success=========")
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Faileur===========")
                    
                }
                
            }
        }
        
    }
    func reelsReactionApi(reactionType: Int, postID: Int) {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        
        let request = LikeRequest(user_uuid: uuid, post_id: postID, reaction_type: reactionType)
        
        print("REQUEST=========",request)
        
        reelsLikeResource.hittingReactionApi(likeRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    print("Success=========")
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Faileur===========")
                    
                }
                
            }
        }
        
    }
    func UserFollowingUsers(){
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        print("User UUID=========",uuid)
        self.getFollowingUsers(uuid: uuid)
        print("----------------------\(uuid)")
    }
    
    
    
    func getFollowingUsers(uuid: String){
        
        let parameters = "{\r\n    \"uuid\": \"\(uuid)\"\r\n}"
        let postData = parameters.data(using: .utf8)

        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.followingList)!,timeoutInterval: Double.infinity)
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            print("Access Token============",tokenData)
        }

        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postData

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            self.followingUsers = []
//          print(String(data: data, encoding: .utf8)!)
            do {
                let decodedData = try JSONDecoder().decode(Following.self, from: data)
                DispatchQueue.main.async {
                    self.followingUsers = decodedData.data
                    print("Following data: \(self.followingUsers)")
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }

        task.resume()

    }
    
    func blockUserApi() {  // postID
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let user_uuid = UserDefaults.standard.string(forKey: "user_uuid") ?? ""
        
        let request = BlockUserRequest(uuid: uuid, user_uuid: user_uuid)
        
        print("REQUEST=========",request)
        
            reelsLikeResource.hittingBlockUserApi(blockUserRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    print("Success=========")
                    
                    self.blockPostDataModel.isPresentingSuccess = true
                    self.blockPostDataModel.successMessage = sussesMessage ?? ""
                    
//                    likeVM.blockPostDataModel.isPresentingSuccess
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Faileur===========")
                    
                }
                
            }
        }
        
    }
    func blockPostApi() {  // postID
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let postID = UserDefaults.standard.integer(forKey: "postID")
        
        let request = BlockPostRequest(uuid: uuid, post_id: postID)
        
        print("REQUEST=========",request)
        
        reelsLikeResource.hittingBlockPostApi(blockPostRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    print("Success=========")
                    
                    self.blockPostDataModel.isPresentingSuccess = true
                    self.blockPostDataModel.successMessage = sussesMessage ?? ""
                    
//                    likeVM.blockPostDataModel.isPresentingSuccess
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Faileur===========")
                    
                }
                
            }
        }
        
    }
    
    func abuseReportPostApi(desc: String) {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let postID = UserDefaults.standard.integer(forKey: "postID")
        
        let request = ReportPostRequest(uuid: uuid, post_id: postID, description: desc)
        
        print("REQUEST=========",request)
        
        reelsLikeResource.hittingAbuseReportPostApi(abusePostRequest: request) {  isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    print("Success=========")
                    
                    self.abuseReportPostDataModel.successMessage = sussesMessage ?? ""
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Faileur===========")
                    
                }
                
            }
        }
        
    }
    
    func bookMarkApi(completion: @escaping (String, Bool) -> Void) {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = BookMarkRequest(user_uuid: uuid, post_id: bookMarkDataModel.postID)
        
        print("REQUEST=========",request)
        
        reelsLikeResource.hittingBookMarkApi(bookMarkRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    print("Success=========")
                    completion(sussesMessage!, true)
                    self.bookMarkDataModel.isPresentingSuccess = true
                    self.bookMarkDataModel.successMessage = sussesMessage ?? ""
                    
//                    likeVM.blockPostDataModel.isPresentingSuccess
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Faileur===========")
                    completion(sussesMessage!, false)
                    
                }
                
            }
        }
        
    }
    
    func addCommentApi(completion:  @escaping (Bool) -> ()) {
            
            let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
            let postID = UserDefaults.standard.integer(forKey: "postID")
            
            let request = CommentRequest(user_uuid: uuid, post_id: postID, comment: commentDataModel.commentText)
            
            print("REQUEST=========",request)
            
            reelsLikeResource.hittingCommentApi(commentRequest: request) { isSuccess, sussesMessage in
                if isSuccess {
                    DispatchQueue.main.async {
                        print("Success=========")
                        completion(true)
                        
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        print("Faileur===========")
                        completion(false)
                    }
                    
                }
            }
            
        }
        
    func followApi(user_uuid: String) {
            
            let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
//            let postID = UserDefaults.standard.integer(forKey: "postID")
            
            let request = FollowRequest(user_uuid: user_uuid, uuid: uuid)
            
            print("REQUEST=========",request)
            
            reelsLikeResource.hittingFollowApi(followRequest: request) { isSuccess, sussesMessage in
                if isSuccess {
                    DispatchQueue.main.async {
                        print("Success=========")
                        
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        print("Faileur===========")
                        
                    }
                    
                }
            }
            
        }
    func unFollowApi(user_uuid: String) {
            
            let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
//            let postID = UserDefaults.standard.integer(forKey: "postID")
            
            let request = FollowRequest(user_uuid: user_uuid, uuid: uuid)
            
            print("REQUEST=========",request)
            
            reelsLikeResource.hittingUnFollowApi(followRequest: request) { isSuccess, sussesMessage in
                if isSuccess {
                    DispatchQueue.main.async {
                        print("Success=========")
                        
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        print("Faileur===========")
                        
                    }
                    
                }
            }
            
        }
        
    func replyToCommentApi(commentId: Int, completion:  @escaping (Bool) -> ()) {
            
            let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
            let postID = UserDefaults.standard.integer(forKey: "postID")
            

            let request = ReplyToCommentRequest(user_uuid: uuid, post_id: postID, comment: commentDataModel.commentText, reply_to_comment_id: commentId)
            
            print("REQUEST=========",request)
            
            reelsLikeResource.hittingReplyToCommentApi(replyToCommentRequest: request) { isSuccess, sussesMessage in
                if isSuccess {
                    DispatchQueue.main.async {
                        print("Success=========")
                        completion(true)
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        print("Faileur===========")
                        completion(false)
                    }
                    
                }
            }
            
        }
        
    func replyToReplyApi(commentId: Int, reply_to_reply: String, completion:  @escaping (Bool) -> ()) {
            
            let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
            let postID = UserDefaults.standard.integer(forKey: "postID")
            

            let request = ReplyToReplyRequest(user_uuid: uuid, post_id: postID, comment: commentDataModel.commentText, reply_to_comment_id: commentId, reply_to_reply: reply_to_reply)
            
            print("REQUEST=========",request)
            
            reelsLikeResource.hittingReplyToReplyApi(replyToReplyRequest: request) { isSuccess, sussesMessage in
                if isSuccess {
                    DispatchQueue.main.async {
                        print("Success=========")
                        completion(true)
                        
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        print("Faileur===========")
                        completion(false)
                    }
                    
                }
            }
            
        }
        
    func fetchCommentsApi() {
        let postID = UserDefaults.standard.integer(forKey: "postID")
        
        let parameters = "{\r\n    \"post_id\": \"\(postID)\"\r\n    \n}"
        let postData = parameters.data(using: .utf8)
        
        var urlRequest = URLRequest(url: URL(string: getBaseURL + EndPoints.GetComments)!)
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            print("Access Token============",tokenData)
        }
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postData
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    guard let data = data else { return }
//                    print("comment Data: \(String(describing: String(data: data, encoding: .utf8)))")
                    DispatchQueue.main.async {
                        do {
                            let decodedComments = try JSONDecoder().decode(CommentsModel.self, from: data)
                    
                            self.postComment = decodedComments.data
                            print("post Comments: \(self.postComment)")
                        } catch let error {
                            print("Error decoding Comments: ", error)
                        }
                    }
                }
            }

            dataTask.resume()
            
        }
    func fetchCommentRepliesApi(commentId: Int) {
        let postID = UserDefaults.standard.integer(forKey: "postID")
        
//        let parameters = "{\r\n    \"post_id\": \"\(postID)\"\r\n    \n}"
        let commentReplyBodt = ReplyToComment(post_id: postID, parent_comment_id: commentId)
        
        var urlRequest = URLRequest(url: URL(string: getBaseURL + EndPoints.GetComments)!)
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            print("Access Token============",tokenData)
        }
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(commentReplyBodt)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    guard let data = data else { return }
//                    print("comment Data: \(String(describing: String(data: data, encoding: .utf8)))")
                    DispatchQueue.main.async {
                        do {
                            let decodedComments = try JSONDecoder().decode(CommentsModel.self, from: data)
                    
                            self.commentReplies = decodedComments.data
                            print("comment Replies: \(self.commentReplies)")
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }

            dataTask.resume()
            
        }
        
    func fetchInterestCategoryApi() {
            
            let urlRequest = URLRequest(url: URL(string: getBaseURL + EndPoints.interest_categ)!)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        do {
                            let decodedCategories = try JSONDecoder().decode([InterestCateg].self, from: data)
                    
                            self.interestCategory = decodedCategories
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }

            dataTask.resume()
            
        }
        
    func fetchUICategoryApi() {
            
            let urlRequest = URLRequest(url: URL(string: getBaseURL + EndPoints.user_interest_categ)!)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        do {
                            let decodedUICategories = try JSONDecoder().decode([UserInterestCateg].self, from: data)
                    
                            self.userInterestCategory = decodedUICategories
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }

            dataTask.resume()
            
        }
    
    
    func getUserProfile(uuid: String){
//        let user_uuid = UserDefaults.standard.string(forKey: "user_uuid") ?? ""
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.profile + "/" + uuid)!)
        
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken"){
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            print("Access Token============",tokenData)
        }
        
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            do {
                let decodedData = try JSONDecoder().decode(UserProfileModel.self, from: data)
                DispatchQueue.main.async {
                    print("profile Data \(decodedData.data)")
                    self.profile = decodedData.data
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func formatTimeElapsed(from dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set locale to ensure correct date parsing
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Ensure the date is in GMT
            
            if let createdAtDate = dateFormatter.date(from: dateString) {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day, .hour, .minute], from: createdAtDate, to: Date())
                
                if let days = components.day, days > 0 {
                    return "\(days) day\(days == 1 ? "" : "s") ago"
                } else if let hours = components.hour, hours > 0 {
                    return "\(hours) hour\(hours == 1 ? "" : "s") ago"
                } else if let minutes = components.minute, minutes > 0 {
                    return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
                } else {
                    return "Just now"
                }
            } else {
                return "Invalid Date"
            }
        }
    
    
}
