//
//  GoLiveCreatorList.swift
//  Vooconnect
//
//  Created by Vooconnect on 21/12/22.
//

import SwiftUI

let columnSpacingLS: CGFloat = 20  // ___
let rowSpacingLS: CGFloat = 8  // |||  20
var gridLayoutLS: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingLS), count: 1)
}

struct GoLiveCreatorList: View {
    
    var body: some View {
        
        VStack {
            HStack {
                
                Image("squareTwoS")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(10)
                
                Text("Daryl Nehls")
                    .font(.custom("Urbanist-Bold", size: 18))
                    .padding(.leading, 10)
                
                Spacer()
                Button {
                    
                } label: {
                    Text("Invite")
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

struct GoLiveCreatorList_Previews: PreviewProvider {
    static var previews: some View {
        GoLiveCreatorList()
    }
}
