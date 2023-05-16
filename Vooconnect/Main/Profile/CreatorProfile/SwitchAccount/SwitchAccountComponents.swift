//
//  SwitchAccountComponents.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SwitchAccountRowView: View{
    
    let profile: UserProfileItem
    let isSelected: Bool
    let action: (()->())
    
    var body: some View{
        Button{
            action()
        } label: {
            HStack(spacing: 0){
                
                ZStack{
                    if let profileImage = profile.profile_image{
                        let url = NetworkConstants.ProductDefinition.BaseAPI.getImageVideoBaseURL.rawValue + profileImage
                        WebImage(url: URL(string: url)!)
                            .resizable()
                            .placeholder(Image("profileicon"))
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .aspectRatio(contentMode: .fill)
                    }else{
                        Image("profileicon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: 60)
                .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4){
                    Text(profile.full_name ?? "")
                        .font(.urbanist(name: .urbanistBold, size: 18))
                        .foregroundColor(.black)
                    Text(profile.username ?? "")
                        .font(.urbanist(name: .urbanistMedium, size: 14))
                        .foregroundColor(.grayEight)
                }
                .padding(.leading, 20)
                
                Spacer()
                
                if isSelected{
                    Image("CategoriesSound")
                        .resizable()
                        .frame(width: 28, height: 28)
                }
            }
        }
        .frame(height: 60)
        .disabled(isSelected)
    }
}

struct AddAccountRowView: View{
    var body: some View{
        HStack(spacing: 20){
            Image("addAccount")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60)
                .cornerRadius(30)
            
            Text("Add Account")
                .font(.urbanist(name: .urbanistBold, size: 18))
                .foregroundColor(.black)
            Spacer()
        }
        .frame(height: 60)
    }
}
