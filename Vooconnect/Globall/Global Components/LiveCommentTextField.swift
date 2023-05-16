//
//  LiveCommentTextField.swift
//  Vooconnect
//
//  Created by Voconnect on 23/12/22.
//

import SwiftUI

struct LiveCommentTextField: View {
    
    @Binding var text: String
    @State var placeholder: String = ""
//    @Binding var color: Bool
    @FocusState private var focused: Bool
    
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
                
                Image("EmojiLV")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Image("SendLV")
                    .resizable()
                    .frame(width: 20, height: 20)
                
            }
            .frame(height: 55)
                .padding(.leading)
                .padding(.trailing)
//                .padding(.vertical)
        }
        .background(Color(#colorLiteral(red: 0.9566952586, green: 0.925486505, blue: 1, alpha: 1)))
        .cornerRadius(10)
        
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10))
        
    }
}

struct LiveCommentTextField_Previews: PreviewProvider {
    static var previews: some View {
        LiveCommentTextField(text: .constant(""))
//                             , color: .constant(false)
    }
}
