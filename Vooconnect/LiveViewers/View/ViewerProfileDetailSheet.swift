//
//  ViewerProfileDetailSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/12/22.
//

import SwiftUI

struct ViewerProfileDetailSheet: View {

    @StateObject private var likeVM: ReelsLikeViewModel = ReelsLikeViewModel()
    @State var reelId: Int = 0
    @State var follow = false
    @Binding var uuid: String
    @State var followerCount: Int = 0
    @Binding var reel : Post?
        var body: some View {
            NavigationView{
                if let uuid = likeVM.profile?.uuid{
                    VStack {
                        HStack {
                            if let imageName = reel?.creatorProfileImage {
                                CreatorProfileImageView(creatorProfileImage: imageName)
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipped()
                                    .cornerRadius(10)
                                    .padding(.top, 30)
                            }else{
                                Image("ImageCP")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipped()
                                    .cornerRadius(10)
                                    .padding(.top, 30)
                                
                            }
                        }
                        HStack{
                            Text(likeVM.profile?.username ?? "John ")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .padding(.top, 3)
                            Text(likeVM.profile?.lastName ?? "Devise")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .padding(.top, 3)
                        }
                        
                        Text("Dancer & Singer") //Medium
                            .font(.custom("Urbanist-Medium", size: 14))
                            .padding(.top, -5)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                            .opacity(0.2)
                            .padding(.top, 8)
                        
                        // Follower Count
                        HStack {
                            
                            HStack {
                                
                                VStack(spacing: 4) {
                                    Text("\(likeVM.profile?.postCount ?? 0)")
                                        .font(.custom("Urbanist-Bold", size: 24))
                                    Text("Post")  // Medium
                                        .font(.custom("Urbanist-Medium", size: 14))
                                }
                                
                                
                                Spacer()
                                Rectangle()
                                    .frame(width: 1, height: 53)
                                    .foregroundColor(Color(#colorLiteral(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)))
                                Spacer()
                                
                                VStack(spacing: 4) {
                                    Text("\((likeVM.profile?.totalFollowers ?? 0) + followerCount)")
                                        .font(.custom("Urbanist-Bold", size: 24))
                                    Text("Followers")
                                        .font(.custom("Urbanist-Medium", size: 14))
                                }
                                .onTapGesture {
                                    //                        followerView.toggle()
                                }
                                Spacer()
                                
                            }
                            
                            
                            HStack {
                                
                                Rectangle()
                                    .frame(width: 1, height: 53)
                                    .foregroundColor(Color(#colorLiteral(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)))
                                Spacer()
                                
                                VStack(spacing: 4) {
                                    Text("\(likeVM.profile?.totalFollowings ?? 0)")
                                        .font(.custom("Urbanist-Bold", size: 24))
                                    Text("Following")
                                        .font(.custom("Urbanist-Medium", size: 14))
                                }
                                .onTapGesture {
                                    //                        followerView.toggle()
                                }
                                
                                Spacer()
                                Rectangle()
                                    .frame(width: 1, height: 53)
                                    .foregroundColor(Color(#colorLiteral(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)))
                                Spacer()
                                
                                VStack(spacing: 4) {
                                    Text("\(likeVM.profile?.totalLikes ?? 0)")
                                        .font(.custom("Urbanist-Bold", size: 24))
                                    Text("Likes")
                                        .font(.custom("Urbanist-Medium", size: 14))
                                }
                                
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        // Follow Button
                        HStack(spacing: 14) {
                            let loginUuid = UserDefaults.standard.string(forKey: "uuid")
                            if uuid != loginUuid{
                                HStack(spacing: 20) {
                                    
                                    Button {
                                        follow.toggle()
                                        if (follow == true) {
                                            likeVM.followApi(user_uuid: uuid)
                                            likeVM.UserFollowingUsers()
                                            followerCount = followerCount + 1
                                        }else{
                                            likeVM.unFollowApi(user_uuid: uuid)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                                likeVM.UserFollowingUsers()
                                                followerCount = followerCount - 1
                                            }
                                        }
                                    } label: {
                                        Spacer()
                                        Image(follow ? "UserPrivacy" : "AddUserCP")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 16, height: 16)
                                        Text(follow ? "Following" : "Follow")
                                            .font(.custom("Urbanist-Medium", size: 16))
                                            .fontWeight(Font.Weight.medium)
                                        Spacer()
                                    }
                                    .frame(height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .strokeBorder(
                                                follow
                                                ? LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .top, endPoint: .bottom)
                                                : LinearGradient(colors: [
                                                    Color(.white),
                                                ], startPoint: .top, endPoint: .bottom),
                                                lineWidth: 2
                                            )
                                    )
                                    .background(follow ? LinearGradient(colors: [
                                        Color(.white),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                        Color("buttionGradientOne"),
                                        Color("buttionGradientTwo"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                    
                                    .cornerRadius(40)
                                    .foregroundColor(follow ? Color("buttionGradientOne") : .white)
                                    
                                    Button {
                                        
                                    } label: {
                                        Spacer()
                                        Image("ChatCP")
                                        Text("Message")
                                            .font(.custom("Urbanist-SemiBold", size: 16))
                                            .foregroundStyle((LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                        Spacer()
                                    }
                                    .frame(height: 40)
                                    
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 40)
                                            .strokeBorder((LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .top, endPoint: .bottom)
                                            ), lineWidth: 2)
                                    }
                                    .cornerRadius(40)
                                    
                                }
                            }
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                        
                        
                        
                    }
                    .padding(.horizontal)
                }
            }
            .onAppear{
                likeVM.getUserProfile(creatorID: uuid)
            }
        }
    }

//struct ViewerProfileDetailSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewerProfileDetailSheet()
//    }
//}
