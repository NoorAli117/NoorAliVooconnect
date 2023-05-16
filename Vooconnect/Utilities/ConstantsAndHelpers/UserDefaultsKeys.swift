//
//  UserDefaultsKeys.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import Foundation

struct UserDefaultsKeys{
    static let userAuthorizationState = "user-authorization-state"
    
    static func clearUserDefaults(){
        UserDefaults.standard.removeObject(forKey: userAuthorizationState)
    }
}
