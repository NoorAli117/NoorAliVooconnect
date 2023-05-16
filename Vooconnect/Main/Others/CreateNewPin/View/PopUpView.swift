//
//  PopUpView.swift
//  Vooconnect
//
//  Created by Vooconnect on 14/11/22.
//

import SwiftUI

struct PopUpView: View {
    
//    @Binding var image: String
    
    var body: some View {
        
        VStack(spacing: 30) {
            Image("PopupLogoThree")
//            Image(image)
                .padding(.top, 35)
            
            Text("Congratulations!")
            
                .foregroundStyle(
                    LinearGradient(colors: [
                        Color("buttionGradientTwo"),
                        Color("buttionGradientOne"),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .font(.custom("Urbanist-Bold", size: 24))
            
            Text("Your account is ready to use. You will be redirected to the Home page in a few seconds.")
                .font(.custom("Urbanist-Regular", size: 16))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Image("PopupLogoTwo")
                .padding(.bottom, 25)
            
        }
        
//        .background(.gray)
        .background(.white)
        .opacity(2.0)
        .cornerRadius(40)
        .padding(.horizontal, 40)

    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView()
    }
}
