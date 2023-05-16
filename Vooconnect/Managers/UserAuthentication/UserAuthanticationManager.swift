//
//  UserAuthanticationManager.swift
//  LiveCheff
//
//  Created by Online Developer on 05/12/2022.
//

import Foundation
import Swinject

protocol UserAuthenticationManager: AnyObject {

    //pass through binding
    var refreshDetailsCallBack:() -> ()? { get set }

    // Variables

    var userDetail: UserDetail? { get set }
    
    var jwt: String? { get set }
    var id: String? { get set }
    
    // Functions

    func setUserLoggedInWith(id: String, jwt: String)
    func refreshUserDetails(_ completion: (() -> Void)?)
    func logout()
    func removeJwt()
}

extension UserAuthenticationManager {
    func refreshUserDetails(_ completion: (() -> Void)? = nil) {
        refreshUserDetails(completion)
    }
}
