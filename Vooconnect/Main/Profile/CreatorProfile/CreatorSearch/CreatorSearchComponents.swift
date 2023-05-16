//
//  CreatorSearchComponents.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Swinject

enum SearchPagerType: String, CaseIterable{
    case followers = "Followers"
    case following = "Following"
    case suggested = "Suggested"
}

struct CreatorSearchNavBarView: View{
    @Binding var text: String
    let username: String
    @State var isSearch = false
    var body: some View{
        HStack {
            BackButton()
            
            if !isSearch{
                Text(username)
                    .font(.urbanist(name: .urbanistBold, size: 24))
                    .foregroundColor(Color.customBlack)
                    .padding(.leading, 10)
            }
            
            Spacer()
            
            if isSearch{
                ZStack{
                    VStack{
                        Spacer()
                        HStack(spacing: 12){
                            Image("SearchS")
                            TextField("Search", text: $text)
                        }
                        .padding(.horizontal, 20)
                        Spacer()
                    }
                }
                .background(Color.grayNine)
                .frame(height: 45)
                .cornerRadius(12)
            }
            
            Button {
                withAnimation{
                    isSearch.toggle()
                    text = ""
                }
            } label: {
                if !isSearch{
                    Image("SearchCP")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .clipped()
                }else{
                    Text("Cancel")
                        .font(.urbanist(name: .urbanistRegular))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct CreatorSearchPager: View{
    
    @ObservedObject var creatorSearchViewModel: CreatorSearchViewModel
    
    var body: some View{
        HStack(spacing: 0){
            PagerCellView(searchPagerType: .followers, isSelected: creatorSearchViewModel.selectedSearchPagerType == .followers){
                creatorSearchViewModel.selectedSearchPagerType = .followers
                creatorSearchViewModel.searchUsers(query: creatorSearchViewModel.searchQuery)
            }
            PagerCellView(searchPagerType: .following, isSelected: creatorSearchViewModel.selectedSearchPagerType == .following){
                creatorSearchViewModel.selectedSearchPagerType = .following
                creatorSearchViewModel.searchUsers(query: creatorSearchViewModel.searchQuery)
            }
            PagerCellView(searchPagerType: .suggested, isSelected: creatorSearchViewModel.selectedSearchPagerType == .suggested){
                creatorSearchViewModel.selectedSearchPagerType = .suggested
                creatorSearchViewModel.searchUsers(query: creatorSearchViewModel.searchQuery)
            }
        }
    }
    
    func PagerCellView(searchPagerType: SearchPagerType, isSelected: Bool, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack {
                Text(searchPagerType.rawValue)
                    .font(.urbanist(name: .urbanistBold, size: 18))
                    .foregroundStyle(isSelected ? Color.primaryGradient : Color.customGrayGradient)
                Capsule()
                    .fill(isSelected ? Color.primaryGradient : Color.grayThreeGradient)
                    .frame(height: isSelected ? 4 : 2)
            }
        }
    }
}

struct CreatorSearchCell: View {
    var generalManager = Container.default.resolver.resolve(GeneralManager.self)!
    @Binding var selectedSearchPagerType: SearchPagerType
    var user: UserDetail
    var onRemoveSuggested: ((UserDetail)->())? = nil
    var onSwitched: ((UserDetail)->())? = nil
    
    @State var navigateToProfile = false
    
        
    var body: some View {
        VStack {
            HStack(spacing: 0){
                if let url = getProfileImageUrl(){
                    WebImage(url: url)
                        .resizable()
                        .placeholder(Image("profileicon"))
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                }else{
                    Image("profileicon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Button{
                        navigateToProfile.toggle()
                    } label: {
                        Text(getUserName())
                            .font(.urbanist(name: .urbanistBold, size: 18))
                            .foregroundColor(Color.customBlack)
                    }
                    Text("\(user.username ?? "") | \(user.followerCount ?? 0) ")
                        .font(.urbanist(name: .urbanistMedium, size: 14))
                        .foregroundColor(Color.grayEight)
                        .lineLimit(1)
                }
                .padding(.leading, 20)
                
                Spacer()
                
                if selectedSearchPagerType == .followers{
                    if user.isSwitched{
                        FollowingButton{ withAnimation { followUnFollow() } }
                            .frame(width: 92, height: 32)
                    }else{
                        FollowButton{ withAnimation { followUnFollow() } }
                            .frame(width: 73, height: 32)
                    }
                }
                
                if selectedSearchPagerType == .following{
                    if user.isSwitched{
                        FollowButton{ withAnimation { followUnFollow() } }
                            .frame(width: 73, height: 32)
                    }else{
                        FollowingButton{ withAnimation { followUnFollow() } }
                            .frame(width: 92, height: 32)
                    }
                }
                
                if selectedSearchPagerType == .suggested{
                    if user.isSwitched{
                        FollowingButton{ withAnimation { followUnFollow() } }
                            .frame(width: 92, height: 32)
                    }else{
                        FollowButton{ withAnimation { followUnFollow() } }
                            .frame(width: 73, height: 32)
                    }
                    XMarkButton{
                        withAnimation {
                            onRemoveSuggested?(user)
                        }
                    }
                        .padding(.leading, 12)
                }
            }
        }
        .frame(height: 60)
        .navigate(to: CreatorProfileView(id: user.uuid!), when: $navigateToProfile)
    }
    
    func followUnFollow(){
        onSwitched?(user)
        switch selectedSearchPagerType {
        case .followers:
            if user.isSwitched{
                generalManager.unFollow(uuid: user.uuid ?? "")
            }else{
                generalManager.follow(uuid: user.uuid ?? "")
            }
        case .following:
            if user.isSwitched{
                generalManager.follow(uuid: user.uuid ?? "")
            }else{
                generalManager.unFollow(uuid: user.uuid ?? "")
            }
        case .suggested:
            if user.isSwitched{
                generalManager.unFollow(uuid: user.uuid ?? "")
            }else{
                generalManager.follow(uuid: user.uuid ?? "")
            }
        }
    }
    
    func XMarkButton(action: @escaping (()->())) -> some View{
        Button {
            action()
        } label: {
            Image("CategoriesCP")
        }
    }
    
    func getProfileImageUrl() -> URL?{
        if let profileImage = user.profileImage, !profileImage.isEmpty{
            let imageUrl = NetworkConstants.ProductDefinition.BaseAPI.getImageVideoBaseURL.rawValue + profileImage
            return URL(string: imageUrl)
        }
        return nil
    }
    
    func getUserName() -> String{
        return (user.firstName ?? "") + " " + (user.lastName ?? "")
    }
}
