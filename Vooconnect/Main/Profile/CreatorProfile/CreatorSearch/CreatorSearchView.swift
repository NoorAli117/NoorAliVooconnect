//
//  CreatorSearchView.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI

struct CreatorSearchView: View {
    
    @StateObject var creatorSearchViewModel: CreatorSearchViewModel
    var username: String
    var latitude: Double?
    var longitude: Double?
    
    public init(
        id: String,
        userName: String,
        latitude: Double?,
        longitude: Double?
    ) {
        _creatorSearchViewModel = StateObject(
            wrappedValue: CreatorSearchViewModel(uuid: id)
        )
        self.username = userName
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var body: some View {
        VStack{
            CreatorSearchNavBarView(text: $creatorSearchViewModel.searchQuery, username: username)
            CreatorSearchPager(creatorSearchViewModel: creatorSearchViewModel)
                .padding(.top, 20)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 24){
                    switch creatorSearchViewModel.selectedSearchPagerType {
                    case .followers:
                        if creatorSearchViewModel.searchedUsers.count > 0{
                            ForEach(creatorSearchViewModel.searchedUsers, id:\.self) { user in
                                CreatorSearchCell(selectedSearchPagerType: $creatorSearchViewModel.selectedSearchPagerType, user: user, onSwitched: ({ user in
                                    onSwitchedUserStatus(user: user)
                                }))
                            }
                        }else{
                            Text("No Follower")
                        }
                    case .following:
                        if creatorSearchViewModel.searchedUsers.count > 0{
                            ForEach(creatorSearchViewModel.searchedUsers, id:\.self) { user in
                                CreatorSearchCell(selectedSearchPagerType: $creatorSearchViewModel.selectedSearchPagerType, user: user, onSwitched: ({ user in
                                    onSwitchedUserStatus(user: user)
                                }))
                            }
                        }else{
                            Text("No Following")
                        }
                    case .suggested:
                        if creatorSearchViewModel.searchedUsers.count > 0{
                            ForEach(creatorSearchViewModel.searchedUsers, id:\.self) { user in
                                CreatorSearchCell(selectedSearchPagerType: $creatorSearchViewModel.selectedSearchPagerType, user: user) { removedUser in
                                    creatorSearchViewModel.suggestedUsers = creatorSearchViewModel.suggestedUsers.filter{ $0.uuid != removedUser.uuid }
                                    creatorSearchViewModel.searchUsers(query: creatorSearchViewModel.searchQuery)
                                } onSwitched: { switchedUser in
                                    onSwitchedUserStatus(user: switchedUser)
                                }
                            }
                        }else{
                            Text("No Suggested Users")
                        }
                    }
                }
                .padding(.top, 20)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarHidden(true)
        .onAppear{
            creatorSearchViewModel.getSuggested(latitude: latitude, longitude: longitude)
        }
    }
    
    func onSwitchedUserStatus(user: UserDetail){
        switch creatorSearchViewModel.selectedSearchPagerType{
        case .followers:
            let index = creatorSearchViewModel.followers.firstIndex { $0.uuid == user.uuid }
            if let index{
                creatorSearchViewModel.followers[index].isSwitched.toggle()
            }
        case .following:
            let index = creatorSearchViewModel.followings.firstIndex { $0.uuid == user.uuid }
            if let index{
                creatorSearchViewModel.followings[index].isSwitched.toggle()
            }
        case .suggested:
            let index = creatorSearchViewModel.suggestedUsers.firstIndex { $0.uuid == user.uuid }
            if let index{
                creatorSearchViewModel.suggestedUsers[index].isSwitched.toggle()
            }
        }
        creatorSearchViewModel.searchUsers(query: creatorSearchViewModel.searchQuery)
    }
}
