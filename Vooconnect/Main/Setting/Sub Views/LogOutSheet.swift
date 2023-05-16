//
//  LogOutSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI

struct LogOutSheet: View {
    var body: some View {
        VStack {
            Text("Logout")
                .font(.custom("Urbanist-Bold", size: 24))
                .foregroundStyle(
                    LinearGradient(colors: [
                        Color("buttionGradientTwo"),
                        Color("buttionGradientOne"),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .padding(.top, 30)

            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .opacity(0.2)
                .padding(.vertical, 10)
            
            Text("Are you sure you want to log out?")
                .font(.custom("Urbanist-Bold", size: 20))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
            
            HStack {
                Button {

                } label: {
                    Spacer()
                    Text("Cancel")
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundStyle(
                            LinearGradient(colors: [
                                Color("buttionGradientTwo"),
                                Color("buttionGradientOne"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding()
                    Spacer()
                }
                .background(Color("SkipButtonBackground"))
                .cornerRadius(40)
                
                Spacer()
                Spacer()
                
                Button {

                } label: {
                    Spacer()
                    Text("Yes, Logout")
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .background(
                    LinearGradient(colors: [
                        Color("buttionGradientTwo"),
                        Color("buttionGradientOne"),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(40)
                
                
            }
            .padding(.top, 10)
            
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

struct LogOutSheet_Previews: PreviewProvider {
    static var previews: some View {
        LogOutSheet()
    }
}
