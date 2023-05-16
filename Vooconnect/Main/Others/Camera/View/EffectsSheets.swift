//
//  EffectsSheets.swift
//  Vooconnect
//
//  Created by Vooconnect on 31/12/22.
//

import SwiftUI

struct EffectsSheets: View {
    
    @State private var trending: Bool = true
    @State private var new: Bool = false
    
    var body: some View {
        VStack {
            
            Text("Effects")
                .font(.custom("Urbanist-Bold", size: 24))
                .padding(.top, 30)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .opacity(0.2)
//                .padding(.vertical, 10)
                .padding(.bottom, 10)
            
                // All Button
                HStack {
                    
                    Image("cutF")
                    Image("SearchF")
                    Image("SavedF")
                        .padding(.trailing, 10)
                        
                        Button {
                            trending = true
                            new = false
                         
                        } label: {
                            VStack {
                                Text("Trending")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundStyle( trending ?
                                                      LinearGradient(colors: [
                                                        Color("buttionGradientTwo"),
                                                        Color("buttionGradientOne"),
                                                      ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                        Color("gray"),
                                                        Color("gray"),
                                                      ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                                
                                ZStack {
                                    if trending {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.horizontal, -5)
                                            .frame(height: 4)
                                    } else {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("grayOne"),
                                                    Color("grayOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.trailing, -18)
                                            .frame(height: 2)
                                    }
                                }
                                .padding(.top, -5)
                            }
                        }
                    
                    Spacer()
                    
                        Button {
                            trending = false
                            new = true
                        } label: {
                            VStack {
                                Text("New")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundStyle( new ?
                                                      LinearGradient(colors: [
                                                        Color("buttionGradientTwo"),
                                                        Color("buttionGradientOne"),
                                                      ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                        Color("gray"),
                                                        Color("gray"),
                                                      ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                                ZStack {
                                    if new {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.horizontal, -5)
                                            .frame(height: 4)
                                    } else {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("grayOne"),
                                                    Color("grayOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.leading, -12)
//                                            .padding(.trailing, -40)
                                            .frame(height: 2)
                                    }
                                }
                                .padding(.top, -5)
                            }
                        }
                        
                        
                        
                    .padding(.leading, 8)
                    
                } // HStack
                
            .padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: gridLayoutCF, alignment: .center, spacing: columnSpacingCF, pinnedViews: []) {
                    Section()
                    {
                        ForEach(0..<12) { people in
                            EffectsList()
                        }
                    }
                }
                .padding(.top, 10)
            }
            
            
        }
    }
}

struct EffectsSheets_Previews: PreviewProvider {
    static var previews: some View {
        EffectsSheets()
    }
}
