//
//  FindFriendsComponents.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI
import Swinject

enum FriendsType: String, CaseIterable{
    case inviteFriends = "Invite Friends"
    case contacts = "Contacts"
    case facebookFriends = "Facebook Friends"
    case instagramFriends = "Instagram Friends"
    
    var subHeading: String{
        switch self {
        case .inviteFriends:
            return "Stay Connected with friends"
        case .contacts:
            return "Find your contacts"
        case .facebookFriends:
            return "Find friends of Facebook"
        case .instagramFriends:
            return "Find friends of Instagram"
        }
    }
    
    var buttonTitle: String{
        switch self {
        case .inviteFriends:
            return "Invite"
        case .contacts, .facebookFriends, .instagramFriends:
            return "Find"
        }
    }
    
    var view: AnyView{
        switch self {
        case .inviteFriends:
            return AnyView(EmptyView())
        case .contacts:
            return AnyView(ContactsView())
        case .facebookFriends:
            return AnyView(EmptyView())
        case .instagramFriends:
            return AnyView(EmptyView())
        }
    }
    
    var isNavigate: Bool{
        switch self {case .contacts:
            return true
        default:
            return false
        }
    }
}

struct FindFirendsNavBar: View{
    var body: some View{
        HStack(spacing: 16){
            BackButton()
            Text("Find Friends")
                .font(.urbanist(name: .urbanistBold, size: 24))
            Spacer()
            Image("ScanSettings")
        }
    }
}

struct FindFriendsSearchBar: View{
    
    @Binding var text: String
    
    @FocusState private var isFocused: Bool

    var body: some View{
        HStack(spacing: 0){
            ZStack{
                VStack{
                    Spacer()
                    HStack(spacing: 12){
                        Image("SearchS")
                        
                        TextField("Search", text: $text)
                            .focused($isFocused)
                        
                        if text.count > 0{
                            Button{
                                withAnimation{
                                    text = ""
                                }
                            } label: {
                                Image("XmarkCP")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    Spacer()
                }
            }
            .background(Color.grayNine)
            .frame(height: 56)
            .cornerRadius(12)
            
            if isFocused{
                Button{
                    withAnimation{
                        isFocused = false
                        text = ""
                        
                    }
                } label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                        .font(.urbanist(name: .urbanistSemiBold))
                        .padding(.leading, 8)
                }
            }
        }
    }
}

struct InviteRowView: View{
    var appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!
    var userAuthenticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    var generalManager = Container.default.resolver.resolve(GeneralManager.self)!
    
    @State var navigate = false
    let type: FriendsType
    @ObservedObject var findFriendsViewModel: FindFriendViewModel
        
    var body: some View{
        HStack(spacing: 0){
            Image(type.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4){
                Text(type.rawValue)
                    .font(.urbanist(name: .urbanistBold, size: 18))
                Text(type.subHeading)
                    .font(.urbanist(name: .urbanistMedium, size: 14))
                    .foregroundColor(.grayEight)
            }
            .padding(.leading, 20)
            
            Spacer()
            
            PrimaryFillButton(title: type.buttonTitle, isIconExist: false, height: 32) {
                let url = "https://vooconnect.com/\(userAuthenticationManager.userDetail?.username ?? "")"
                if type.isNavigate{
                    navigate.toggle()
                }else if type == .facebookFriends{
                    shareOnFacebook(url: url)
                }else if type == .instagramFriends{
                    generalManager.inviteOnSocialMedia(url: url, type: .instagram, onComplete: nil)
                }else{
                    findFriendsViewModel.shareProfile.toggle()
                }
            }
            .frame(width: 68)
            
            
        }
        .frame(height: 60)
        .navigate(to: type.view, when: $navigate)
    }
}
