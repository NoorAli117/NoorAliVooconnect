//
//  OTPResourceForgotPass.swift
//  Vooconnect
//
//  Created by Vooconnect on 18/11/22.
//

import Foundation

class OTPResourceForgotPass {
    
    func hittingForgotPassOTPApi(sendOTPRequest: SendOTPRequest, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.sendOTPtoMail)!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(sendOTPRequest)
        
        
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
    
    
    func hittingCreateNewPasswordApi(createNewPasswordRequest: CreateNewPasswordRequest, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.createNewPassword)!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(createNewPasswordRequest)
        
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
