//
//  GoLiveTogeRequestSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/12/22.
//

import SwiftUI

struct GoLiveTogeRequestSheet: View {
        
    var body: some View {
        VStack(spacing: 20) {
            Text("Go LIVE With")
                .font(.custom("Urbanist-Bold", size: 24))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                .padding(.top, 30)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
            
            HStack {
                Text("532 guest requests")
                    .font(.custom("Urbanist-SemiBold", size: 16))
                    .foregroundColor(Color(#colorLiteral(red: 0.3278294206, green: 0.3278294206, blue: 0.3278294206, alpha: 0.8010916805)))
                Spacer()
            }
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: gridLayoutLS, alignment: .center, spacing: columnSpacingLS, pinnedViews: []) {
                    Section()
                    {
                        ForEach(0..<10) { people in
                            GoLiveTogeRequestList()
                        }
                    }
                }
                
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
            
            Button {
//                cancel.toggle()
            } label: {
                Text("Request")
                    .font(.custom("Urbanist-Bold", size: 18))
                    .foregroundColor(.white)
                    .frame(width: 320, height: 45)
                    .background(
                        LinearGradient(colors: [
                            Color("buttionGradientTwo"),
                            Color("buttionGradientOne"),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(25)
            }
            
        }
        .padding(.horizontal)
    }
}

struct GoLiveTogeRequestSheet_Previews: PreviewProvider {
    static var previews: some View {
        GoLiveTogeRequestSheet()
    }
}
