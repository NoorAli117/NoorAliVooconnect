//
//  GenderResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 12/11/22.
// http://192.168.168.214:7500/api/v1/health

import Foundation

class GenderResource {
    
    func hittingGenderApi(genderRequest: GenderRequest, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.genderUpdate)!)
                
        urlRequest.httpMethod = "post"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(genderRequest)
        
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            print("Access Token============",tokenData)
        }
        
       
        
        print("URLREQUEST===========",urlRequest)
        
        
        HttpUtility.shared.postApiData(request: urlRequest) { result in
            
            switch result  {
            case .success(let response) :
                
                do {
                    let data : [String:Any] = try JSONSerialization.jsonObject(with: response, options: .mutableContainers) as! [String : Any]
                    
                    debugPrint("The LOGIN Response", data)
                    
                    if data["status"] as! Int == 1 {
                        // Sussess
                        print("Susses===========")

//                       if let records = data["data"] as? [String: Any] {
//
//                           let uuid = records["uuid"] as? String
//                           UserDefaults.standard.set(uuid, forKey: "uuid")
//                           print("THE UUID is======", uuid ?? "not save")
//                        }


                        complitionHandler(true, "Susses")

                    } else {
                        print("Failed===========")
                        complitionHandler(false, "Failed")
                    }

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
