//
//  LongPressPopUp.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/11/22.
//

import SwiftUI

struct LongPressPopUp: View {
    
    var body: some View {
        
        HStack {
            
            Button {
                print("Success ====== 2")
            } label: {
                Image("LikeTwo")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Button {
                print("Success ====== 3")
            } label: {
                Image("Love")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Button {
                print("Success ====== 4")
            } label: {
                Image("Haha")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Button {
                print("Success ====== 5")
            } label: {
                Image("Sad")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Button {
                print("Success ====== 5")
            } label: {
                Image("Angry")
                    .resizable()
                    .frame(width: 50, height: 50)
            }

        }
        .padding(6)
        .padding(.bottom, -5)
        .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
        
    }
}

struct LongPressPopUp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressPopUp()
    }
}
