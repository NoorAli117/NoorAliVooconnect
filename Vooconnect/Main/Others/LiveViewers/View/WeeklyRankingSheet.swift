//
//  WeeklyRankingSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/12/22.
//

import SwiftUI

struct WeeklyRankingSheet: View {
    
    @State private var weeklyRanking: Bool = true
    @State private var risingStars: Bool = false
    
    var body: some View {
        VStack {
            // All button
            HStack {
                
                Button {
                    weeklyRanking = true
                    risingStars = false
                    
                } label: {
                    VStack {
                        Text("Weekly Tops")
                            .font(.custom("Urbanist-SemiBold", size: 18))
                            .foregroundStyle( weeklyRanking ?
                                LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                    Color("gray"),
                                    Color("gray"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                        
                        
                        ZStack {
                            if weeklyRanking {
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
                    weeklyRanking = false
                    risingStars = true
                    
                } label: {
                    VStack {
                        Text("Up & Comer")
                            .font(.custom("Urbanist-SemiBold", size: 18))
                            .foregroundStyle( risingStars ?
                                LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                    Color("gray"),
                                    Color("gray"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                        
                        ZStack {
                            if risingStars {
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
                                    .padding(.trailing, -40)
                                    .frame(height: 2)
                            }
                        }
                    }
                }
                
               
                
            }
            .padding(.top, 30)
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: gridLayoutLS, alignment: .center, spacing: columnSpacingLS, pinnedViews: []) {
                    Section()
                    {
                        ForEach(0..<10) { people in
                            WeeklyRankingList()
                        }
                    }
                }
                .padding(.top)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct WeeklyRankingSheet_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyRankingSheet()
    }
}
