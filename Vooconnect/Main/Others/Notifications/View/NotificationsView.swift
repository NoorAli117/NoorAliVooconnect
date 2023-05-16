//
//  NotificationsView.swift
//  Vooconnect
//
//  Created by Vooconnect on 04/11/22.
//

import SwiftUI

struct NotificationsView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State private var topSheet: Bool = false
    @State private var trendingView: Bool = false
    
    var body: some View {
//        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    if topSheet {
                        Color.white
                            .frame(height: UIScreen.main.bounds.height * (1/3))
                        Color.gray
                            .ignoresSafeArea()
                    } else {
                        Color.white
                            .ignoresSafeArea()
                    }
                }
                
                  
                
                VStack {
                    
                    NavigationLink(destination: TrendingView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $trendingView) {
                            EmptyView()
                        }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                        .opacity(0.3)
//                        .padding(.top, -1)
                    
                    HStack {
                        
                        Image("NotificationIcon")
                            .onTapGesture {
                                trendingView.toggle()
                            }
                        
                        Spacer()
                        
                        Text("All Activity")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .offset(x: -8)
                        
                        Button {
                            topSheet.toggle()
                        } label: {
                            Image("ArrowDownLogoM")
                        }
                        .offset(x: -8)

                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        
                        HStack {
                            
                            Text("Today")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                                                
                        VStack(spacing: 25) {
                            
                            NotificationCell()
                            
                            NotificationCellTwo()
                            
                            NotificationCell()
                            
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            
                            Text("Yesterday")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            
                            Spacer()
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        
                        VStack(spacing: 25) {
                            
                            NotificationCellTwo()
                            
                            NotificationCell()
                            
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            
                            Text("This Week")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            
                            Spacer()
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        
                        VStack(spacing: 25) {
                            
                            NotificationCellTwo()
                            
                            NotificationCell()
                            
                            NotificationCell()
                            
                            NotificationCellTwo()
                            
                        }
                        .padding(.horizontal)
                        
                        
                    }
                    

                }
                
                if topSheet {
                    
                    VStack(spacing: 20) {
                        
                        HStack {
                            Image("AllActivityN")
                            Button {
                                
                            } label: {
                                Text("All Activity")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            }
                            Spacer()

                            Image("CheckMarkN")
                        }
                        
                        HStack {
                            Image("LikeWhiteC")
                            Button {
                                
                            } label: {
                                Text("Likes")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            }
                            Spacer()

                            Image("CheckMarkN")
                        }
                        
                        HStack {
                            Image("AllowComment")
                            Button {
                                
                            } label: {
                                Text("Comments")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            }
                            Spacer()

                            Image("CheckMarkN")
                        }
                        
                        HStack {
                            Image("PaperSettings")
                            Button {
                                
                            } label: {
                                Text("Q&A")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            }
                            Spacer()

                            Image("CheckMarkN")
                        }
                        
                        HStack {
                            Image("ProfileSetting")
                            Button {
                                
                            } label: {
                                Text("Mentions & Tags")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            }
                            Spacer()

                            Image("CheckMarkN")
                        }
                        
                        HStack {
                            Image("UserSettings")
                            Button {
                                
                            } label: {
                                Text("Followers")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            }
                            Spacer()

                            Image("CheckMarkN")
                        }
                        
                        HStack {
                            Image("InfoSquareSettings")
                            Button {
                                
                            } label: {
                                Text("From Vooconnect")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            }
                            Spacer()

                            Image("CheckMarkN")
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom)
                    .background(Color(.white))
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 45)
                   
                   
                }
                
            }
           
//        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}





//    .overlay(
//        ZStack(alignment: .top) {
//            Color.clear
//            Text("This is the overlay text snippet sentence that is multiline...\nThis is the overlay text snippet sentence that is multiline...\nThis is the overlay text snippet sentence that is multiline...\nThis is the overlay text snippet sentence that is multiline...\nThis is the overlay text snippet sentence that is multiline...\nThis is the overlay text snippet sentence that is multiline...\n")
//                    .lineLimit(9)
//                    .background(Color.gray)
//                    .alignmentGuide(.top) { self.hideOverlay ? $0.height * 3/2 : $0[.top] - 64 }
//                    .onTapGesture {
//                        withAnimation(Animation.spring()) {
//                            self.hideOverlay.toggle()
//                        }
//                }
//        })
