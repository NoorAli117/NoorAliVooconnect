//
//  CustomeCommentTextField.swift
//  Vooconnect
//
//  Created by Voconnect on 26/12/22.
//

import SwiftUI

struct CustomeCommentTextField: View {
    
    @Binding var text: String
    @State var placeholder: String = ""
    @FocusState private var focused: Bool
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .disableAutocorrection(true)
                .textFieldStyle(PlainTextFieldStyle())
                .focused($focused)
                .placeholderr(when: text.isEmpty) {
                    Text(placeholder)
                        .font(.custom("Urbanist-Regular", size: 14))
                        .foregroundColor(.black)
                    
//                        .foregroundColor(.gray)
//                        .opacity(0.8)
                    
                }
                .foregroundColor(.black)
        }
//        .padding(.vertical)
    }
}

struct CustomeCommentTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomeCommentTextField(text: .constant(""))
    }
}
