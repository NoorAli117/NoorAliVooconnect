//
//  LogInResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 15/11/22.
//

import Foundation
import Swinject

class LogInResource {
    
    private var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    
    func hittingLogInApi(signupRequest: SignUpRequest, complitionHandler : @escaping(Bool, String?, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.logInWithEmail)!)
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
                           
                           let accessToken = records["accessToken"] as? String
                           UserDefaults.standard.set(accessToken, forKey: "accessToken")
                           print("THE accessToken is======", accessToken ?? "not save")
                           
                           self.userAuthanticationManager.setUserLoggedInWith(id: uuid ?? "", jwt: accessToken ?? "")
                           
                        }
                        
                        do {
                            let decodData = try JSONDecoder().decode(LogInSuccesDataModel.self, from: response)
                            
                            if decodData.data?.birthdate == nil {
                                complitionHandler(true, decodData.message, nil)
                            } else {
                                complitionHandler(true, "Login successfull.", "Login successfull.")
                            }
                            
                        } catch {
                            debugPrint("The Error", error.localizedDescription)
                        }
                                                
                    } else {
                        print("Failed===========")
//                        complitionHandler(false, "Failed")
                        
                        if let records = data["data"] as? [String: Any] {
                            
                            let uuid = records["uuid"] as? String
                            UserDefaults.standard.set(uuid, forKey: "uuid")
                            print("THE UUID is======", uuid ?? "not save")
                            
                        }
                        
                        do {
                            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                            do {
                                let model = try JSONDecoder().decode(SignUpFaile.self, from: data)
                                print("The success decoded model", model.errors?[0].msg ?? "")
                                
                                complitionHandler(false, model.errors?[0].msg ?? "", nil)
                                
                            } catch {
                                print("the decoded error", error.localizedDescription)
                            }
                        } catch {
                            print("the data decoded error", error.localizedDescription)
                        }
                    }

                } catch {
//                    complitionHandler(false, nil, nil)
                    print("sakdjfhiuldasfhiuearf")
                }
                
            case .failure(let error) :
                debugPrint("The Error =====", error.localizedDescription)
            }
        }
        
    }
    
    func hittingLogInWithPhone(logInRequest: SignUpRequestPhone, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.logInWithPhone)!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(logInRequest)
        
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
                        
                        if let records = data["data"] as? [String: Any] {
                            
                            let uuid = records["uuid"] as? String
                            UserDefaults.standard.set(uuid, forKey: "uuid")
                            print("THE UUID is======", uuid ?? "not save")
                            
                        }
                        
                        do {
                            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                            do {
                                let model = try JSONDecoder().decode(SignUpFaile.self, from: data)
                                print("The success decoded model", model.errors?[0].msg ?? "")
                                
                                complitionHandler(false, model.errors?[0].msg ?? "")
                                
                            } catch {
                                print("the decoded error", error.localizedDescription)
                            }
                        } catch {
                            print("the data decoded error", error.localizedDescription)
                        }
                        
                        do {
                            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                            do {
                                let model = try JSONDecoder().decode(LogInPhoneError.self, from: data)
                                print("The success decoded model", model.message ?? "")
                                
                                complitionHandler(false, model.message ?? "")
                                
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
    
    func hittingForgotPassword(forGotPasswordRequest: ForgotPasswordRequest, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.forgotPassword)!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(forGotPasswordRequest)
        
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
                        
                        do {
                            let decodData = try JSONDecoder().decode(ForgotPasswordSuccessDetail.self, from: response)
                            if let records = data["data"] as? [String: Any] {
                                let email = records["email"] as? String
                                UserDefaults.standard.set(email, forKey: "email")
                                print("THE Email is======", email ?? "not save")
                               
                             }
                            
                            if let records = data["data"] as? [String: Any] {
                                let phone = records["phone"] as? String
                                UserDefaults.standard.set(phone, forKey: "phone")
                                print("THE Phone is======", phone ?? "not save")
                               
                             }
                            
                        } catch {
                            debugPrint("The Error", error.localizedDescription)
                        }
                        
                        complitionHandler(true, "decodData.message")
                                                                        
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
