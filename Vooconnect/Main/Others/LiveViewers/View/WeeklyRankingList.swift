//
//  WeeklyRankingList.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/12/22.
//

import SwiftUI

struct WeeklyRankingList: View {
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("1")
                    .padding(.trailing, 6)
                
                Image("squareTwoS")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text("Rochel Foose")
                        .font(.custom("Urbanist-Bold", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9018522351)))
                        
                    
                    Text("55.65M")
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.6967353063)))
                    
                }
                .padding(.leading, 10)
                
                Spacer()
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.custom("Urbanist-SemiBold", size: 14))
                        .foregroundColor(.white)
                }
                .padding(.vertical, 7)
                .padding(.horizontal)
                .background(LinearGradient(colors: [
                    Color("buttionGradientTwo"),
                    Color("buttionGradientOne"),
                  ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
            }
        }
    }
}

struct WeeklyRankingList_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyRankingList()
    }
}
