//
//  CustomeTextFieldFive.swift
//  Vooconnect
//
//  Created by Voconnect on 26/11/22.
//

import SwiftUI

struct CustomeTextFieldFive: View {
            
        @Binding var text: String
        @State var placeholder: String = ""
        @Binding var color: Bool
        @FocusState private var focused: Bool
        
        var body: some View {
            
            ZStack {
                HStack { //MessagePurpal1
                    Image(focused ? "MessagePurpal1" : "MessageBlack")
                        .resizable()
                        .frame(width: 20, height: 20)
                    TextField(placeholder, text: $text)
    //                    .disableAutocorrection(true)
                        .textFieldStyle(PlainTextFieldStyle())
                        .focused($focused)
                        .placeholderr(when: text.isEmpty) {
                            Text(placeholder).foregroundColor(.gray)
                                .opacity(0.8)
                        }
                        .foregroundColor(.black)
                }
                    .padding(.leading)
                    .padding(.vertical)
            }
            .background(focused ? Color(#colorLiteral(red: 0.9566952586, green: 0.925486505, blue: 1, alpha: 1)) : Color("txtFieldBackgroun"))
    //        .background(Color("txtFieldBackgroun"))
            .cornerRadius(10)
    //        .shadow(color: .gray, radius: 2, x: 0, y: 3)
            
//            .overlay(focused ? RoundedRectangle(cornerRadius: 10).stroke(Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: color ? 2 : 0).cornerRadius(10))
            
            .overlay(focused ? RoundedRectangle(cornerRadius: 10).stroke(color ? Color(.red) : Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: color ? 2 : 0).cornerRadius(10))
            
        }
    }


struct CustomeTextFieldFive_Previews: PreviewProvider {
    static var previews: some View {
        CustomeTextFieldFive(text: .constant(""), color: .constant(false))
    }
}
