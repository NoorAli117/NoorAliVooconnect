//
//  FacebookLoginManager.swift
//  Vooconnect
//
//  Created by Online Developer on 03/04/2023.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookLoginManager{
    static let shared = FacebookLoginManager()
    
    let loginManager = LoginManager()
    
    func login(onComplete: ((String, String, String?)->())? = nil){
 
        loginManager.logIn(permissions: ["public_profile"], from: nil) { (result, error) in

            guard error == nil else {
                logger.info("LoginWithFacebook ERROR: \(error?.localizedDescription ?? "")", category: .network)
                onComplete?("", "", error?.localizedDescription)
                return
            }
            
            
            guard let result = result, !result.isCancelled else {
                logger.info("User cancelled login", category: .lifecycle)
                return
            }

            Profile.loadCurrentProfile { (profile, error) in
                onComplete?(profile?.name ?? "", profile?.userID ?? "", nil)
            }
        }
    }
    
    func logout(){
        loginManager.logOut()
    }
}
