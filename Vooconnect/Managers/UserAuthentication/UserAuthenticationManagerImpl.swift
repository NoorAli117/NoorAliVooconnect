//
//  UserAuthenticationManagerImpl.swift
//  LiveCheff
//
//  Created by Online Developer on 05/12/2022.
//

import Swinject
import UIKit

class UserAuthenticationManagerFactory {

    static func register(with container: Container) {
        let threadSafeResolver = container.synchronize()
        container.register(UserAuthenticationManager.self) { _ in
            logger.debug("Creating user authentication manager...", category: .userContext)
            return UserAuthenticationManagerImpl(with: threadSafeResolver)
        }
        .initCompleted { resolver, initialUserAuthenticationManager in
            // Set up dependencies like Push Notifications
        }
        .inObjectScope(.container)
    }
    
}

private final class UserAuthenticationManagerImpl: UserAuthenticationManager {
    private var appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!
    var refreshDetailsCallBack: () -> ()?
        
    // MARK: - Lifecycle

    init(with resolver: Resolver) {

        logger.debug("Constructing UserAuthenticationManager...", category: .lifecycle)
        
        self.refreshDetailsCallBack = { }
        if let jwt = jwt {
            if jwt != "" {
                refreshUserDetails()
            } else {
                logout()
            }
        }
    }

    deinit {
        logger.debug("~UserAuthenticationManager.", category: .lifecycle)
    }

    // MARK: - Variables
    
    var userDetail: UserDetail?

    var jwt: String? {
        set {
            modelQueue.sync {
                networkAuthenticationModel.jwt = newValue
            }
        }
        get {
            modelQueue.sync {
                networkAuthenticationModel.jwt
            }
        }
    }
    
    var id: String? {
        set {
            modelQueue.sync {
                networkAuthenticationModel.id = newValue
            }
        }
        get {
            modelQueue.sync {
                networkAuthenticationModel.id
            }
        }
    }
    
    // MARK: - Functions

    func setUserLoggedInWith(id: String, jwt: String) {

        modelQueue.sync {
        
            // set the JWT to the NetAuthModel
            networkAuthenticationModel.jwt = jwt
            networkAuthenticationModel.id = id

            if jwt != ""{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.refreshUserDetails()
                }
            }
            
        }
    }

    func logout() {
        completeLogout()
    }

    func removeJwt() {
        modelQueue.sync {
            networkAuthenticationModel.jwt = "" // nil
            networkAuthenticationModel.refreshJwt = "" // nil
        }
    }

    // MARK: - Private

    private var networkAuthenticationModel = Container.default.resolver.resolve(NetworkAuthenticationModel.self)!

    private let modelQueue = DispatchQueue(
        label: "\(NetworkConstants.ProductDefinition.domain).userAuthenticationManager",
        qos: .utility
    )

    fileprivate func refreshUserDetails(_ completion: (() -> Void)? = nil) {
        // Load user detail
        let params: [String: Any] = [
            "user_uuid": id ?? ""
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .userDetail, withDataType: UserModel.self, parameters: params) { [weak self] result in
            switch result {
            case .success(let userModel):
                self?.userDetail = userModel.user
                self?.appEventsManager.updateProfileImage.send(true)
                logger.error("Successfully fetched user detail!!!", category: .lifecycle)
                guard let userDetail = self?.userDetail, let id = self?.id, let jwt = self?.jwt else { return }
                DataPersistenceManager.shared.updateProfile(model: userDetail, uuid: id, jwt: jwt)
            case .failure(let error):
                logger.error("Error Fetching User Detail: \(error.localizedDescription)", category: .network)
            }
            completion?()
        }
    }

    private func completeLogout() {
        // Logout Request will be here
        
        removeJwt()
        setUserLoggedInWith(id: "", jwt: "")
        UserDefaultsKeys.clearUserDefaults()
        DataPersistenceManager.shared.deleteAllProfiles()
    }
}
