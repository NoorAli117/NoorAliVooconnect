//
//  SearchSoundsView.swift
//  Vooconnect
//
//  Created by Vooconnect on 13/12/22.
//

import SwiftUI

let columnSpacingS: CGFloat = 20
let rowSpacingS: CGFloat = 10
var gridLayoutS: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingS), count: 1)
}

struct SearchSoundsView: View {
    var body: some View {
        HStack {
            Image("ImageTwoS")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(16)
                .padding(.trailing, 6)
            VStack(alignment: .leading, spacing: 7) {
                Text("Side to Side")
                    .font(.custom("Urbanist-Bold", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                HStack {
                    Text("Ariana Grande")
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.6975113825)))
                    Spacer()
                    Text("938.6K")
                        .font(.custom("Urbanist-SemiBold", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.6975113825)))
                    
                }
                Text("01:00")
                    .font(.custom("Urbanist-Medium", size: 14))
                    .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.6975113825)))
            }
        }
//        .padding(.horizontal)
    }
}

struct SearchSoundsView_Previews: PreviewProvider {
    static var previews: some View {
//        SearchSoundsView()
        SearchView()
    }
}
