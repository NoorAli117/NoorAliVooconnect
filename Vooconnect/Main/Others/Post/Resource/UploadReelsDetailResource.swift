//
//  UploadReelsDetailResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 15/12/22.
//

import Foundation

class UploadReelsDetailResource {
    
    func uploadReelsDeatils(reelsPostRequest: ReelsPostRequest, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: getBaseURL + EndPoints.uploadReels)!)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = try? JSONEncoder().encode(reelsPostRequest)
        
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            print("Access Token============",tokenData)
        }
        
        HttpUtility.shared.postApiData(request: urlRequest) { result in
            
            switch result  {
            case .success(let response) :
                
                do {
                    let data : [String:Any] = try JSONSerialization.jsonObject(with: response, options: .mutableContainers) as! [String : Any]
                    debugPrint("The Reel Post Response", data)
                    
                    
                } catch {
                        complitionHandler(false, nil)
                        print("sakdjfhiuldasfhiuearf")
                    }
                    
                case .failure(let error) :
                    debugPrint("The Error =====", error.localizedDescription)
                }
            }
    }
    
}
