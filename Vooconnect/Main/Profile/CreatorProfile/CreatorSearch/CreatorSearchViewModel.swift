//
//  CreatorSearchViewModel.swift
//  Vooconnect
//
//  Created by Online Developer on 27/03/2023.
//

import Foundation
import Combine
import SwiftUI

class CreatorSearchViewModel: ObservableObject{
    
    @Published var followers: [UserDetail] = []
    @Published var followings: [UserDetail] = []
    @Published var suggestedUsers: [UserDetail] = []
    
    /// Searched Users
    @Published var searchedUsers: [UserDetail] = []
    /// Selected Search Pager Type
    @Published var selectedSearchPagerType: SearchPagerType = .followers
    /// Search String
    @Published var searchQuery = ""
    
    private var disposeBag = Set<AnyCancellable>()
    
    init(uuid: String){
        getFollowers(uuid: uuid)
        getFollowing(uuid: uuid)
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
            switch selectedSearchPagerType {
            case .followers:
                if query.isEmpty{
                    self.searchedUsers = self.followers
                }else{
                    self.searchedUsers = self.followers.filter{ $0.username?.contains(query) ?? false }
                }
            case .following:
                if query.isEmpty{
                    self.searchedUsers = self.followings
                }else{
                    self.searchedUsers = self.followings.filter{ $0.username?.contains(query) ?? false }
                }
            case .suggested:
                if query.isEmpty{
                    self.searchedUsers = self.suggestedUsers
                }else{
                    self.searchedUsers = self.suggestedUsers.filter{ $0.username?.contains(query) ?? false }
                }
            }
        }
    }
    
    /// Get Followers
    /// - Parameter uuid: user id
    func getFollowers(uuid: String){
        let params: [String: Any] = [
            "user_uuid": uuid
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .getFollowers, withDataType: GetUsersModel.self, parameters: params) { [weak self] result in
            switch result {
            case .success(let model):
                logger.info("Successfully got follwers.", category: .profile)
                guard let users = model.users, users.count > 0 else { return }
                self?.followers = users
                self?.searchedUsers = users
            case .failure(let error):
                logger.info("Error getting followers: \(error.localizedDescription)", category: .profile)
            }
        }
    }
    
    /// Get Following
    /// - Parameter uuid: user id
    func getFollowing(uuid: String){
        let params: [String: Any] = [
            "user_uuid": uuid
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .getFollowing, withDataType: GetUsersModel.self, parameters: params) { [weak self] result in
            switch result {
            case .success(let model):
                logger.info("Successfully got followings.", category: .profile)
                guard let users = model.users, users.count > 0 else { return }
                self?.followings = users
            case .failure(let error):
                logger.info("Error getting following: \(error.localizedDescription)", category: .profile)
            }
        }
    }
    
    /// Get Suggested Users
    /// - Parameters:
    ///   - latitude: latitude
    ///   - longitude: longitude
    func getSuggested(latitude: Double?, longitude: Double?){
        guard let latitude, let longitude else { return }
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
            case .failure(let error):
                logger.info("Error getting suggested users.: \(error.localizedDescription)", category: .profile)
            }
        }
    }
}
