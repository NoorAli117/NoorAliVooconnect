//
//  FindFriendsView.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI
import Swinject

struct FindFriendsView: View {
    private var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!

    @StateObject var findFriendViewModel = FindFriendViewModel()
    @State var selectedSearchPagerType: SearchPagerType = .suggested
    
    var body: some View {
        VStack(spacing: 0){
            FindFirendsNavBar()
                .padding(.horizontal, 24)
            
            FindFriendsSearchBar(text: $findFriendViewModel.searchQuery)
                .padding(.horizontal, 24)
                .padding(.top, 20)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 20){
                    if findFriendViewModel.searchQuery.isEmpty{
                        ForEach(FriendsType.allCases, id:\.self){ type in
                            InviteRowView(type: type, findFriendsViewModel: findFriendViewModel)
                        }
                    }
                    
                    if findFriendViewModel.searchSuggestedUsers.count > 0{
                        Text("Suggested Accounts")
                            .font(.urbanist(name: .urbanistBold, size: 20))
                        
                        ForEach(findFriendViewModel.searchSuggestedUsers, id: \.self){ user in
                            CreatorSearchCell(selectedSearchPagerType: $selectedSearchPagerType, user: user) { removedUser in
                                findFriendViewModel.suggestedUsers = findFriendViewModel.suggestedUsers.filter{ $0.uuid != removedUser.uuid }
                                findFriendViewModel.searchUsers(query: findFriendViewModel.searchQuery)
                            } onSwitched: { switchedUser in
                                onSwitchedUserStatus(user: switchedUser)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .navigationBarHidden(true)
                .sheet(isPresented: $findFriendViewModel.shareProfile) {
                    ShareSheet(
                        activityItems: [
                            ShareItemURLSource(
                                title: "Hi, I'm on Vooconnect",
                                desc: "Hey its \(userAuthanticationManager.userDetail?.username ?? "") on Vooconnect follow me and watch my videos on the app.",
                                url: URL(string: "https://vooconnect/\(userAuthanticationManager.userDetail?.username ?? "")")!
                            ),
                            URL(
                                string: "https://vooconnect/\(userAuthanticationManager.userDetail?.username ?? "")"
                            )!
                        ]
                    )
                }
            }
        }
    }
    
    func onSwitchedUserStatus(user: UserDetail){
        let index = findFriendViewModel.suggestedUsers.firstIndex { $0.uuid == user.uuid }
        if let index{
            findFriendViewModel.suggestedUsers[index].isSwitched.toggle()
        }
        findFriendViewModel.searchUsers(query: findFriendViewModel.searchQuery)
    }
}
