//
//  CreateYourAccountView.swift
//  Vooconnect
//
//  Created by Vooconnect on 07/11/22.
//

import SwiftUI
import CountryPicker

class SelectEmailOrPhone: ObservableObject {
    @Published var email: Bool = false
}

struct CreateYourAccountView: View {
    
    @State private var country: Country?
    @State private var showCountryPicker = false
        
    @StateObject var selectEmailOrPhone = SelectEmailOrPhone()
    
    @State private var color: Bool = false
    
    @State var currentTab = "signUpWithEmail"
    @Namespace var animation
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""
    @State private var bool: Bool = false
    @State private var rememberMe: Bool = false
    @State private var placeholder: String = ""
    @FocusState private var focused: Bool
    
    @State var emailOrPhone: String = "signUpWithEmail"
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State private var createAccount: Bool = false
    @State private var logInView: Bool = false
    
    @StateObject var signUpVM = SignUpViewModell()
    
    private enum Field: Int, CaseIterable {
            case otp, shares
        }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                VStack {
                    
                    NavigationLink(destination: OTPView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $createAccount) {
                            EmptyView()
                        }
                    
                    NavigationLink(destination: LoginView(currentTab: $emailOrPhone)
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $logInView) {
                            EmptyView()
                        }
                    
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    
                    ScrollView {
                        
                        VStack {
                            
                            GifImage("earthvoo")
                                .frame(width: 300, height: 260)
//                            .padding(.top, 50)
                            
                            Text("Create your Account")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("Black"))
                                .font(.custom("Urbanist-Bold", size: 44))
                            
                            HStack {
                                
                                Text("Sign up with Email")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .padding(.vertical, 18)
                                    .padding(.horizontal, 10)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 16)
                                    .background(
                                        ZStack {
                                            if currentTab == "signUpWithEmail" {
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    .cornerRadius(20)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            }
                                        }
                                    )
                                
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                                            currentTab = "signUpWithEmail"
                                        }
                                    }
                                
                                Text("Sign up with Phone")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .padding(.vertical, 18)
                                    .padding(.horizontal, 10)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 16)
                                    .background(
                                        ZStack {
                                            if currentTab == "signUpWithPhone" {
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    .cornerRadius(20)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            }
                                        }
                                        
                                    )
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                                            currentTab = "signUpWithPhone"
                                        }
                                    }
                                
                            }
                            .frame(maxWidth: .infinity)
//                            .background(.orange)
                            .background(
                                LinearGradient(colors: [
                                    Color("YelloTwo"),
                                    Color("YelloOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(20)
                            .padding(.bottom)
                            
                            if currentTab == "signUpWithEmail" {
                                
                                CustomeTextFieldFive(text: $signUpVM.signUpDataModell.email, placeholder: "Email", color: $signUpVM.signUpDataModell.errorEmial)
                                    .padding(.bottom)
                                
                                HStack {
                                    Text(signUpVM.signUpDataModell.emailError)
                                        .font(.custom("Urbanist-Regular", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                        .padding(.top, -10)
                                }
                                
                                HStack {
                                    Text(signUpVM.signUpDataModell.emialErrorMessage)
                                        .font(.custom("Urbanist-Regular", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                        .padding(.top, -15)
                                }
                                
                                PasswordTextFieldTwo(password: $signUpVM.signUpDataModell.password, hiddenn: $bool, placeholder: "Password", color: $signUpVM.signUpDataModell.errorPassword)
                                
//                                    .focused($focused)
//                                    .padding(.bottom)
                                
                                HStack {
                                    Text(signUpVM.signUpDataModell.passwordError)
                                        .font(.custom("Urbanist-Regular", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 30)
                                }
                                
                                Button {
                                    signUpVM.signUpDataModell.emialErrorMessage = ""
                                    if(signUpVM.validationUserInputss()) {
                                        signUpVM.signUpApi()
//                                        presentaionMode.wrappedValue.dismiss()
                                        signUpVM.signUpDataModell.emailError = ""
                                        signUpVM.signUpDataModell.passwordError = ""
                                        signUpVM.signUpDataModell.errorPassword = false
                                    }
                                    
                                } label: {
                                    Text("Sign up")
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
//                                .alert(isPresented: $signUpVM.signUpDataModell.isPresentingErrorAlert, content: {
//                                    Alert(title: Text("Alert"), message: Text(signUpVM.signUpDataModell.errorMessage), dismissButton: .cancel(Text("Ok")))
//                                })
                                
                               
                                
                            } else {
                                VStack {
                                    
                                    ZStack {
                                        
                                        HStack {
                                            
                                            Button {
                                                showCountryPicker = true
                                            } label: {
                                                HStack {
                                                    
//                                                    Image("flag")
//                                                        .resizable()
                                                    
                                                    Text(country?.isoCode.getFlag() ?? "US".getFlag())
                                                        .font(.system(size: 30))
                                                        .frame(width: 25, height: 19)
                                                    Image("DownArrow")
                                                    
                                                }
                                            }
                                            .sheet(isPresented: $showCountryPicker) {
                                                CountryPicker(country: $country)
                                            }
                                            
                                            Text("+\(country?.phoneCode ?? "1")")
                                                .foregroundColor(.black)

                                            CustomTextFieldTwo(text: $signUpVM.signUpDataModell.phone, placeholder: "6474567896")
                                                .focused($focusedField, equals: .otp)
                                                .keyboardType(.numberPad)
                                                .foregroundColor(.black)
                                                .accentColor(.black)
                                            
                                            
                                            
                                        }
                                        .padding(.horizontal)
                                    }
                                    .padding(.vertical)
//                                    .background(Color("txtFieldBackgroun"))
                                    .background((focusedField != nil) ? Color(#colorLiteral(red: 0.9566952586, green: 0.925486505, blue: 1, alpha: 1)) : Color("txtFieldBackgroun"))
                                    .cornerRadius(10)
                                    
                                    .overlay((focusedField != nil) ? RoundedRectangle(cornerRadius: 10).stroke(signUpVM.signUpDataModell.errorPhone ? Color(.red) : Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: signUpVM.signUpDataModell.errorPhone ? 2 : 0).cornerRadius(10))
                                    
                                    .padding(.bottom)
                                    
                                    HStack {
                                        Text(signUpVM.signUpDataModell.phoneError)
                                            .font(.custom("Urbanist-Regular", size: 14))
                                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                            .padding(.top, -16)
                                    }
                                    
                                    HStack {
                                        Text(signUpVM.signUpDataModell.phoneErrorMessage)
                                            .font(.custom("Urbanist-Regular", size: 14))
                                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                            .padding(.top, -16)
                                    }
                                    
                                }
                                
                                .toolbar(content: {
                                    ToolbarItem(placement: .keyboard) {
                                        Spacer()
                                    }
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            focusedField = nil
                                        }
                                    }
                                })
                                
                                Button {
                                    
                                    signUpVM.signUpDataModell.phoneErrorMessage = ""
                                    
                                    signUpVM.signUpDataModell.phoneCode = ("+\(country?.phoneCode ?? "1")")
                                    if(signUpVM.validationPhoneNumber()) {
                                        signUpVM.signUpWithPhone()
                                        
                                        signUpVM.signUpDataModell.phoneError = ""
                                        
                                    }
                                    
                                } label: {
                                    Text("Send OTP")
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
                                
//                                .alert(isPresented: $signUpVM.signUpDataModell.isPresentingErrorAlert, content: {
//                                    Alert(title: Text("Alert"), message: Text(signUpVM.signUpDataModell.errorMessage), dismissButton: .cancel(Text("Ok")))
//                                })
                                
                            }
                            
                            
                            
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
                            .padding(.top)
                            
                            HStack {
                                Text("Already have an account?")
                                    .foregroundColor(Color("gray"))
                                    .font(.custom("Urbanist-Regular", size: 14))
                                
                                Button {
                                    logInView.toggle()
                                } label: {
                                    Text("Sign in")
                                        .foregroundStyle(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .font(.custom("Urbanist-SemiBold", size: 14))
                                }

                                
                            }
                            .padding(.top, 8)
                            .padding(.bottom)
                            
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
            
        }
        
        .alert(isPresented: $signUpVM.signUpDataModell.isPresentingSuccess, content: {
            Alert(title: Text("Alert"), message: Text(signUpVM.signUpDataModell.successMessage), dismissButton: .default(Text("Ok"), action: {
                if currentTab == "signUpWithEmail" {
                    print("Navigateee==========")
                    signUpVM.getOtpEmailApi()
                    selectEmailOrPhone.email = true
                    
                    signUpVM.signUpDataModell.errorEmial = false
                    signUpVM.signUpDataModell.errorPassword = false
                    
                    signUpVM.signUpDataModell.emailError = ""
                    signUpVM.signUpDataModell.emialErrorMessage = ""
                    
                    signUpVM.signUpDataModell.passwordError = ""
                    
                } else {
                    print("Navigateee==========")
                    signUpVM.getOtpPhoneApi()
                    
                    signUpVM.signUpDataModell.phoneError = ""
                    signUpVM.signUpDataModell.phoneErrorMessage = ""
                    
                    signUpVM.signUpDataModell.errorPhone = false
                    
                }
                createAccount = true
            }))
        })
        .environmentObject(selectEmailOrPhone)
    }
}

struct CreateYourAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateYourAccountView()
    }
}
