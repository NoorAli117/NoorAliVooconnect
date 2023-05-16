//
//  ModeratorsListView.swift
//  Vooconnect
//
//  Created by Vooconnect on 22/12/22.
//

import SwiftUI

struct ModeratorsListView: View {
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
                    Text("Remove")
                        .font(.custom("Urbanist-SemiBold", size: 14))
                    
//                        .foregroundColor(.white)
                    
                        .foregroundStyle(LinearGradient(colors: [
                            Color("buttionGradientTwo"),
                            Color("buttionGradientOne"),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .padding(.vertical, 7)
                .padding(.horizontal)
                
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder((LinearGradient(colors: [
                            Color("buttionGradientTwo"),
                            Color("buttionGradientOne"),
                        ], startPoint: .top, endPoint: .bottom)
                        ), lineWidth: 2)
                }
                
//                .background(LinearGradient(colors: [
//                    Color("buttionGradientTwo"),
//                    Color("buttionGradientOne"),
//                  ], startPoint: .topLeading, endPoint: .bottomTrailing))
                
                .cornerRadius(20)
            }
        }
    }
}

struct ModeratorsListView_Previews: PreviewProvider {
    static var previews: some View {
        ModeratorsListView()
    }
}
