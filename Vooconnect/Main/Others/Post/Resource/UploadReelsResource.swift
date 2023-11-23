//
//  UploadReelsResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 12/12/22.
//

import Foundation
import UIKit

class UploadReelsResource {
    
    var contentDetail: [ContentDetail] = []
//    private var fileData: Data?
    func uploadReels(imageUploadRequest: URL,paramName : String, fileName : String, subtitleLang : String, subtitle_apply : String, progress: @escaping (Double) -> Void,  complitionHandler : @escaping(Bool, String?) -> Void) {
        let session = URLSession.shared
        let boundary = UUID().uuidString
        var data = Data()

        var urlRequest = URLRequest(url: URL(string: assatEndPoint + EndPoints.uploadFile)!)
        urlRequest.httpMethod = "post"
        print("video Url: \(imageUploadRequest)")
        print("video Urlllll: \(fileName)")

        if let fileData = try? Data(contentsOf: imageUploadRequest) {
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            
            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
            data.append(fileData)
            
            // Add subtitle_apply parameter
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"subtitle_apply\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(subtitle_apply)".data(using: .utf8)!)
            
            // Add subtitleLang parameter
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"subtitleLang\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(subtitleLang)".data(using: .utf8)!)
            
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        }



        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {

            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")

            print("ACCESS TOKEN=========", tokenData)
            print(String(data: data, encoding: .utf8) ?? "")

        }

        var totalBytesUploaded: Int = 0
        
        session.uploadTask(with: urlRequest, from: data) { httpData, httpResponse, httpError in

            if let data = httpData {
                
                totalBytesUploaded += data.count
                let progressValue = Double(totalBytesUploaded) / Double(data.count)
                
                // Call the progress closure
                progress(progressValue)
                print("progressValue\(progressValue)")
                
                print(String(data: data, encoding: .utf8)!)
                do {
                            let data = try? JSONDecoder().decode(UploadRes.self, from: data)
                    if let data {
                        if data.status == true {
                            UserDefaults.standard.set(data.music, forKey: "musicUrl")
                            let musicUrl = UserDefaults.standard.string(forKey: "musicUrl") ?? ""
                            print("The musicUrl is======", musicUrl)
                            self.contentDetail = data.data.map { datum in
                                return ContentDetail(name: datum.name!, size: datum.size!)
                            }
                            var largestSize: Double = 0.0 // Assuming size is in numeric format
                            var smallestSize: Double = Double.greatestFiniteMagnitude
                            let dataArray = data.data
                            
                            // Loop through the data array and access "name" and "size"
                            for datum in dataArray {
//                                let name = datum.name
//                                let size = datum.size
                                if let reelNameContainsMP4 = datum.name?.contains("mp4") {
                                    UserDefaults.standard.set(reelNameContainsMP4, forKey: "reelName")
                                    let reelsName = UserDefaults.standard.string(forKey: "reelName") ?? ""
                                    print("The reelsName is======", reelsName)
                                } else if let nameContainsJPGOrPNG = datum.name?.contains("jpg"){
                                    UserDefaults.standard.set(nameContainsJPGOrPNG, forKey: "thumbnail")
                                    let thumbnail = UserDefaults.standard.string(forKey: "thumbnail") ?? ""
                                    print("The thumbnail is======", thumbnail)
                                }
                                    
                                if let sizeValue = Double(datum.size!) {
                                    if sizeValue > largestSize {
                                        largestSize = sizeValue
                                        let reelSize = largestSize
                                        UserDefaults.standard.set(reelSize, forKey: "reelSize")
                                        
                                        _ = UserDefaults.standard.string(forKey: "reelSize") ?? ""
                                        print("The reelSize is======", reelSize )
                                    }
                                    if sizeValue < smallestSize {
                                        smallestSize = sizeValue
                                        let thumbSize = smallestSize
                                        UserDefaults.standard.set(thumbSize, forKey: "thumbSize")
                                        
                                        _ = UserDefaults.standard.string(forKey: "thumbSize") ?? ""
                                        print("The thumbSize is======", thumbSize )
                                    }
                                }
                            }
                            complitionHandler(true, "done")
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
    
    func uploadPost(post: ReelsPostRequest, progress: @escaping (Double) -> Void, completionHandler: @escaping (Bool, String?) -> Void) {
        let parameters = post.dict
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        var request = URLRequest(url: URL(string: getBaseURL + EndPoints.createNewPost)!, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            request.addValue("Bearer \(tokenData)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "POST"
        request.httpBody = postData

        let totalFileSize = postData?.count ?? 0

        var uploadedBytes = 0

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                completionHandler(false, error?.localizedDescription)
                return
            }

            uploadedBytes += data.count

            let progressValue = Double(uploadedBytes) / Double(totalFileSize)
            progress(progressValue)
            print("progressValue\(progressValue)")
            print(String(data: data, encoding: .utf8)!)

            do {
                let res = try JSONDecoder().decode(PostRes.self, from: data)
                if res.status == true {
                    completionHandler(true, "")
                } else {
                    completionHandler(false, error?.localizedDescription)
                }
            } catch {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }

    
}

struct UploadRes: Codable {
    let status: Bool?
    let music: String
    let data: [Datum]
}

struct Datum: Codable {
    let name, size: String?
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
            print("upload response: \(resposne)")
        } else {
            print("ther error")
        }
        
    }.resume()
    
    
    
    
}
