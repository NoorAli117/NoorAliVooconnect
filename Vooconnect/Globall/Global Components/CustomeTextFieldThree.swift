//
//  CustomeTextFieldThree.swift
//  Vooconnect
//
//  Created by Voconnect on 14/11/22.
//

import SwiftUI

struct CustomeTextFieldThree: View {
    
    @Binding var text: String
    @State var placeholder: String = ""
    @FocusState private var focused: Bool
    @Binding var color: Bool
    @State var icon: String = ""
    
    var body: some View {
        
        ZStack {
            HStack {
                TextField(placeholder, text: $text)
//                    .disableAutocorrection(true)
                    .textFieldStyle(PlainTextFieldStyle())
                    .focused($focused)
                    .placeholderr(when: text.isEmpty) {
                        Text(placeholder).foregroundColor(.gray)
                            .opacity(0.8)
                    }
                    .foregroundColor(.black)
                
//                Image(focused ? "MessagePurpal1" : "MessageBlack")
                Image(icon)
                    .resizable()
                    
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
            }
            .padding(.leading)
            .padding(.vertical)
        }
        .background(focused ? Color(#colorLiteral(red: 0.9566952586, green: 0.925486505, blue: 1, alpha: 1)) : Color("txtFieldBackgroun"))
//        .background(Color("txtFieldBackgroun"))
        .cornerRadius(10)
//        .shadow(color: .gray, radius: 2, x: 0, y: 3)
        .overlay(focused ? RoundedRectangle(cornerRadius: 10).stroke(color ? Color(.red) : Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: color ? 2 : 0).cornerRadius(10))
    }
}

struct CustomeTextFieldThree_Previews: PreviewProvider {
    static var previews: some View {
        CustomeTextFieldThree(text: .constant(""), color: .constant(false))
    }
}
