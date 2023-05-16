//
//  CustomTextField.swift
//  Vooconnect
//
//  Created by Voconnect on 02/11/22.
//



import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    @State var placeholder: String = ""
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
        .overlay(focused ? RoundedRectangle(cornerRadius: 10).stroke(Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color("buttionGradientTwo"), lineWidth: 0).cornerRadius(10))
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""))
    }
}

extension View {
    func placeholderr<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


