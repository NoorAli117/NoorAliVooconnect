//
//  ForgotPasswordView.swift
//  Vooconnect
//
//  Created by Vooconnect on 14/11/22.
// ForgetPasswordLogo

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State private var phone: Bool = false
    @State private var email: Bool = false
    @State private var otpView: Bool = false
    
//    @ObservedObject private var forgotPasswordVM: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    @StateObject private var otpVm = ForgotPasswordViewModel()
    
//    @State var favourites: [String: String] = UserDefaults.standard.object(forKey: "email") as? [String: String] ?? [:]
    
    @State var credentialDetail: String = ""
    
    @State var phoneData = UserDefaults.standard.object(forKey: "phone") as? String ?? ""
    @State var emailData = UserDefaults.standard.object(forKey: "email") as? String ?? ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
                    NavigationLink(destination: ForgotPasswordOTPView(email: $credentialDetail)
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $otpView) {
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
                        
                        VStack {
                            
                            Image("ForgetPasswordLogo")
                                .resizable()
                                .frame(width: 250, height: 244)
                                .padding(.bottom, 20)
                            
                            Text("Select which contact details should we use to reset your password")
                                .font(.custom("Urbanist-Medium", size: 18))
                                .foregroundColor(Color("Black"))
                                .padding(.bottom)
                            
                            
                            if phoneData == "" {
                                
                                emailView
                                .onTapGesture {
                                    email = true
                                    phone = false
                                }
                                
                            } else if emailData == "" {
                                
                                phoneView
                                .onTapGesture {
                                    phone = true
                                    email = false
                                }
                                .padding(.bottom, 10)
                                
                            } else {
                                
                                emailView
                                .onTapGesture {
                                    email = true
                                    phone = false
                                }
                                
                                phoneView
                                .onTapGesture {
                                    phone = true
                                    email = false
                                }
                                .padding(.bottom, 10)
                                
                            }
                            
                            Button {
                                
                                    if email == true {
                                        credentialDetail = emailData
                                        otpVm.forgotGetOtpEmailApi()
                                    } else if phone == true {
                                        credentialDetail = phoneData
                                        otpVm.forgotGetOtpPhoneApi()
                                    }
                                
                            } label: {
                                Text("Continue")
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
                            .padding(.top, 30)
                            
                            
                            
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        
        .alert(isPresented: $otpVm.forgotPasswordDataModel.isPresentingSuccess, content: {
            Alert(title: Text("Alert"), message: Text(otpVm.forgotPasswordDataModel.successMessage), dismissButton: .default(Text("Ok"), action: {
                otpView = true
            }))
        })
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}


extension ForgotPasswordView {
    
    private var phoneView: some View {
        ZStack {
            HStack {
                Image("ForgetPasswordLogoTwo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.leading)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("via SMS:")
                        .foregroundColor(Color("GrayFour"))
//                                            .foregroundColor(Color("Black"))
                        .font(.custom("Urbanist-Medium", size: 14))
                        .offset(y: 5)
                    
//                                        Text("+1 111*****99")
                    Text(phoneData)
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundColor(.black)
                    .padding(.vertical, 5)
                }
                .padding(.vertical)
//                                    .padding(.trailing, 100)
//                                    .background(.red)
             
                Spacer()
            }
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 32)
            .background(.white)
            
            .overlay(phone ? RoundedRectangle(cornerRadius: 32).stroke(Color("buttionGradientOne"), lineWidth: 3).cornerRadius(32) : RoundedRectangle(cornerRadius: 32).stroke(Color("GrayThree"), lineWidth: 2).cornerRadius(32))
        }
    }
    
    private var emailView: some View {
        ZStack {
            HStack {
                Image("ForgetPasswordLogoThree")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.leading)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("via Email:")
                        .foregroundColor(Color("GrayFour"))
                        .font(.custom("Urbanist-Medium", size: 14))
                        .offset(y: 5)
                    
//                                        Text("and****leygmail.com")
                    Text(emailData)
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                    
                    
                }
                .padding(.vertical)
                
             
                Spacer()
            }
            .padding(.vertical)
            
            .frame(width: UIScreen.main.bounds.width - 32)
            .background(.white)
            
            .overlay(email ? RoundedRectangle(cornerRadius: 32).stroke(Color("buttionGradientOne"), lineWidth: 3).cornerRadius(32) : RoundedRectangle(cornerRadius: 32).stroke(Color("GrayThree"), lineWidth: 2).cornerRadius(32))
            
        }
    }
    
}
