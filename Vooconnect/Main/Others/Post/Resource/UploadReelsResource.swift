//
//  UploadReelsResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 12/12/22.
//

import Foundation
import UIKit

class UploadReelsResource {
    
    func uploadReels(imageUploadRequest: URL,paramName : String, fileName : String, subtitleLang : String, subtitle_apply : Bool,  complitionHandler : @escaping(Bool, String?) -> Void) {
        let session = URLSession.shared
        let boundary = UUID().uuidString
        var data = Data()
        
        let parameters : [String:Any]?
        parameters = ["upload_path" : "reels"]
        
        var urlRequest = URLRequest(url: URL(string: assatEndPoint + EndPoints.uploadFile)!)
        urlRequest.httpMethod = "post"

        if let fileData = try? Data(contentsOf: imageUploadRequest) {
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            
            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
            data.append(fileData)
            
            // Add subtitle_apply parameter
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(subtitle_apply)\"\r\n".data(using: .utf8)!)
            data.append("\r\ntrue\r\n".data(using: .utf8)!)
            
            // Add subtitleLang parameter
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(subtitleLang)\"\r\n".data(using: .utf8)!)
            data.append("\r\nen-US\r\n".data(using: .utf8)!)
           
            
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        }
        
        
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
            
            print("ACCESS TOKEN=========", tokenData)
            
        }
        
        session.uploadTask(with: urlRequest, from: data) { httpData, httpResponse, httpError in
            
            if let data = httpData {
                
                do {
                            let data = try? JSONDecoder().decode(UploadRes.self, from: data)
                    if let data {
                        if data.status == true {
                            print(data.data)
                            let name = data.data.first?.name ?? ""
                            UserDefaults.standard.set(name, forKey: "imageName")

                            let size = data.data.first?.size ?? ""
                            UserDefaults.standard.set(size, forKey: "reelSize")

                            let reelsName = UserDefaults.standard.string(forKey: "imageName") ?? ""
                            print("THE reelsName is======", reelsName )

                            let reelsSize = UserDefaults.standard.string(forKey: "reelSize") ?? ""
                            print("THE reelsSize is=======", reelsSize)
                            complitionHandler(true, "")
                        }
                    }else{
                        complitionHandler(false, httpError?.localizedDescription)
                    }
                } catch {
                    debugPrint("Error in decoding the model")
                    complitionHandler(false, "Please login first")
                }
                
            } else if let resposne = httpResponse {
                
            } else {
                print("Error: \(httpError?.localizedDescription)")
                complitionHandler(false, httpError?.localizedDescription)
                print("ther error")
            }
            
        }.resume()
        
        
    }
    
    func uploadPost(post: ReelsPostRequest, complitionHandler : @escaping(Bool, String?) -> Void) {
//        let session = URLSession.shared
//        let boundary = UUID().uuidString
////        var data = Data()
//
////        let parameters : [String:Any]?
////        parameters = ["upload_path" : "reels"]
////
////        if parameters != nil {
////            for (key, value) in parameters! {
////                data.append("--\(boundary)\r\n".data(using: .utf8)!)
////                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
////                data.append("\(value)\r\n".data(using: .utf8)!)
////            }
////        }
//
////        var urlRequest = URLRequest(url: URL(string: userApiEndPoint + EndPoints.createNewPost)!)
////        urlRequest.httpMethod = "post"
//
////        urlRequest.httpBody =
////        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
////        data.append("Content-Disposition: form-data; name=paramName"; filename=\"fileName")\"\r\n".data(using: .utf8)!)
////        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
////        data.append(imageUploadRequest.mp4)
////        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
////        let json: [String: Any] = ["title": "ABC",
////                                   "content": ]
////        let jsonData = try? JSONSerialization.data(withJSONObject: json)
////        urlRequest.httpBody = jsonData
//        var urlRequest = URLRequest(url: URL(string: getBaseURL + EndPoints.createNewPost)!)
//        urlRequest.httpMethod = "post"
//        let jsonData = try? JSONSerialization.data(withJSONObject: post.dict)
//        urlRequest.httpBody = jsonData
//
//        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
//
//            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
////            urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
//
//            print("ACCESS TOKEN=========", tokenData)
//
//        }
//
//        session.dataTask(with: urlRequest) { httpData, httpResponse, httpError in
//
//            if let data = httpData {
//                do {
//                    let res = try JSONDecoder().decode(PostRes.self, from: data)
//                    if res.status == true {
//                        complitionHandler(true, "")
//                    }else{
//                        complitionHandler(false, httpError?.localizedDescription)
//                    }
//                }catch {
//                    print(error.localizedDescription)
//                }
////                do {
////                    let data : [String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
////
////                    debugPrint("The Profile Response", data)
//////                    complitionHandler(true, "")
////
////                    if data["status"] as! Int == 1 {
////                        print("Susses===========")
////
////                        do {
////                            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
////                            do {
////                                let model = try JSONDecoder().decode(uploadImageSuccess.self, from: data)
////                                print("The success Image Name==========", model.data?[0].name ?? "")
//////                                complitionHandler(false, model.errors.)
////
////                                let name = model.data?[0].name ?? ""
////                                UserDefaults.standard.set(name, forKey: "imageName")
////
////                                let size = model.data?[0].size ?? ""
////                                UserDefaults.standard.set(size, forKey: "reelSize")
////
////                                let reelsName = UserDefaults.standard.string(forKey: "imageName") ?? ""
////                                print("THE reelsName is======", reelsName )
////
////                                let reelsSize = UserDefaults.standard.string(forKey: "reelSize") ?? ""
////                                print("THE reelsSize is=======", reelsSize)
////
////                                complitionHandler(true, "")
////
//////                                complitionHandler(false, model.data?[0].name ?? "")
////
////                            } catch {
////                                print("the decoded error", error.localizedDescription)
////                            }
////                        } catch {
////                            print("the data decoded error", error.localizedDescription)
////                        }
////
////                    } else {
////                        print("Failed===========")
////                    }
////
////                } catch {
////                    debugPrint("Error in decoding the model")
////                    complitionHandler(false, "Please login first")
////                }
//
//            } else if let resposne = httpResponse {
//
//            } else {
//                print("ther error")
//            }
//
//        }.resume()
//
//        let parameters = "{\n    \"user_uuid\": \"be991a17-5407-4771-9a96-6b6aa6df6a48\",\n    \"title\": \"The Post to Share\",\n    \"description\": \" this is DesCription mention @irfhnh.1 @irfhnh.2 and Hash Tag #irfhnh.1 #irfhnh.2 \",\n    \"content_type\": \"image\",\n    \"category\": 2,\n    \"music_track\": \"this is Audio file\",\n    \"location\": \"Karachi Sindh Pakistan\",\n    \"visibility\": \"public\",\n    \"music_url\": \"music track\",\n    \"content\": [\n        {\n            \"name\": \"/1685048439798-2022102721396.png\",\n            \"size\": \"35.33\"\n        }\n    ],\n    \"allow_comment\": true,\n    \"allow_duet\": false,\n    \"allow_stitch\": true,\n    \"tags\": [\n        \"7520e981-f0a7-4a3d-9a05-94780754c4eb\",\n        \"7520e981-f0a7-4a3d-9a05-94780754c4ba\"\n    ]\n}"
        let parameters = post.dict
        let postData = try? JSONSerialization.data(
            withJSONObject: parameters,
            options: [])

        var request = URLRequest(url: URL(string: getBaseURL + EndPoints.createNewPost)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            request.addValue("Bearer \(tokenData)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            do {
                let res = try JSONDecoder().decode(PostRes.self, from: data)
                if res.status == true {
                    complitionHandler(true, "")
                }else{
                    complitionHandler(false, error?.localizedDescription)
                }
            }catch {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }
    
}



struct UploadRes: Codable {
    let status: Bool
    let data: [Datum]
}

struct Datum: Codable {
    let name, size: String
}

struct PostRes: Codable {
    let status: Bool?
    let message: String?
}

func uploadCaption(imageUploadRequest: URL,paramName : String, fileName : String, complitionHandler : @escaping(Bool, String?) -> Void) {
    let session = URLSession.shared
    let boundary = UUID().uuidString
    var data = Data()
    
    let parameters : [String:Any]?
    parameters = ["upload_path" : "reels"]
    
    var urlRequest = URLRequest(url: URL(string: assatEndPoint + EndPoints.uploadFile)!)
    urlRequest.httpMethod = "post"

    if let fileData = try? Data(contentsOf: imageUploadRequest) {
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
        data.append(fileData)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    }
    
    
    if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
        
        urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
        
        print("ACCESS TOKEN=========", tokenData)
        
    }
    
    session.uploadTask(with: urlRequest, from: data) { httpData, httpResponse, httpError in
        
        if let data = httpData {
            
            do {
                        let data = try? JSONDecoder().decode(UploadRes.self, from: data)
                if let data {
                    if data.status == true {
                        let name = data.data.first?.name ?? ""
                        UserDefaults.standard.set(name, forKey: "imageName")

                        let size = data.data.first?.size ?? ""
                        UserDefaults.standard.set(size, forKey: "reelSize")

                        let reelsName = UserDefaults.standard.string(forKey: "imageName") ?? ""
                        print("THE reelsName is======", reelsName )

                        let reelsSize = UserDefaults.standard.string(forKey: "reelSize") ?? ""
                        print("THE reelsSize is=======", reelsSize)
                        complitionHandler(true, "")
                    }
                }else{
                    complitionHandler(false, httpError?.localizedDescription)
                }
            } catch {
                debugPrint("Error in decoding the model")
                complitionHandler(false, "Please login first")
            }
            
        } else if let resposne = httpResponse {
            
        } else {
            print("ther error")
        }
        
    }.resume()
    
    
}
