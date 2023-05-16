//
//  SwitchAccountViewModel.swift
//  Vooconnect
//
//  Created by Online Developer on 01/04/2023.
//

import Foundation

class SwitchAccountViewModel: ObservableObject{
    @Published var userProfiles: [UserProfileItem] = []
    
    init(){
        getUserProfiles()
    }
    
    /// Get User Profiles from CoreData
    func getUserProfiles(){
        DataPersistenceManager.shared.getUserProfiles { [weak self] result in
            switch result {
            case .success(let profiles):
                self?.userProfiles = profiles
            case .failure(let error):
                logger.error("Error Getting Profiles: \(error.localizedDescription)", category: .coreData)
            }
        }
    }
}
