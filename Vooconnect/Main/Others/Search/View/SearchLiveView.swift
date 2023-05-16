//
//  SearchLiveView.swift
//  Vooconnect
//
//  Created by Vooconnect on 13/12/22.
//

import SwiftUI

let columnSpacingL: CGFloat = 10  // ___
let rowSpacingL: CGFloat = 8  // |||  20
var gridLayoutL: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingL), count: 2)
}

struct SearchLiveView: View {
    var body: some View {
        VStack {
            Image("ImageS")    // ImageS  ReelsImage
            
                .resizable()
                .scaledToFill()
//                .cornerRadius(16)
//                .frame(width: UIScreen.main.bounds.width / 2 - 16, height: 300)
            
                .frame(height: 300)
                .clipped()
                .cornerRadius(16)
//                .cornerRadius(16)
            
                .overlay(
                    HStack {
                        
                        HStack {
                            
                            Image("PremiumBadgeS2")
                            
                            Image("VideoS")
                            Text("4.5K")
                                .font(.custom("Urbanist-Medium", size: 12))
                                .foregroundColor(.white)
                                .padding(.leading, -4)
                        }
                        
                        .frame(height: 24)
                        .padding(.horizontal,10)
                        .padding(.leading)
                        .background(Color(#colorLiteral(red: 0.2694437504, green: 0.284270972, blue: 0.3148175478, alpha: 0.6001914321)))
                        .cornerRadius(12)
                        
                    }
                        .padding(.leading, 30)
                        .padding(.top, 10)
                    , alignment: .top
                )
            
                .overlay(
                    Text("LIVE")
                        .font(.custom("Urbanist-SemiBold", size: 10))
                        .frame(width: 41, height: 24)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .opacity(0.8)
                        .cornerRadius(6)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    ,alignment: .topLeading
                    
                )
            
            HStack {
                Image("squareTwoS")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .cornerRadius(10)
                Text("Ariana Black")
                    .font(.custom("Urbanist-Medium", size: 12))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.897687293)))
                
//                Text("ejreiowjferj")
//                    .padding()
//                    .background(Color(#colorLiteral(red: 1, green: 0.4038823843, blue: 0.4780470729, alpha: 0.848794495)))
                
                Spacer()
                
            }
            .padding(.vertical, 4)
            
        }
    }
}

struct SearchLiveView_Previews: PreviewProvider {
    static var previews: some View {
//        SearchLiveView()
        SearchView()
    }
}
