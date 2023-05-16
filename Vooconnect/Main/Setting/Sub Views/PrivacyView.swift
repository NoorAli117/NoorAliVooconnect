//
//  PrivacyView.swift
//  Vooconnect
//
//  Created by Vooconnect on 04/01/23.
//

import SwiftUI

struct PrivacyView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
//                    NavigationLink(destination: FillYourProfileView()
//                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $birthDayVM.birthDayDataModel.navigate) {
//                            EmptyView()
//                        }
                    
                    // Back Button
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Privacy")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    
                    ScrollView {
                        
                        HStack {
                            Text("Visibility")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            Spacer()
                        }

                        VStack {
                            
                            HStack {
                                Image("ShowSettings")
                                Text("Private Account")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("TickSquarePrivacy")
                                Text("Suggest Account to Others")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("SwapPrivacy")
                                Text("Sync Contacts & Friends")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("GroupMA")
                                Text("Loation Services")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                        }
                        .font(.custom("Urbanist-SemiBold", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        
                        HStack {
                            Text("Personalization")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            Spacer()
                        }
                        
                        HStack {
                            Image("DownloadLogo")
                            Text("Download Your Data")
                                .padding(.leading, 8)
                            Spacer()
                            Image("ArrowLogo")
                        }
                        
                        HStack {
                            Text("Safety")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            Spacer()
                        }
                        
                        VStack {
                            
                            HStack {
                                Image("DownloadLogo")
                                Text("Downloads")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("AllowComment")
                                Text("Comments")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("ProfileSetting")
                                Text("Mentions & Tags")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("SendPrivacy")
                                Text("Direct Messages")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("UserPrivacy")
                                Text("Duo")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("PaperPlusPrivacy")
                                Text("Knit")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("UserSettings")
                                Text("Following")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                                                        
                            HStack {
                                Image("HeartPrivacy")
                                Text("Liked Videos")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("PlayPrivacy")
                                Text("Post Views")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                            HStack {
                                Image("GroupMA")
                                Text("Profile Views")
                                    .padding(.leading, 8)
                                Spacer()
                                Image("ArrowLogo")
                            }
                            
                        }
                        .font(.custom("Urbanist-SemiBold", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        
                    }
                    
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
