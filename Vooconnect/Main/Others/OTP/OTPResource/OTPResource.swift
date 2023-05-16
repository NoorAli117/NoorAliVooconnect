//
//  OTPResource.swift
//  Vooconnect
//
//  Created by Vooconnect on 11/11/22.
//  "http://192.168.168.214:7500/api/v1/update-gender"

import Foundation
import Swinject

class OTPResource {
    
    private var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    
    func hittingOTPApi(signupRequest: OTPRequest, complitionHandler : @escaping(Bool, String?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: baseURL + EndPoints.otp)!)
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
                        
                        do {
                            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                            do {
                                let model = try JSONDecoder().decode(ProfileDataResponse.self, from: data)
                                print("The success decoded model", model.data?.email ?? "")
//                                complitionHandler(false, model.errors.)
                                
//                                complitionHandler(false, model.errors?[0].msg ?? "")
                                
                                
                                let email = model.data?.email ?? ""
                                UserDefaults.standard.set(email, forKey: "userEmail")
                                let userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
                                print("THE User Email======", userEmail)
                                
                                let phone = model.data?.phone ?? ""
                                UserDefaults.standard.set(phone, forKey: "userPhone")
                                let userPhone = UserDefaults.standard.string(forKey: "userPhone") ?? ""
                                print("THE User Phone======", userPhone)
                                
                                
                            } catch {
                                print("the decoded error", error.localizedDescription)
                            }
                        } catch {
                            print("the data decoded error", error.localizedDescription)
                        }
                        
                        

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
                                 complitionHandler(false, decodData.message)
                             } else {
                                complitionHandler(true, decodData.message)
                             }
                             
                         } catch {
                             debugPrint("The Error", error.localizedDescription)
                         }

                    } else {
                        
                        do {
                            let decodData = try JSONDecoder().decode(OTPInvalid.self, from: response)
                            
                            if decodData.message != nil {
                                complitionHandler(false, "Invalid OTP.")
                                // "Invalid OTP."
                            } else {
                                complitionHandler(false, "Please enter your otp.")
                            }
                            
                        }
                        
                        print("Failed===========")
//                        complitionHandler(false, "Failed")
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


// EMAIL

//"The LOGIN Response" ["data": {
//    accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNGI3ZWI0ZTgtOGU3ZS00MThmLTkxNmUtY2MzZTQ1YjY5NzQ2IiwiaWF0IjoxNjY4NDkzODUyLCJleHAiOjE2Njg1MzcwNTJ9.sOmEZnknhoArX85hReE-2uA3xrZ9xsneA7yyhGSKZFc";
//    birthdate = "<null>";
//    email = "Bdhdbdj@gmail.com";
//    "email_verified_at" = "<null>";
//    "first_name" = "<null>";
//    gender = "<null>";
//    "last_name" = "<null>";
//    "middle_name" = "<null>";
//    phone = "<null>";
//    "phone_verified_at" = "<null>";
//    "profile_image" = "<null>";
//    refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNGI3ZWI0ZTgtOGU3ZS00MThmLTkxNmUtY2MzZTQ1YjY5NzQ2IiwiaWF0IjoxNjY4NDkzODUyLCJleHAiOjE2Njg1MzcwNTJ9.sOmEZnknhoArX85hReE-2uA3xrZ9xsneA7yyhGSKZFc";
//    username = "<null>";
//    uuid = "4b7eb4e8-8e7e-418f-916e-cc3e45b69746";
//}, "message": Email verified., "status": 1]



// PHONE

//"The LOGIN Response" ["data": {
//    accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZjcxNWU4OWMtMWFiZS00NzIyLWE3NGYtMTkxOWQyYTA0ZGFlIiwiaWF0IjoxNjY4NDkzOTM5LCJleHAiOjE2Njg1MzcxMzl9.ZCyFJ91NMokenmyJzWdDTb5ubxG3xMsZpAxAII61dAM";
//    birthdate = "<null>";
//    email = "<null>";
//    "email_verified_at" = "<null>";
//    "first_name" = "<null>";
//    gender = "<null>";
//    "last_name" = "<null>";
//    "middle_name" = "<null>";
//    phone = "+918174828764";
//    "phone_verified_at" = "<null>";
//    "profile_image" = "<null>";
//    refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZjcxNWU4OWMtMWFiZS00NzIyLWE3NGYtMTkxOWQyYTA0ZGFlIiwiaWF0IjoxNjY4NDkzOTM5LCJleHAiOjE2Njg1MzcxMzl9.ZCyFJ91NMokenmyJzWdDTb5ubxG3xMsZpAxAII61dAM";
//    username = "<null>";
//    uuid = "f715e89c-1abe-4722-a74f-1919d2a04dae";
//}, "message": Email verified., "status": 1]
