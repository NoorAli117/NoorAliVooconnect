//
//  PasswordTextFieldTwo.swift
//  Vooconnect
//
//  Created by Voconnect on 26/11/22.
//

import SwiftUI

struct PasswordTextFieldTwo: View {
    
    @Binding var password: String
    @Binding var hiddenn: Bool
    @State var placeholder: String = ""
    @Binding var color: Bool
    @FocusState private var focused: Field?
    
    enum Field {
        case secure, plain
    }
    
    var body: some View {
        ZStack {
            HStack {
                Image((focused != nil) ? "MessagePurpal" : "LockBlack")
                    .resizable()
                    .frame(width: 20, height: 20)

                if hiddenn {
                    TextField(placeholder, text: $password)
                        .disableAutocorrection(true)
                        .textFieldStyle(PlainTextFieldStyle())
                        .focused($focused, equals: .plain)
                        .placeholder(when: password.isEmpty) {
                            Text(placeholder).foregroundColor(.gray)
                                .opacity(0.8)
                        }
                        .foregroundColor(.black)
                        .accentColor(.black)
                        .padding(.trailing, 20)
                } else {
                    SecureField(placeholder, text: $password)
                        .disableAutocorrection(true)
                        .textFieldStyle(PlainTextFieldStyle())
                        .focused($focused, equals: .secure)
                        .placeholder(when: password.isEmpty) {
                            Text(placeholder).foregroundColor(.gray)
                                .opacity(0.8)
                        }
                        .foregroundColor(.black)
                        .accentColor(.black)
                        .padding(.trailing, 20)
                }
            }
            HStack {
                Spacer()
                Button {
                    self.hiddenn.toggle()
                    focused = hiddenn ? .plain : .secure
                } label: {
//                    Image((focused != nil) ? "HidePurpal" : "HideBlack")  // ShowPurpal
                    Image( (focused != nil) ? hiddenn ? "ShowPurpal" : "HidePurpal" : "HideBlack")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }
                
            }
        }
        .multilineTextAlignment(.leading)
        .padding()
        .background((focused != nil) ? Color(#colorLiteral(red: 0.9566952586, green: 0.925486505, blue: 1, alpha: 1)) : Color("txtFieldBackgroun"))
//        .background(Color("txtFieldBackgroun"))
        .cornerRadius(10)
//        .shadow(color: .gray, radius: 2, x: 0, y: 3)
        .overlay((focused != nil) ? RoundedRectangle(cornerRadius: 10).stroke(color ? Color(.red) : Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: color ? 2 : 0).cornerRadius(10))
    }
}

struct PasswordTextFieldTwo_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextFieldTwo(password: .constant(""), hiddenn: .constant(false), color: .constant(false))
    }
}
