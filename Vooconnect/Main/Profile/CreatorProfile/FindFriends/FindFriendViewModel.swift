//
//  FindFriendViewModel.swift
//  Vooconnect
//
//  Created by Online Developer on 27/03/2023.
//

import Foundation
import Swinject
import Combine
import SwiftUI

class FindFriendViewModel: ObservableObject{
    
    private var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    
    /// Suggested Users
    @Published var suggestedUsers: [UserDetail] = []
    /// Searched Suggested Users
    @Published var searchSuggestedUsers: [UserDetail] = []
    /// Share Profile
    @Published var shareProfile = false
    /// Search String
    @Published var searchQuery = ""
    
    private var disposeBag = Set<AnyCancellable>()
    
    init(){
        getSuggested()
        debounceTextChanges()
    }
    
    /// Debouncing the Search Text Changings
    func debounceTextChanges() {
        $searchQuery
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink {
                self.searchUsers(query: $0)
            }
            .store(in: &disposeBag)
    }
    
    /// Serach Users
    /// - Parameter query: query string
    func searchUsers(query: String){
        withAnimation{
            if query.isEmpty{
                self.searchSuggestedUsers = self.suggestedUsers
            }else{
                self.searchSuggestedUsers = self.suggestedUsers.filter{ $0.username?.contains(query) ?? false }
            }
        }
    }
    
    /// Get Current User's Suggested Users
    func getSuggested(){
        let userDetail = userAuthanticationManager.userDetail
        guard let latitude = userDetail?.lat, let longitude = userDetail?.lon else { return }
        let params: [String: Any] = [
            "lat": latitude,
            "lon": longitude
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .getSuggestedUsers, withDataType: GetUsersModel.self, parameters: params) { [weak self] result in
            switch result {
            case .success(let model):
                logger.info("Successfully got suggested users.", category: .profile)
                guard let users = model.users, users.count > 0 else { return }
                self?.suggestedUsers = users
                self?.searchSuggestedUsers = users
            case .failure(let error):
                logger.info("Error getting suggested users.: \(error.localizedDescription)", category: .profile)
            }
        }
    }
}
