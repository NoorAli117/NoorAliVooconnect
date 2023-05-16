//
//  CreatorProfileImageView.swift
//  Vooconnect
//
//  Created by Vooconnect on 03/12/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Swinject

struct CreatorProfileImageView: View {
    
    @StateObject var vm: GetCreatorImageVM
    
    init(allReels: Post) {
        _vm = StateObject(wrappedValue: GetCreatorImageVM(allReels: allReels))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
//                    .aspectRatio(contentMode: .fill)
                
            } else if vm.isLoading {
//                ProgressView()
                Image("CreaterProfileIcon")
                    .resizable()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.secondary)
            }
        }
    }
}

struct UserProfileImageView: View {
    var userAuthenticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    
    @StateObject var profileImageService = ProfileImageService()
    
    var body: some View {
        ZStack {
            
            if let profileImage = profileImageService.image{
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
            }else{
                Image("profileicon")
                    .resizable()
                    .scaledToFill()
            }
        }
    }
}

