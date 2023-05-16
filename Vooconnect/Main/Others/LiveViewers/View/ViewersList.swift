//
//  ViewersList.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/12/22.
//

import SwiftUI

struct ViewersList: View {
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

struct ViewersList_Previews: PreviewProvider {
    static var previews: some View {
        ViewersList()
    }
}
