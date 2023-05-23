//
//  UploadProfileImageResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/11/22.
//

import Foundation
import UIKit

class UploadProfileImageResource {
    func uploadImage( imageUploadRequest: Data,paramName : String, fileName : String, complitionHandler : @escaping(Bool, String?) -> Void)  {
            guard let url = URL(string: assatEndPoint + EndPoints.uploadFile) else {
                // Handle the error if the URL is invalid
                return
            }
//            let image = image
            let boundary = UUID().uuidString

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

//            let imageData = image.jpegData(compressionQuality: 1.0)!
            let body = NSMutableData()

            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"attachment\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageUploadRequest)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)

            request.httpBody = body as Data
            if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
                request.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
                print("ACCESS TOKEN=========", tokenData)
            }
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    // Handle the error if the request failed
                    print(error.localizedDescription)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    // Handle the response if the request succeeded
                    print("Upload success")
                    print(String(data: data!, encoding: .utf8)!)
                    complitionHandler(true,"Image Upload Success")
                } else {
                    // Handle the response if the request failed
                    print("Upload failed")
                    complitionHandler(false,"Faild to Upload Image")
                }
            }

            task.resume()
        }
    
//    func uploadImage(imageUploadRequest: Data,paramName : String, fileName : String, complitionHandler : @escaping(Bool, String?) -> Void) {
//        let session = URLSession.shared
//        let boundary = UUID().uuidString
//        var data = Data()
//
//        let parameters : [String:Any]?
//        parameters = ["upload_path" : "profile"]
//
//        if parameters != nil {
//            for (key, value) in parameters! {
//                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//                data.append("\(value)\r\n".data(using: .utf8)!)
////                data.append("\(value)".data(using: .utf8)!)
//            }
//        }
//
//        var urlRequest = URLRequest(url: URL(string: assatEndPoint + EndPoints.uploadFile)!)
//        urlRequest.httpMethod = "post"
//
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//        data.append(imageUploadRequest)
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//
//
//        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
//
//            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
//            urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
//
//            print("ACCESS TOKEN=========", tokenData)
//
//        }
//
//        session.uploadTask(with: urlRequest, from: data) { httpData, httpResponse, httpError in
//
//            if let data = httpData {
//
//                do {
//                    let data : [String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
//
//                    debugPrint("The Profile Response", data)
////                    complitionHandler(true, "")
//
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
////                                let uuid = UserDefaults.standard.string(forKey: "imageName") ?? ""
////                                print("THE UUID is======", uuid )
////                                complitionHandler(true, "")
////
////
////
//////                                complitionHandler(false, model.data?[0].name ?? "")
////
////
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
//
//                } catch {
//                    debugPrint("Error in decoding the model")
//                    complitionHandler(false, "Please login first")
//                }
//
//            } else if let resposne = httpResponse {
//
//            } else {
//                print("ther error")
//            }
//
//        }.resume()
//
//
//    }
    
}



//class UploadProfileImageResource {
//
//    func uploadImage(imageUploadRequest: UIImage,paramName : String, fileName : String, complitionHandler : @escaping(Bool, String?) -> Void) {
//        let session = URLSession.shared
//        let boundary = UUID().uuidString
//        var data = Data()
//
//        let parameters : [String:Any]?
//        parameters = ["upload_path" : "profile"]
//
//        if parameters != nil {
//            for (key, value) in parameters! {
//                data.append("--\(boundary)\r\n".data(using: .utf8)!)
//                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//                data.append("\(value)\r\n".data(using: .utf8)!)
//            }
//        }
//
//        var urlRequest = URLRequest(url: URL(string: assatEndPoint + EndPoints.uploadFile)!)
//        urlRequest.httpMethod = "post"
//
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//        data.append(imageUploadRequest.pngData()!)
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//
//
//        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
//
//            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
//            urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
//
//            print("ACCESS TOKEN=========", tokenData)
//
//        }
//
//        session.uploadTask(with: urlRequest, from: data) { httpData, httpResponse, httpError in
//
//            if let data = httpData {
//
//                do {
//                    let data : [String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
//
//                    debugPrint("The Profile Response", data)
////                    complitionHandler(true, "")
//
//                    if data["status"] as! Int == 1 {
//                        print("Susses===========")
//
//                        do {
//                            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//                            do {
//                                let model = try JSONDecoder().decode(uploadImageSuccess.self, from: data)
//                                print("The success Image Name==========", model.data?[0].name ?? "")
////                                complitionHandler(false, model.errors.)
//
//                                let name = model.data?[0].name ?? ""
//                                UserDefaults.standard.set(name, forKey: "imageName")
//                                let uuid = UserDefaults.standard.string(forKey: "imageName") ?? ""
//                                print("THE UUID is======", uuid )
//                                complitionHandler(true, "")
//
//
//
////                                complitionHandler(false, model.data?[0].name ?? "")
//
//
//
//                            } catch {
//                                print("the decoded error", error.localizedDescription)
//                            }
//                        } catch {
//                            print("the data decoded error", error.localizedDescription)
//                        }
//
//                    } else {
//                        print("Failed===========")
//                    }
//
//                } catch {
//                    debugPrint("Error in decoding the model")
//                    complitionHandler(false, "Please login first")
//                }
//
//            } else if let resposne = httpResponse {
//
//            } else {
//                print("ther error")
//            }
//
//        }.resume()
//
//
//    }
//
//}
