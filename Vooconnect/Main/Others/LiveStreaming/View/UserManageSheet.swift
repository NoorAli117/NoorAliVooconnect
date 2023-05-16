//
//  UserManageSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 22/12/22.
//

import SwiftUI

struct UserManageSheet: View {
    
    @Binding var cancel: Bool
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Button {
                
            } label: {
                Text("Report")
                    .font(.custom("Urbanist-Bold", size: 18))
                    .foregroundColor(.black)
                    .frame(width: 250, height: 45)
                    .background(Color(#colorLiteral(red: 0.9467977881, green: 0.9467977881, blue: 0.9467977881, alpha: 1)))
                    .cornerRadius(25)
            }
            .padding(.top, 30)
            
            
            Button {
                
            } label: {
                Text("Mute")
                    .font(.custom("Urbanist-Bold", size: 18))
                    .foregroundColor(.black)
                    .frame(width: 250, height: 45)
                    .background(Color(#colorLiteral(red: 0.9467977881, green: 0.9467977881, blue: 0.9467977881, alpha: 1)))
                    .cornerRadius(25)
            }
            
            Button {
                
            } label: {
                Text("Block")
                    .font(.custom("Urbanist-Bold", size: 18))
                    .foregroundColor(.black)
                    .frame(width: 250, height: 45)
                    .background(Color(#colorLiteral(red: 0.9467977881, green: 0.9467977881, blue: 0.9467977881, alpha: 1)))
                    .cornerRadius(25)
            }
            
            Button {
                cancel.toggle()
            } label: {
                Text("Cancel")
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
            
//            .background(Color(#colorLiteral(red: 0.9467977881, green: 0.9467977881, blue: 0.9467977881, alpha: 0.2043925911)))

            Spacer()
        }
    }
}

struct UserManageSheet_Previews: PreviewProvider {
    static var previews: some View {
        UserManageSheet(cancel: .constant(false))
    }
}
