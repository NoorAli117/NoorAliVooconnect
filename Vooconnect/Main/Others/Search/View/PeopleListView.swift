//
//  PeopleListView.swift
//  Vooconnect
//
//  Created by Vooconnect on 13/12/22.
//

import SwiftUI

let columnSpacingP: CGFloat = 10
let rowSpacingP: CGFloat = 10
var gridLayoutP: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingP), count: 1)
}

struct PeopleListView: View {
    var body: some View {
        VStack {
            HStack {
                Image("squareTwoS")
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Ariana Grande")
                            .font(.custom("Urbanist-Bold", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                        
                        Spacer()
                        
                        Image("PremiumBadgeS")
                            .padding(.trailing, 6)
                    }
                    Text("arianagrande | 27.3 follower")
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7024782699)))
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.custom("Urbanist-SemiBold", size: 14))
                        .foregroundColor(Color.white)
                        .frame(width: 73, height: 32)
                        .background(LinearGradient(colors: [
                            Color("buttionGradientTwo"),
                            Color("buttionGradientOne"),
                          ], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(20)
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.top, -6)
            
        }
//        .padding(.horizontal)
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
//        PeopleListView()
        SearchView()
    }
}
