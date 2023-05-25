//
//  UploadReelsResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 12/12/22.
//

import Foundation
import UIKit

class UploadReelsResource {
    
    func uploadReels(imageUploadRequest: URL,paramName : String, fileName : String, complitionHandler : @escaping(Bool, String?) -> Void) {
        let session = URLSession.shared
        let boundary = UUID().uuidString
        var data = Data()
        
        let parameters : [String:Any]?
        parameters = ["upload_path" : "reels"]
        
//        if parameters != nil {
//            for (key, value) in parameters! {
//                data.append("--\(boundary)\r\n".data(using: .utf8)!)
//                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//                data.append("\(value)\r\n".data(using: .utf8)!)
//            }
//        }

        var urlRequest = URLRequest(url: URL(string: assatEndPoint + EndPoints.uploadFile)!)
        urlRequest.httpMethod = "post"

//            let contentType = "multipart/form-data; boundary=\(boundary)"
//            urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
//            let body = NSMutableData()
            if let fileData = try? Data(contentsOf: imageUploadRequest) {
                data.append("--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
                data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                data.append(fileData)
                data.append("\r\n".data(using: .utf8)!)
            }
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
////        data.append(imageUploadRequest)
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
//        urlRequest.httpBody = body as Data
        
        
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
            
            print("ACCESS TOKEN=========", tokenData)
            
        }
        
        session.uploadTask(with: urlRequest, from: data) { httpData, httpResponse, httpError in
            
            if let data = httpData {
                
                do {
                    let data : [String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                    
                    debugPrint("The Profile Response", data)
//                    complitionHandler(true, "")
                    
                    if data["status"] as! Int == 1 {
                        print("Susses===========")
                        
                        do {
                            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                            do {
                                let model = try JSONDecoder().decode(uploadImageSuccess.self, from: data)
                                print("The success Image Name==========", model.data?[0].name ?? "")
//                                complitionHandler(false, model.errors.)
                                
                                let name = model.data?[0].name ?? ""
                                UserDefaults.standard.set(name, forKey: "imageName")
                                
                                let size = model.data?[0].size ?? ""
                                UserDefaults.standard.set(size, forKey: "reelSize")
                                
                                let reelsName = UserDefaults.standard.string(forKey: "imageName") ?? ""
                                print("THE reelsName is======", reelsName )
                                
                                let reelsSize = UserDefaults.standard.string(forKey: "reelSize") ?? ""
                                print("THE reelsSize is=======", reelsSize)
                                
                                complitionHandler(true, "")
                                
//                                complitionHandler(false, model.data?[0].name ?? "")
                                
                            } catch {
                                print("the decoded error", error.localizedDescription)
                            }
                        } catch {
                            print("the data decoded error", error.localizedDescription)
                        }
                        
                    } else {
                        print("Failed===========")
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
    
    func uploadPost(post: PostModel, complitionHandler : @escaping(Bool, String?) -> Void) {
        let session = URLSession.shared
        let boundary = UUID().uuidString
//        var data = Data()
        
//        let parameters : [String:Any]?
//        parameters = ["upload_path" : "reels"]
        
//        if parameters != nil {
//            for (key, value) in parameters! {
//                data.append("--\(boundary)\r\n".data(using: .utf8)!)
//                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//                data.append("\(value)\r\n".data(using: .utf8)!)
//            }
//        }
//
        var urlRequest = URLRequest(url: URL(string: getBaseURL + EndPoints.createNewPost)!)
        urlRequest.httpMethod = "post"
//        urlRequest.httpBody =
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=paramName"; filename=\"fileName")\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//        data.append(imageUploadRequest.mp4)
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        let userUuid = UserDefaults.standard.string(forKey: "uuid")
        let filename = UserDefaults.standard.string(forKey: "imageName")
        let filesize = UserDefaults.standard.string(forKey: "reelSize")
        let jsonD: [String: Any] = [
            "user_uuid": userUuid ?? "",
            "title": "title",
            "description": post.description,
            "content_type": post.isImageContent() ? "Image" : "Video",
            "category": "",
            "music_track": "",
            "location": "Karachi sindh pakistan",
            "visibility": "everyone",
            "music_url": "",
            "content": [
                [ "name": filename ?? "", "size": filesize ?? "" ]
            ],
            "allow_comment": post.allowComments,
            "allow_duet": post.allowDuet,
            "allow_stitch": post.allowStitch,
            "tags": []
        ]
//        print(jsonD)
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonD)
//        print(jsonData!)
        urlRequest.httpBody = jsonData
        
        
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("application/json; boundary=\(boundary)", forHTTPHeaderField: "content-type")
            
            print("ACCESS TOKEN=========", tokenData)
            
        }
        
        session.uploadTask(with: urlRequest, from: jsonData) { httpData, httpResponse, httpError in
            
            if let data = httpData {
                
                do {
                    let data : [String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                    
                    debugPrint("The Profile Response", data)
//                    complitionHandler(true, "")
                    
                    if data["status"] as! Int == 1 {
                        print("Susses===========")
                        
                        do {
                            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                            do {
                                let model = try JSONDecoder().decode(uploadImageSuccess.self, from: data)
                                print("The success Image Name==========", model.data?[0].name ?? "")
//                                complitionHandler(false, model.errors.)
                                
                                let name = model.data?[0].name ?? ""
                                UserDefaults.standard.set(name, forKey: "imageName")
                                
                                let size = model.data?[0].size ?? ""
                                UserDefaults.standard.set(size, forKey: "reelSize")
                                
                                let reelsName = UserDefaults.standard.string(forKey: "imageName") ?? ""
                                print("THE reelsName is======", reelsName )
                                
                                let reelsSize = UserDefaults.standard.string(forKey: "reelSize") ?? ""
                                print("THE reelsSize is=======", reelsSize)
                                
                                complitionHandler(true, "")
                                
//                                complitionHandler(false, model.data?[0].name ?? "")
                                
                            } catch {
                                print("the decoded error", error.localizedDescription)
                            }
                        } catch {
                            print("the data decoded error", error.localizedDescription)
                        }
                        
                    } else {
                        print("Failed===========")
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
    
}
