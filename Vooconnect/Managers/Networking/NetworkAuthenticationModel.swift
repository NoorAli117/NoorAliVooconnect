//
//  NetworkAuthenticationModel.swift
//  LiveCheff
//
//  Created by Online Developer on 02/09/2022.
//

import Foundation
import KeychainAccess

/// This is a model to capture the auth data that comes from a valid code
struct AuthenticationModel: Decodable, Hashable {
    let jwt: String
    let refreshJwt: String
    let id: String
}

/// This is a stand alone model for refresh token response
struct RefreshAuthenticationModel: Decodable, Hashable {
    let jwt: String
    let refreshJwt: String?
}

/// Model that holds tokens for the current logged in user. This may need to be added to a 'userAuthManager' soon, but will be a shared singleton for now
public final class NetworkAuthenticationModel {
    
    init() { }
    
    var jwt: String? {
        get {
            retrieveValue(from: NetworkConstants.AuthenticationKeys.jwtKey.rawValue)
        }
        set {
            if let value = newValue {
                storeValue(for: NetworkConstants.AuthenticationKeys.jwtKey.rawValue, with: value)
            } else {
                storeValue(for: NetworkConstants.AuthenticationKeys.jwtKey.rawValue, with: "")
            }
        }
    }

    var refreshJwt: String? {
        get {
            retrieveValue(from: NetworkConstants.AuthenticationKeys.refreshJwtKey.rawValue)
        }
        set {
            if let value = newValue {
                storeValue(for: NetworkConstants.AuthenticationKeys.refreshJwtKey.rawValue, with: value)
            } else {
                storeValue(for: NetworkConstants.AuthenticationKeys.refreshJwtKey.rawValue, with: "")
            }
        }
    }
    
    var id: String? {
        get {
            retrieveValue(from: NetworkConstants.AuthenticationKeys.id.rawValue)
        }
        set {
            if let value = newValue {
                storeValue(for: NetworkConstants.AuthenticationKeys.id.rawValue, with: value)
            } else {
                storeValue(for: NetworkConstants.AuthenticationKeys.id.rawValue, with: "")
            }
        }
    }
    
    /// Clear all of the stored auth data
    func logout() {
        self.jwt = ""
        self.refreshJwt = ""
        self.id = ""
        
        logger.debug("\nValues have been reset: jwt \(String(describing: self.jwt))\nrefreshJwt \(String(describing: self.refreshJwt))\nid \(String(describing: self.id))", category: .userContext)
    }
    
    // MARK: - Private
    
    /// Initial keychain object with device unlock settings
    private let keychain = Keychain(service: NetworkConstants.ProductDefinition.domain)
        .accessibility(.afterFirstUnlock)
    
    /// Store data in a key file with encryption
    private func storeValue(for key: String, with keyValue: String) {
        keychain[key] = keyValue
    }
    
    /// Retrieve value from key and un-encrypt.
    private func retrieveValue(from key: String) -> String {
        return keychain[key] ?? ""
    }
    
}
