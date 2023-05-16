//
//  TwitterLoginManager.swift
//  Vooconnect
//
//  Created by Online Developer on 04/04/2023.
//

import Foundation
import TwitterKit
import WebKit
import SwiftUI

class TwitterLoginManager{
    static let shared = TwitterLoginManager()
    
    /// Login with Twitter
    func login(onComplete: @escaping ((String?, String?)->())){
        TWTRTwitter.sharedInstance().logIn() { (session, error) in
            if let session = session {
                onComplete(session.userName, nil)
            } else {
                logger.error("Error logging in: \(error?.localizedDescription ?? "Unknown error")", category: .profile)
                onComplete(nil, error?.localizedDescription ?? "Unknown Error")
            }
        }
    }
}
