//
//  ProfileViewersViewModel.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 26/04/2023.
//

import SwiftUI

class ProfileViewersViewModel: ObservableObject{
    /// Recent profile viewers
    @Published var profileViewers: [UserDetail] = []
    
    init(){
        getProfileViewers()
    }
    
    /// Get Profile Viewers
    func getProfileViewers(){
        NetworkManager.makeEndpointCall(fromEndpoint: .getProfileViewers, withDataType: GetUsersModel.self) { [weak self] result in
            switch result {
            case .success(let model):
                logger.info("Successfully got recent viewers.", category: .profile)
                guard let users = model.users, users.count > 0 else { return }
                self?.profileViewers = users
            case .failure(let error):
                logger.info("Error getting recent viewers: \(error.localizedDescription)", category: .profile)
            }
        }
    }
}
