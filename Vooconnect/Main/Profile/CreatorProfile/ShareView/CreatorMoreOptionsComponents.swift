//
//  CreatorMoreOptionsComponents.swift
//  Vooconnect
//
//  Created by Online Developer on 13/03/2023.
//

import SwiftUI
import Swinject
import SDWebImageSwiftUI
import Swinject

enum CreatorMoreOptionsType: String{
    case user1 = "andrew..."
    case user2 = "andrew.."
    case user3 = "andrew."
    case search = "Search"
    case vooFriends = "V--oo Firends"
    case whatsapp = "Whatsapp"
    case sms = "SMS"
    case facebook = "Facebook"
    case email = "Email"
    case report = "Report"
    case block = "Block"
    case message = "Message"
    case removeFollower = "Remove Followers"
    
    static var socialCases: [CreatorMoreOptionsType]{
        [.vooFriends, .whatsapp, .sms, .facebook, .email]
    }
    
    static var otherCases: [CreatorMoreOptionsType]{
        [.report, .block, .message, .removeFollower]
    }
    
    static var usersCases: [CreatorMoreOptionsType]{
        [.user1, .user2, .user3, .search]
    }
    
    var icon: String{
        switch self {
        case .user1, .user2, .user3:
            return "squareTwoS"
        case .search:
            return "SearchPS"
        case .vooFriends:
            return "VooFriendsPS"
        case .whatsapp:
            return "WhatsappPS"
        case .sms:
            return "SmsPS"
        case .facebook:
            return "FacebookPS"
        case .email:
            return "EmailPS"
        case .report:
            return "ReportPS"
        case .block:
            return "BlockPS"
        case .message:
            return "MessagePS"
        case .removeFollower:
            return "RemoveFollowerPS"
        }
    }
}

struct CreatorOptionCell: View{
    let icon: String
    let title: String
    var body: some View{
        VStack{
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            Text(title)
                .font(.urbanist(name: .urbanistMedium, size: 10))
                .multilineTextAlignment(.center)
                .frame(width: 50)
                .foregroundColor(.black)
        }
    }
}

struct CreatorMoreOptionUserView: View{
    var appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!
    
    @ObservedObject var creatorProfileViewModel: CreatorProfileViewModel
    
    @State var navigateToProfile = false

    var body: some View{
        let suggestedUsers = creatorProfileViewModel.suggestedUsers
        if suggestedUsers.count > 0{
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), alignment: .top), count: 4)) {
                ForEach((0...2), id:\.self){ index in
                    UserCell(userDetail: suggestedUsers[index])
                }
                
                Button{
                    appEventsManager.hideBottomSheet.send(true)
                    creatorProfileViewModel.navigateToCreatorSearchView.toggle()
                } label: {
                    CreatorOptionCell(icon: CreatorMoreOptionsType.search.icon, title: CreatorMoreOptionsType.search.rawValue)
                }
            }
        }
    }
    
    func UserCell(userDetail: UserDetail) -> some View{
        Button{
            creatorProfileViewModel.selectedUserId = userDetail.uuid!
            creatorProfileViewModel.navigateToCreatorProfileView.toggle()
            appEventsManager.hideBottomSheet.send(true)
        } label: {
            VStack{
                ZStack{
                    if let profileImage = userDetail.profileImage{
                        let url = NetworkConstants.ProductDefinition.BaseAPI.getImageVideoBaseURL.rawValue + profileImage
                        WebImage(url: URL(string: url) ?? URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AProfile_avatar_placeholder_large.png")!)
                            .resizable()
                            .placeholder(Image("profileicon"))
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFill()
                    }else{
                        Image("profileicon")
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                
                Text(userDetail.username ?? "no username")
                    .font(.urbanist(name: .urbanistMedium, size: 10))
                    .multilineTextAlignment(.center)
                    .frame(width: 50)
                    .foregroundColor(.black)
            }
        }
    }
}


struct CreatorMoreOptionsSocialView: View{
    @ObservedObject var creatorProfileViewModel: CreatorProfileViewModel
    var generalManager = Container.default.resolver.resolve(GeneralManager.self)!
    var body: some View{
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), alignment: .top), count: CreatorMoreOptionsType.socialCases.count)) {
            ForEach(CreatorMoreOptionsType.socialCases, id:\.self){ type in
                Button{
                    shareActionsClick(type: type)
                } label: {
                    CreatorOptionCell(icon: type.icon, title: type.rawValue)
                }
            }
        }
    }
    
    func shareActionsClick(type: CreatorMoreOptionsType){
        let profileUrl = "https://vooconnect.com/\(creatorProfileViewModel.userDetail?.username ?? "")"
        switch type{
        case .whatsapp:
            generalManager.inviteOnSocialMedia(
                url: profileUrl,
                type: .whatsapp, onComplete: nil
            )
        case .sms:
            generalManager.inviteOnSocialMedia(
                url: "",
                type: .sms(
                    phoneNo: creatorProfileViewModel.userDetail?.phone ?? "+1",
                    message: profileUrl
                ),
                onComplete: nil
            )
        case .facebook:
            creatorProfileViewModel.shareProfile.toggle()
        case .email:
            generalManager.inviteOnSocialMedia(
                url: "",
                type: .email(url: profileUrl),
                onComplete: nil
            )
        default:
            logger.info("Do nothing", category: .profile)
        }
    }
}


struct CreatorMoreOptionsOtherActionsView: View{
    var generalManager = Container.default.resolver.resolve(GeneralManager.self)!
    @ObservedObject var creatorProfileViewModel: CreatorProfileViewModel
    var body: some View{
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), alignment: .top), count: CreatorMoreOptionsType.otherCases.count)) {
            ForEach(CreatorMoreOptionsType.otherCases, id:\.self){ type in
                Button{
                    shareOtherActionsClick(type: type)
                } label: {
                    CreatorOptionCell(icon: type.icon, title: type.rawValue)
                }
            }
        }
    }
    
    func shareOtherActionsClick(type: CreatorMoreOptionsType){
        guard let uuid = creatorProfileViewModel.userDetail?.uuid else { return }
        switch type{
        case .block:
            generalManager.blockUser(uuid: uuid) { }
        case .removeFollower:
            generalManager.removeFollower(uuid: uuid) { }
        case .report:
            generalManager.reportUser(uuid: uuid) { }
        case .message:
            logger.info("Move to chat", category: .chat)
        default:
            logger.info("Do Nothing", category: .chat)
        }
    }
}
