//
//  PasswordTextField.swift
//  Vooconnect
//
// 
//

import SwiftUI

struct PasswordTextField: View {
    
    @Binding var password: String
    @Binding var hiddenn: Bool
    @State var placeholder: String = ""
    @Binding var color: Bool
    @FocusState private var focused: Bool
    
    var body: some View {
        ZStack {
            HStack {
                Image(focused ? "MessagePurpal" : "LockBlack")
                    .resizable()
                    .frame(width: 20, height: 20)

                if hiddenn {
                    TextField(placeholder, text: $password)
                        .disableAutocorrection(true)
                        .textFieldStyle(PlainTextFieldStyle())
                        .focused($focused)
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
                        .focused($focused)
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
                } label: {
                    Image(focused ? "HidePurpal" : "HideBlack")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
            }
        }
        .multilineTextAlignment(.leading)
        .padding()
        .background(focused ? Color(#colorLiteral(red: 0.9566952586, green: 0.925486505, blue: 1, alpha: 1)) : Color("txtFieldBackgroun"))
//        .background(Color("txtFieldBackgroun"))
        .cornerRadius(10)
//        .shadow(color: .gray, radius: 2, x: 0, y: 3)
        .overlay(focused ? RoundedRectangle(cornerRadius: 10).stroke(color ? Color(.red) : Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: color ? 2 : 0).cornerRadius(10))
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(password: .constant(""), hiddenn: .constant(false), color: .constant(false))
//            .preferredColorScheme(.dark)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
