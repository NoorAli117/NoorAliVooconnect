//
//  FillYourProfileResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 19/11/22.
//

import Foundation

class FillYourProfileResource {
    
    func hittingUpdateProfile(profileDetailsRequest: ProfileDetailsRequest, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.uploadProfileData)!)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = try? JSONEncoder().encode(profileDetailsRequest)
        
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
                    debugPrint("The LOGIN Response", data)
                    
                    if data["status"] as! Int == 1 {
                        // Sussess
                        print("Susses===========")
                        
                        complitionHandler(true, "Susses")
                        
                    } else {
                        print("Failed===========")
//                        complitionHandler(false, "Failed")
                        
                        do {
                            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                            do {
                                let model = try JSONDecoder().decode(SignUpFaile.self, from: data)
                                print("The success decoded model", model.errors?[0].msg ?? "")
//                                complitionHandler(false, model.errors.)
                                
                                complitionHandler(false, model.errors?[0].msg ?? "")
                                
                            } catch {
                                print("the decoded error", error.localizedDescription)
                            }
                        } catch {
                            print("the data decoded error", error.localizedDescription)
                        }
                        
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
