//
//  TrendingSoundsView.swift
//  Vooconnect
//
//  Created by Vooconnect on 06/01/23.
//

import SwiftUI

struct TrendingSoundsView: View {
    
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
                        
                        Text("Trending Sounds")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                        
                        Image("ShareN")
                    }
                    
                    ScrollView {
                        
                        HStack {
                            
//                        Image("ImageTwoS")
                            Image("ImageCP")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .cornerRadius(24)
                            
                            VStack(alignment: .leading) {
                                Text("Favorite Girl by")
                                    .font(.custom("Urbanist-Bold", size: 24))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                Text("Justin Bieber")
                                    .font(.custom("Urbanist-Bold", size: 24))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                
                                Text("387.5M Videos")
                                    .font(.custom("Urbanist-Medium", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                                    .padding(.top, 5)
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.top)
                        
                        HStack {
                            HStack {
                                Spacer()
                                Image("PlayS")
                                Text("Play Song")
                                    .font(.custom("Urbanist-SemiBold", size: 16))
                                    .foregroundStyle(LinearGradient(colors: [
                                        Color("buttionGradientTwo"),
                                        Color("buttionGradientOne"),
                                    ], startPoint: .top, endPoint: .bottom)
                                    )
                                Spacer()
                            }
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
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
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
                                Spacer()
                            }
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
                        .padding(.vertical)
                        
                        HStack {
                            
                            Image("squareTwoS")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Justin Bieber")
                                    .font(.custom("Urbanist-Bold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                Text("Professional Singer")
                                    .font(.custom("Urbanist-Medium", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                            }
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Follow")
                                    .font(.custom("Urbanist-SemiBold", size: 14))
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal)
                            
                            .background(LinearGradient(colors: [
                                Color("buttionGradientTwo"),
                                Color("buttionGradientOne"),
                            ], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(20)
                            
                        }
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                            .opacity(0.2 )
                        
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
//                    Spacer()
                }
                .padding(.horizontal)
                
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Image("AddSound2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                        
                        Text("Use this Sound")
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

struct TrendingSoundsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingSoundsView()
    }
}
