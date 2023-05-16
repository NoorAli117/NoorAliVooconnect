//
//  GiftPanelList.swift
//  Vooconnect
//
//  Created by Vooconnect on 26/12/22.
//

import SwiftUI

let columnSpacingGP: CGFloat = 20  // ___
let rowSpacingGP: CGFloat = 8  // |||  20
var gridLayoutGP: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingGP), count: 5)
}

struct GiftPanelList: View {
    
    
    var body: some View {
        
        VStack {
                        
            Rectangle()
                .frame(width: UIScreen.main.bounds.width / 5 - 5 , height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
            
            Image("GiftIconLV")
            
            Text("Tennis")
                .font(.custom("Urbanist-Bold", size: 10))
                .padding(.top, -6)
            
            HStack {
                Image("WalletLV")
                Text("1")
                    .font(.custom("Urbanist-Bold", size: 16))
            }
            .padding(.top, -6)
            .padding(.bottom, -6)
            
        }
    }
}

struct GiftPanelList_Previews: PreviewProvider {
    static var previews: some View {
//        GiftPanelList()
        GiftPanelSheet()
    }
}
