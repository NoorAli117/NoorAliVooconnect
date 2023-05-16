//
//  TrendingSoundlist.swift
//  Vooconnect
//
//  Created by Vooconnect on 06/01/23.
//

import SwiftUI

let columnSpacingTS: CGFloat = 10  // ___
let rowSpacingTS: CGFloat = 8  // |||  20
var gridLayoutTS: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingTS), count: 3)
}

struct TrendingSoundlist: View {
    
    var body: some View {
        
        Image("ImageCP")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width / 3 - 16, height: 200)
            .cornerRadius(12)
            .overlay(
//                Image("PlayWhiteN")
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
            .overlay {
                Image("PlayWhiteN")
            }
    }
}

struct TrendingSoundlist_Previews: PreviewProvider {
    static var previews: some View {
        TrendingSoundlist()
    }
}
