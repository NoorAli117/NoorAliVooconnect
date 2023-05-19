//
//  ConnectWithEmailAndPhoneView.swift
//  Vooconnect
//
//  Created by Vooconnect on 07/11/22.
//

import SwiftUI

struct ConnectWithEmailAndPhoneView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var signUp: Bool = false
    @State private var logIn: Bool = false
    
    @State var emailOrPhone: String = ""
    
    @Binding var isFromSwitchProfile: Bool
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .topTrailing) {
                
                Color(.white)
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack {
                        
                        NavigationLink(destination: LoginView(currentTab: $emailOrPhone)
                            .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $logIn) {
                                EmptyView()
                            }
                        
                        NavigationLink(destination: CreateYourAccountView()
                            .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $signUp) {
                                EmptyView()
                            }
                        
                        GifImage("earthvoo")
                            .frame(width: 300, height: 300)
                            .padding(.top, 50)
                        
                        Text("Connect With")
                            .foregroundColor(Color("Black"))
                            .font(.custom("Urbanist-Bold", size: 44))
                            .padding(.top, -10)
                        
                        Button {
                            emailOrPhone = "signUpWithEmail"
                            logIn.toggle()
                        } label: {
                            Text("Sign in with Email")
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
                        .padding(.top, 20)
                        
                        
                        HStack {
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .foregroundColor(Color("grayOne"))
                            Text("or")
                                .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 1)))
//                                .opacity(0.7)
                                .font(.custom("Urbanist-SemiBold", size: 18))
                                .padding(.horizontal)
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .foregroundColor(Color("grayOne"))
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        
                        Button {
//                            createAccount.toggle()
                            emailOrPhone = "signUpWithPhone"
                            logIn.toggle()
                            
//                            selectEmailOrPhone.currentTab = ""
                            
                        } label: {
                            Text("Sign in with Phone")
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
                        Spacer()
                        HStack {
                            Text("Don't have an account? ")
                                .foregroundColor(Color("gray"))
                                .font(.custom("Urbanist-Regular", size: 14))
                            Button {
                                signUp.toggle()
                            } label: {
                                Text("Sign up")
                                    .foregroundStyle(
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .font(.custom("Urbanist-SemiBold", size: 14))
                            }
                            
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal)
                    .navigationBarHidden(true)
                }
                
                if isFromSwitchProfile{
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("CloseCP")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding([.top, .trailing], 24)
                }
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

