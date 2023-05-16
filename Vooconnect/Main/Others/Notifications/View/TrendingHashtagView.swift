//
//  TrendingHashtagView.swift
//  Vooconnect
//
//  Created by Vooconnect on 06/01/23.
//

import SwiftUI

struct TrendingHashtagView: View {
    
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
                        
                        Text("Trending Hashtag")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                        
                        Image("ShareN")
                    }
                    
                    ScrollView {
                        
                        HStack {
                            
                            Image("HastagN")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 112, height: 112)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("amazingfood")
                                    .font(.custom("Urbanist-Bold", size: 24))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                
                                Text("827.5M Videos")
                                    .font(.custom("Urbanist-Medium", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                                
                                HStack {
//                                    Spacer()
                                    Image("BookmarkSound")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 16, height: 16)
                                    Text("Add to Favorites")
                                        .font(.custom("Urbanist-SemiBold", size: 16))
                                        .foregroundStyle(LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .top, endPoint: .bottom)
                                        )
//                                    Spacer()
                                }
                                .padding(.horizontal)
                                .frame(height: 38)
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
                            
                            Spacer()
                            
                        }
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                            .opacity(0.2)
                        
                            .padding(.vertical)
                        
                        LazyVGrid(columns: gridLayoutTS, alignment: .center, spacing: columnSpacingTS, pinnedViews: []) {
                            Section()
                            {
                                ForEach(0..<9) { people in
                                    TrendingSoundlist()
                                }
                            }
                        }
                        
                    }
                    
                }
                .padding(.horizontal)
                
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Image("HastagWhiteN")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                        
                        Text("Use- this Hashtag")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .frame(height: 58)
                    .background(LinearGradient(colors: [
                        Color("buttionGradientTwo"),
                        Color("buttionGradientOne"),
                    ], startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(30)
                }
               
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
            }
        }
    }
}

struct TrendingHashtagView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingHashtagView()
    }
}
