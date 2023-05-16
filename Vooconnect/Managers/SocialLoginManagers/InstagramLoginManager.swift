//
//  InstagramLoginManager.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 04/04/2023.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

class InstagramLoginManager{
    
    static let shared = InstagramLoginManager()
    
    let loginManager = LoginManager()
    
    func login(){
        loginManager.logIn(permissions: ["instagram_basic"], from: nil) { result, error  in
            guard error == nil else {
                logger.info("LoginWithFacebook ERROR: \(error?.localizedDescription ?? "")", category: .network)
//                onComplete(false, error?.localizedDescription ?? "")
                return
            }
            
            guard let result = result, !result.isCancelled else {
                logger.info("User cancelled login", category: .lifecycle)
//                onComplete(false, "User cancelled login")
                return
            }
            
            print(result)
            
            Profile.loadCurrentProfile { (profile, error) in
//                onComplete(true, error?.localizedDescription ?? "")
                print("Got It!")
            }
        }
    }

}
