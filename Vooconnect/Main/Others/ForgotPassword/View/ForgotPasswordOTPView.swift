//
//  ForgotPasswordOTPView.swift
//  Vooconnect
//
//  Created by Vooconnect on 14/11/22.
//

import SwiftUI

struct ForgotPasswordOTPView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    @StateObject var otpModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    // MARK: TextField FocusState
    @FocusState var activeField: OTPField?
    @State private var chooseYourInterest: Bool = false
    
//    @StateObject var otpViewModel = ForgotPasswordViewModel()
    
    @State private var createPasswordView: Bool = false
    
    @State private var timeRemaining = 55
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var email: String
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
                    NavigationLink(destination: CreateNewPasswordView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $createPasswordView) {
                            EmptyView()
                        }
                    
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Forgot Password")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    ScrollView {
                        
                        HStack {
                            
                            Text("Code has been send to")
                                .font(.custom("Urbanist-Medium", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            
//                            Text("+1 111 ******99")
                            Text(email)
                                .font(.custom("Urbanist-Medium", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            
                        }
                        .padding(.top, 60)
                        
                        VStack {
                            OTPField()
                        }
                        .onChange(of: otpModel.otpFields) { newValue in
                            OTPCondition(value: newValue)
                        }
                        .padding(.top, 50)
                        
                        HStack {
                            Text(otpModel.forgotPasswordDataModel.emptyOTP)
                                .font(.custom("Urbanist-Regular", size: 14))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                                .padding(.top, 15)
                                .padding(.bottom, -15)
                        }
                        
                        HStack {
                            Text("Resend code in")
                                .font(.custom("Urbanist-Medium", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
//                            Text("55")
                            Text("\(timeRemaining)")
                                .font(.custom("Urbanist-Medium", size: 18))
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color("buttionGradientTwo"),
                                        Color("buttionGradientOne"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing))
                            Text("s")
                                .font(.custom("Urbanist-Medium", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        }
                        .padding(.top, 50)
                        
                        Button {
                            //                        createPasswordView.toggle()
                            otpModel.forgotVerifyOTPApi()
                        } label: {
                            Text("Verify")
                                .font(.custom("Urbanist-Bold", size: 16))
                                .padding(18)
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(colors: [
                                        Color("buttionGradientTwo"),
                                        Color("buttionGradientOne"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .cornerRadius(40)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 50)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
                
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
            }
            .navigationBarHidden(true)
        }
        
        .alert(isPresented: $otpModel.forgotPasswordDataModel.isPresentingSuccess, content: {
            Alert(title: Text("Alert"), message: Text(otpModel.forgotPasswordDataModel.successMessage), dismissButton: .default(Text("Ok"), action: {
                if otpModel.forgotPasswordDataModel.successMessage == "OTP verified" {
                    createPasswordView = true
                } else {
                    createPasswordView = true
                }
                print("Navigateee==========")
                
            }))
        })
        
    }
    
    // MARK: Condition For Custom OTP Field $ Limiting Only one Text
    func OTPCondition(value: [String]) {
        
        // Moving Next Field If Current Field Type
        for index in 0..<3 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        
        // Moving Back if Current is Empty And Previous is not Empty
        for index in 1...3 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        
        for index in 0..<4 {
            if value[index].count > 1 {
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
    // MARK: Custom OTP TextField
    @ViewBuilder
    func OTPField()->some View {
        HStack(spacing: 14) {
            ForEach(0..<4, id: \.self){ index in
                VStack(spacing: 8) {
                    TextField("", text: $otpModel.otpFields[index])
                        .foregroundColor(.black)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField,equals: activeStateForIndex(index: index))
                        .font(Font.system(size: 22, design: .default))
                        .padding()
                    
                    //                        .background(activeField == activeStateForIndex(index: index) ? .red : .gray)
                    
                        .background(activeField == activeStateForIndex(index: index) ? Color(#colorLiteral(red: 0.5289534926, green: 0.2311087251, blue: 1, alpha: 0.08376448675)) : Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))
                    
                    
                        .overlay(activeField == activeStateForIndex(index: index) ? (RoundedRectangle(cornerRadius: 10).stroke(Color("buttionGradientOne"), lineWidth: 1).cornerRadius(10)) : (RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)), lineWidth: 1).cornerRadius(10)))
                    
                    
                    
                }
                .cornerRadius(10)
            }
            
        }
        
        .toolbar(content: {
            ToolbarItem(placement: .keyboard) {
                Spacer()
            }
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    activeField = nil
                }
            }
        })
        
        .padding(.horizontal)
    }
    
    func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        default: return .field4
            
        }
    
}
    
}

struct ForgotPasswordOTPView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordOTPView(email: .constant(""))
    }
}
