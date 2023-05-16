//
//  TrendingView.swift
//  Vooconnect
//
//  Created by Vooconnect on 06/01/23.
//

import SwiftUI

struct TrendingView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State private var sounds: Bool = true
    @State private var hashtag: Bool = false
    @State private var trendingSoundView: Bool = false
    @State private var trendingHastagView: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
                    NavigationLink(destination: TrendingSoundsView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $trendingSoundView) {
                            EmptyView()
                        }
                    NavigationLink(destination: TrendingHashtagView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $trendingHastagView) {
                            EmptyView()
                        }
                    
                    // Back Button
                    HStack {
                        
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Spacer()
                        
                        Text("Trending")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        Image("SearchN")
                        
                    }
                    
                    
                    
                    // All button
                    HStack {
                        
                        Button {
                            sounds = true
                         hashtag = false
                            
                        } label: {
                            VStack {
                                Text("Sounds")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundStyle( sounds ?
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                            Color("gray"),
                                            Color("gray"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                                
                                ZStack {
                                    if sounds {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .frame(height: 4)
                                    } else {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("grayOne"),
                                                    Color("grayOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.trailing, -9)
                                            .frame(height: 2)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            sounds = false
                            hashtag = true
                            
                        } label: {
                            VStack {
                                Text("Hashtag")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundStyle( hashtag ?
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                            Color("gray"),
                                            Color("gray"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                                ZStack {
                                    if hashtag {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .frame(height: 4)
                                    } else {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("grayOne"),
                                                    Color("grayOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.leading, -8)
                                            .frame(height: 2)
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    
                    // One
                    ScrollView {
                        
                        if sounds {
                            
                            HStack {
                                
                                Image("ImageTwoS")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(16)
                                
                                VStack(alignment: .leading, spacing: 7) {
                                    Text("Favorite Girl")
                                        .font(.custom("Urbanist-Bold", size: 18))
                                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    Text("Justin Bieber")
                                        .font(.custom("Urbanist-Medium", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                                    Text("01:00")
                                        .font(.custom("Urbanist-Medium", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                                }
                                .padding(.leading, 10)
                                
                                Spacer()
                                
                                HStack {
                                    Text("387.5M")
                                        .font(.custom("Urbanist-SemiBold", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                                    Image("PurpleArrowN")
                                }
                                
                            }
                            .onTapGesture {
                                trendingSoundView.toggle()
                            }
                            .padding(.vertical)
                            
                            HStack {
                                Image("ImageCP")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 3 - 16, height: 200)
                                    .cornerRadius(12)
                                    .overlay(
                                        HStack {
                                            Image("PlayN")
                                            Text("736.2K")
                                                .font(.custom("Urbanist-SemiBold", size: 10))
                                                .foregroundColor(.white)
                                        }
                                            .padding(.leading, 10)
                                            .padding(.bottom, 10)
                                        ,alignment: .bottomLeading
                                    )
                                Image("ImageCP")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 3 - 16, height: 200)
                                    .cornerRadius(12)
                                    .overlay(
                                        HStack {
                                            Image("PlayN")
                                            Text("736.2K")
                                                .font(.custom("Urbanist-SemiBold", size: 10))
                                                .foregroundColor(.white)
                                        }
                                            .padding(.leading, 10)
                                            .padding(.bottom, 10)
                                        ,alignment: .bottomLeading
                                    )
                                Image("ImageCP")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 3 - 16, height: 200)
                                    .cornerRadius(12)
                                    .overlay(
                                        HStack {
                                            Image("PlayN")
                                            Text("736.2K")
                                                .font(.custom("Urbanist-SemiBold", size: 10))
                                                .foregroundColor(.white)
                                        }
                                            .padding(.leading, 10)
                                            .padding(.bottom, 10)
                                        ,alignment: .bottomLeading
                                    )
                            }
                            
                            
                            // Two
                            HStack {
                                
                                Image("ImageTwoS")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(16)
                                
                                VStack(alignment: .leading, spacing: 7) {
                                    Text("Favorite Girl")
                                        .font(.custom("Urbanist-Bold", size: 18))
                                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    Text("Justin Bieber")
                                        .font(.custom("Urbanist-Medium", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                                    Text("01:00")
                                        .font(.custom("Urbanist-Medium", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                                }
                                .padding(.leading, 10)
                                
                                Spacer()
                                
                                HStack {
                                    Text("387.5M")
                                        .font(.custom("Urbanist-SemiBold", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                                    Image("PurpleArrowN")
                                }
                                
                            }
                            .onTapGesture {
                                trendingSoundView.toggle()
                            }
                            .padding(.vertical)
                            
                            HStack {
                                Image("ImageCP")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 3 - 16, height: 200)
                                    .cornerRadius(12)
                                    .overlay(
                                        HStack {
                                            Image("PlayN")
                                            Text("736.2K")
                                                .font(.custom("Urbanist-SemiBold", size: 10))
                                                .foregroundColor(.white)
                                        }
                                            .padding(.leading, 10)
                                            .padding(.bottom, 10)
                                        ,alignment: .bottomLeading
                                    )
                                Image("ImageCP")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 3 - 16, height: 200)
                                    .cornerRadius(12)
                                    .overlay(
                                        HStack {
                                            Image("PlayN")
                                            Text("736.2K")
                                                .font(.custom("Urbanist-SemiBold", size: 10))
                                                .foregroundColor(.white)
                                        }
                                            .padding(.leading, 10)
                                            .padding(.bottom, 10)
                                        ,alignment: .bottomLeading
                                    )
                                Image("ImageCP")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 3 - 16, height: 200)
                                    .cornerRadius(12)
                                    .overlay(
                                        HStack {
                                            Image("PlayN")
                                            Text("736.2K")
                                                .font(.custom("Urbanist-SemiBold", size: 10))
                                                .foregroundColor(.white)
                                        }
                                            .padding(.leading, 10)
                                            .padding(.bottom, 10)
                                        ,alignment: .bottomLeading
                                    )
                            }
                            
                        } else {
                            HastagNotificationView(trendingHastagView: $trendingHastagView)
                            HastagNotificationView(trendingHastagView: $trendingHastagView)
                        }
                    }
                    
                }
                .padding(.horizontal)
            }
        }
    }
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingView()
    }
}
