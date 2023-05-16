//
//  CreatorMoreOptionsView.swift
//  Vooconnect
//
//  Created by Online Developer on 13/03/2023.
//

import SwiftUI

struct CreatorMoreOptionsView: View {
    @ObservedObject var creatorProfileViewModel: CreatorProfileViewModel
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                Spacer()
                Text("Share With")
                    .font(.urbanist(name: .urbanistBold, size: 24))
                Spacer()
            }
            .padding(.top, 33)
            .padding(.bottom, 22)
            
            Divider()
                .padding(.bottom, 22)
            
            CreatorMoreOptionUserView(creatorProfileViewModel: creatorProfileViewModel)
            
            Divider()
                .padding(.vertical, 22)
            
            CreatorMoreOptionsSocialView(creatorProfileViewModel: creatorProfileViewModel)
            
            Divider()
                .padding(.vertical, 22)
            
            CreatorMoreOptionsOtherActionsView(creatorProfileViewModel: creatorProfileViewModel)
                .padding(.bottom, 50)
        }
        .padding(.horizontal, 24)
    }
}
