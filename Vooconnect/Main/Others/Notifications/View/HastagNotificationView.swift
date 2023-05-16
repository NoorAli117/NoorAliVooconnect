//
//  HastagNotificationView.swift
//  Vooconnect
//
//  Created by Vooconnect on 06/01/23.
//

import SwiftUI

struct HastagNotificationView: View {
    
    @Binding var trendingHastagView: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Image("HastagN")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                VStack {
                    Text("amazingfood")
                        .font(.custom("Urbanist-Bold", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                    Text("Trending Hashtag")
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                }
                
                Spacer()
                
                HStack {
                    Text("827.5M")
                        .font(.custom("Urbanist-SemiBold", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                    Image("PurpleArrowN")
                }
            }
            .onTapGesture {
                trendingHastagView.toggle()
            }
//            .padding(.horizontal)
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
            
        }
    }
}

struct HastagNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        HastagNotificationView(trendingHastagView: .constant(false))
    }
}
