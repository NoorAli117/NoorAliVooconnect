//
//  SearchVideosView.swift
//  Vooconnect
//
//  Created by Vooconnect on 13/12/22.
//

import SwiftUI

let columnSpacingV: CGFloat = 10  // ___
let rowSpacingV: CGFloat = 8  // |||  20
var gridLayoutV: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingV), count: 2)
}

struct SearchVideosView: View {
    
    var body: some View {
        VStack {
            Image("ImageS")
                .resizable()
                .scaledToFill()
            
//                .frame(width: UIScreen.main.bounds.width / 2 - 16, height: 300)
            
                .frame(height: 300)
            
                .overlay(
                    VStack {
                        Image("PremiumBadgeS2")
                            
                        Spacer()
                        HStack {
                            Image("PlayS")
                            Text("837.5K")
                                .foregroundColor(.white)
                                .font(.custom("Urbanist-SemiBold", size: 10))
                        }
                    }
                        .padding(.vertical,5)
                        .padding(.leading,10)
                    , alignment: .leading
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
                
                Spacer()
                
            }
            .padding(.vertical, 4)
            
        }
//        .padding(.horizontal)
    }
}

struct SearchVideosView_Previews: PreviewProvider {
    static var previews: some View {
//        SearchVideosView()
        SearchView()
    }
}
