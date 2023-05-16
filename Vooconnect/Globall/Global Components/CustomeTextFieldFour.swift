//
//  CustomeTextFieldFour.swift
//  Vooconnect
//
//  Created by sajid shaikh on 15/11/22.
//

import SwiftUI

struct CustomeTextFieldFour: View {
    
    @Binding var text: String
    @State var placeholder: String = ""
    @FocusState private var focused: Bool
    @Binding var color: Bool
    @State var icon: String = ""
    
    var body: some View {
        
        ZStack {
            HStack {
                TextField(placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .focused($focused)
                    .placeholderr(when: text.isEmpty) {
                        Text(placeholder).foregroundColor(.gray)
                            .opacity(0.8)
                    }
                    .foregroundColor(.black)
                
                Image(icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .padding(.trailing)
            }
            .padding(.leading)
            .padding(.vertical)
        }
        .background(focused ? Color(#colorLiteral(red: 0.9566952586, green: 0.925486505, blue: 1, alpha: 1)) : Color("txtFieldBackgroun"))
        .cornerRadius(10)
        .overlay(focused ? RoundedRectangle(cornerRadius: 10).stroke(color ? Color(.red) : Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: color ? 2 : 0).cornerRadius(10))
    }
}

struct CustomeTextFieldFour_Previews: PreviewProvider {
    static var previews: some View {
        CustomeTextFieldFour(text: .constant(""), color: .constant(false))
    }
}
