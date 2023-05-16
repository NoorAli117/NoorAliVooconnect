//
//  SignUpResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 11/11/22.
//

import Foundation

class SignUpResource {
    
    func hittingSignupApi(signupRequest: SignUpRequest, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.signUpWithEmail)!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(signupRequest)
        
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
                        
                       if let records = data["data"] as? [String: Any] {
                            
                           let uuid = records["uuid"] as? String
                           UserDefaults.standard.set(uuid, forKey: "uuid")
                           print("THE UUID is======", uuid ?? "not save")
                        }
                        
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
    
    func hittingSignUpPhoneApi(signupRequest: SignUpRequestPhone, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.signUpWithPhone)!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(signupRequest)
        
        HttpUtility.shared.postApiData(request: urlRequest) { result in
            
            switch result  {
            case .success(let response) :
                
                do {
                    let data : [String:Any] = try JSONSerialization.jsonObject(with: response, options: .mutableContainers) as! [String : Any]
                    debugPrint("The LOGIN Response", data)
                    
                    if data["status"] as! Int == 1 {
                        // Sussess
                        print("Susses===========")
                        
                       if let records = data["data"] as? [String: Any] {
                           let uuid = records["uuid"] as? String
                           UserDefaults.standard.set(uuid, forKey: "uuid")
                           print("THE UUID is======", uuid ?? "not save")
                        }
                        
                        complitionHandler(true, "Susses")
                        
                    } else {
                        print("Failed===========")
                        
//                        if let error = data["errors"] as? [String: Any] {
//                            let msg = error["msg"] as? String
//                            print("Error Massage=====", msg ?? "")  SignUpFaile
//                            complitionHandler(false, msg)  SignUpErrors
//                        }
                                                
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


//"The LOGIN Response" ["message": OTP sent., "data": {
//    uuid = "315197f7-8733-4af3-975a-7009ae100562";
//}, "status": 1]


//"The LOGIN Response" ["errors": <__NSArrayM 0x2822122e0>(
//{
//    location = body;
//    msg = "Email is already taken.";
//    param = email;
//    value = "S@gmail.com";
//}
//)
//, "status": 0]
