//
//  CustomTextFieldTwo.swift
//  Vooconnect
//
//  Created by Voconnect on 12/11/22.
//

import SwiftUI

struct CustomTextFieldTwo: View {
    
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
                    Text(placeholder).foregroundColor(.gray)
                        .opacity(0.8)
                }
                .foregroundColor(.black)
        }
//        .padding(.vertical)
    }
}

struct CustomTextFieldTwo_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldTwo(text: .constant(""))
    }
}
