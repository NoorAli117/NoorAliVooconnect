//
//  CustomeTextFieldSix.swift
//  Vooconnect
//
//  Created by Voconnect on 21/12/22.
//

import SwiftUI

struct CustomeTextFieldSix: View {
    
    @Binding var text: String
    @State var placeholder: String = ""
    @FocusState private var focused: Bool
//    @Binding var color: Bool
    @State var iconLeading: String = ""
    @State var icontTraling: String = ""
    
    var body: some View {
        ZStack {
            HStack {
                
                Image(iconLeading)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
//                    .padding(.trailing)
                
                TextField(placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .focused($focused)
                    .placeholderr(when: text.isEmpty) {
                        Text(placeholder).foregroundColor(.gray)
                            .opacity(0.4)
                    }
                    .foregroundColor(.black)
                
                Image(icontTraling)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .padding(.trailing)
            }
            .padding(.leading)
            .padding(.vertical)
        }
        .background(Color(#colorLiteral(red: 0.9688159823, green: 0.9688159823, blue: 0.9688159823, alpha: 1)))
        .cornerRadius(12)
    }
}

struct CustomeTextFieldSix_Previews: PreviewProvider {
    static var previews: some View {
        CustomeTextFieldSix(text: .constant(""))
    }
}
