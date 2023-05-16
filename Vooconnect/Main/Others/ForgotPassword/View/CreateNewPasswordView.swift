//
//  CreateNewPasswordView.swift
//  Vooconnect
//
//  Created by Vooconnect on 15/11/22.
//

import SwiftUI

struct CreateNewPasswordView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    @State private var password = ""
    @State private var confirmPasswoed = ""
    @State private var bool: Bool = false
    @State private var rememberMe: Bool = false
    @State private var isLoaderPresented = false
    @State private var homeView = false
    
    @StateObject private var createNewPasswordVM = ForgotPasswordViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if isLoaderPresented == true {
                    Color(#colorLiteral(red: 0.3257557154, green: 0.3457402587, blue: 0.379650116, alpha: 1))
//                        .opacity(5.0)
                        .ignoresSafeArea()
                } else {
                    Color(.white)
                        .ignoresSafeArea()
                }
                
                VStack {
                    
                    NavigationLink(destination: HomePageView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $homeView) {
                            EmptyView()
                        }
                    
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Create New Password")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
//                    .padding(.leading)
                    
                    ScrollView {
                        
                        Image("CreateNewPssworLogo")
                            .padding(.top, 40)
                            .padding(.bottom, 40)
                        
                        VStack {
                            
                            HStack {
                                Text("Create Your New Password")
                                    .font(.custom("Urbanist-Medium", size: 18))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            
                            PasswordTextField(password: $createNewPasswordVM.forgotPasswordDataModel.password, hiddenn: $bool, placeholder: "Password", color: $createNewPasswordVM.forgotPasswordDataModel.errorPassword)
                                .padding(.bottom)
                            
                            HStack {
                                Text(createNewPasswordVM.forgotPasswordDataModel.passwordError)
                                    .font(.custom("Urbanist-Regular", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .padding(.top, -10)
                            }
                            
                            PasswordTextField(password: $createNewPasswordVM.forgotPasswordDataModel.confirmPassword, hiddenn: $bool, placeholder: "Confirm Password", color: $createNewPasswordVM.forgotPasswordDataModel.errorConfirmPassword)
                                .padding(.bottom)
                            
                            HStack {
                                Text(createNewPasswordVM.forgotPasswordDataModel.confirmPasswordError)
                                    .font(.custom("Urbanist-Regular", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .padding(.top, -10)
                            }
                            
                            Button {
                                if(createNewPasswordVM.createNewPasswordValidationInputs)() {
                                    createNewPasswordVM.createNewPasswordApi()
                                    isLoaderPresented.toggle()
                                    delayText()
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
                            .padding(.bottom)
                            
//                            .alert(isPresented: $createNewPasswordVM.forgotPasswordDataModel.isPresentingErrorAlert, content: {
//                                Alert(title: Text("Alert"), message: Text(createNewPasswordVM.forgotPasswordDataModel.errorMessage), dismissButton: .cancel(Text("Ok")))
//                            })

//                            .task(delayText)
                            
                            HStack {
                                Button {
                                    rememberMe.toggle()
                                } label: { // CheckBox
                                    Image(rememberMe ? "CheckBox" : "RectanglePurpal")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                }
                                
                                Text("Remember me")
                                    .font(.custom("Urbanist-SemiBold", size: 14))
                                    .foregroundColor(Color("Black"))
                                
                            }
                            
                        }
                        .padding(.horizontal,10)
                    }

                }
                .padding(.horizontal)
                
            }
            .navigationBarHidden(true)
        }
    
        .popup(isPresented: isLoaderPresented, alignment: .center, content: PopUpViewTwo.init)
        
    }
    
    // Delay
    private func delayText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoaderPresented = false
            homeView = true
        }
        
    }
    
}

struct CreateNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPasswordView()
    }
}
