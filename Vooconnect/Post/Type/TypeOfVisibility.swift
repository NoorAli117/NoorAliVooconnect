//
//  TypeOfVisibility.swift
//  Vooconnect
//
//  Created by JV on 1/03/23.
//

import Foundation
enum TypeOfVisibility : String, Codable{
    case everyone
    case friends
    case onlyMe
    case premiumFollowers
    
    var description : String {
        switch self {
            case .everyone: return "Everyone"
            case .friends: return "Friends"
            case .onlyMe: return "Only Me"
            case .premiumFollowers: return "Premium Followers"
        }
    }
}
