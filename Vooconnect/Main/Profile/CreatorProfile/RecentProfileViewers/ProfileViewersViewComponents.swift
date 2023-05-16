//
//  ProfileViewersViewComponents.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 26/04/2023.
//

import SwiftUI
import Swinject
import SDWebImageSwiftUI

struct ProfileViewersCell: View {
    var generalManager = Container.default.resolver.resolve(GeneralManager.self)!
    var user: UserDetail
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
                
                if user.isSwitched{
                    FollowButton{ withAnimation { followUnFollow() } }
                        .frame(width: 73, height: 32)
                }else{
                    FollowingButton{ withAnimation { followUnFollow() } }
                        .frame(width: 92, height: 32)
                }
            }
        }
        .frame(height: 60)
        .navigate(to: CreatorProfileView(id: user.uuid!), when: $navigateToProfile)
    }
    
    func followUnFollow(){
        onSwitched?(user)
        if user.isSwitched{
            generalManager.follow(uuid: user.uuid ?? "")
        }else{
            generalManager.unFollow(uuid: user.uuid ?? "")
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
