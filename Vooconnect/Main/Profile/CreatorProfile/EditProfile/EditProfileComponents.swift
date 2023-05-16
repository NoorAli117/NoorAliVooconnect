//
//  EditProfileComponents.swift
//  Vooconnect
//
//  Created by Online Developer on 11/03/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Swinject
import Combine

enum EditProfileRowType: String{
    case firstName = "First Name"
    case lastName = "Last Name"
    case username = "Username"
    case bio = "Bio"
    case instagram = "Instagram"
    case facebook = "Facebook"
    case twitter = "Twitter"
    case facebookId = ""
    
    static var aboutCases: [EditProfileRowType]{
        [.firstName, .lastName, .username, .bio]
    }
    
    static var socialCases: [EditProfileRowType]{
        [.instagram, .facebook, .twitter]
    }
    
    var icon: String{
        switch self {
        case .firstName, .lastName:
            return "Profile"
        case .username:
            return "TickSquareSettings"
        case .bio:
            return "InfoSquareSettings"
        case .instagram:
            return "InstagramEP"
        case .facebook:
            return "FacebookEP"
        case .twitter:
            return "TwitterEP"
        case .facebookId:
            return ""
        }
    }
    
    var placeholder: String{
        switch self {
        case .firstName:
            return "Add First Name"
        case .lastName:
            return "Add Last Name"
        case .username:
            return "Add Username"
        case .bio:
            return "Add a bio"
        case .instagram:
            return "Add Instagram"
        case .facebook:
            return "Add Facebook"
        case .twitter:
            return "Add Twitter"
        case .facebookId:
            return ""
        }
    }
}

struct EditProfileNavBar: View{
    var body: some View{
        HStack(spacing: 16){
            BackButton()
            Text("Edit Profile")
                .font(.urbanist(name: .urbanistBold, size: 24))
            Spacer()
        }
    }
}

struct EditProfileImageView: View {
    let userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    @ObservedObject var editProfileViewModel: EditProfileViewModel
    
    var body: some View{
        
        ZStack(alignment: .bottomTrailing){
            ZStack{
                if editProfileViewModel.isProfilePhotoSelected{
                    Image(uiImage: editProfileViewModel.selectedProfilePhoto)
                        .resizable()
                        .scaledToFill()
                }else if let profileImage = userAuthanticationManager.userDetail?.profileImage{
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
            .frame(width: 160, height: 160)
            .cornerRadius(10)
            
            Button{
                editProfileViewModel.presentActionSheet.toggle()
            } label: {
                Image("EditSquareEP")
            }
        }
    }
}

struct EditProfileRow: View{
    
    @ObservedObject var editProfileViewModel: EditProfileViewModel
    
    let rowType: EditProfileRowType
    let value: String
    
    @State var isEdit = false
    @State var inputText = ""
    @State var isShowInputText = false
    
    var body: some View{
        VStack{
            Button{
                withAnimation{
                    inputText = ""
                    isShowInputText = false
                    isEdit.toggle()
                }
            } label: {
                HStack(spacing: 20){
                    Image(rowType.icon)
                    HStack(spacing: 2){
                        
                        HStack(spacing: 0){
                            Text(rowType.rawValue)
                                .font(.urbanist(name: .urbanistSemiBold, size: 18))
                                .lineLimit(1)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                        HStack(spacing: 0){
                            Spacer()
                            Text(isShowInputText ? inputText : value)
                                .font(.urbanist(name: .urbanistSemiBold, size: 18))
                                .lineLimit(1)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    Image("ArrowLogo")
                }
            }
            
            if isEdit{
                EditTextFieldView(editProfileViewModel: editProfileViewModel, placeholder: rowType.placeholder, isEdit: $isEdit, rowType: rowType, inputText: $inputText, isShowInputText: $isShowInputText)
                    .padding([.horizontal, .top])
            }
        }
    }
}

struct EditTextFieldView: View{
    
    @ObservedObject var editProfileViewModel: EditProfileViewModel
    let placeholder: String
    @Binding var isEdit: Bool
    let rowType: EditProfileRowType
    @Binding var inputText: String
    @Binding var isShowInputText: Bool
    
    var body: some View{
        VStack(alignment: .leading, spacing: 3){
            Image("TriangleEP")
                .frame(width: 40, height: 24)
                .padding(.leading, 40)
            ZStack{
                RoundedRectangle(cornerRadius: 27)
                    .fill(.white)
                VStack(spacing: 0){
                    Spacer()
                    
                    
                    if isSocialAccount(){
                        Text("Connect to your \(rowType.rawValue) Account")
                            .font(.urbanist(name: .urbanistMedium, size: 14))
                            .foregroundColor(.customGray)
                    }else{
                        TextField(placeholder, text: $inputText)
                            .onReceive(Just(inputText)) { _ in limitText() }
                        Rectangle()
                            .fill(Color.customGray)
                            .frame(height: 1.5)
                            .padding(.top, 1)
                    }
                    
                    
                    Spacer()
                    HStack{
                        PrimaryFillButton(title: "Cancel", isIconExist: false, height: 24, font: Font.urbanist(name: .urbanistSemiBold, size: 10)) {
                            withAnimation{
                                isEdit.toggle()
                            }
                        }
                        .frame(width: 64)
                        
                        Spacer()
                        
                        PrimaryFillButton(title: isSocialAccount() ? "Continue" : "Save", isIconExist: false, height: 24, font: Font.urbanist(name: .urbanistSemiBold, size: 10)) {
                            withAnimation{ isEdit.toggle() }
                            if isSocialAccount(){
                                linkWithSocialAccounts()
                            }else{
                                if !inputText.isEmpty{
                                    isShowInputText = true
                                    editProfileViewModel.updateUserProfile(type: rowType, text: inputText)
                                }
                            }
                        }
                        .frame(width: isSocialAccount() ? 74 : 64)
                    }
                    Spacer()
                }
                .padding(.horizontal, 32)
            }
            .frame(height: 104)
            .overlay {
                RoundedRectangle(cornerRadius: 27)
                    .stroke(Color.purpleYellowGradient, lineWidth: 2)
            }
        }
    }
    
    /// Function to keep text length in limits
    func limitText() {
        if inputText.count > 150 {
            inputText = String(inputText.prefix(150))
        }
    }
    
    func isSocialAccount() -> Bool{
        if rowType == .instagram || rowType == .facebook || rowType == .twitter{
            return true
        }
        return false
    }
    
    func linkWithSocialAccounts(){
        if rowType == .facebook{
            editProfileViewModel.loginWithFacebook{ username in
                inputText = username
                isShowInputText = true
                editProfileViewModel.updateUserProfile(type: rowType, text: inputText)
            }
        }else if rowType == .twitter{
            editProfileViewModel.loginWithTwitter{ username in
                inputText = username
                isShowInputText = true
                editProfileViewModel.updateUserProfile(type: rowType, text: inputText)
            }
        }else if rowType == .instagram{
            InstagramLoginManager.shared.login()
        }
    }
    
}
