//
//  LoginView.swift
//  Vooconnect
//
//  Created by Vooconnect on 08/11/22.
//

import SwiftUI
import CountryPicker

struct LoginView: View {
    
    @State private var country: Country?
    @State private var showCountryPicker = false
    
    @StateObject var selectEmailOrPhone = SelectEmailOrPhone()
    
    @Binding var currentTab: String
    
    @Namespace var animation
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""
    @State private var bool: Bool = false
    @State private var rememberMe: Bool = false
    @State private var placeholder: String = ""
    @FocusState private var focused: Bool
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State private var createAccount: Bool = false
    @State private var otpView: Bool = false
    @State private var forgotPasswordView: Bool = false
    @State private var homeView: Bool = false
    @State private var otpViewTwo: Bool = false
    @State private var otpViewThree: Bool = false
    
    @StateObject var logInVM = LogInViewModel()
    
    @StateObject var signUpVM = SignUpViewModell()
    
    private enum Field: Int, CaseIterable {
            case phone, email, password
        }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                VStack {
                    
                    NavigationLink(destination: CreateYourAccountView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $createAccount) {
                            EmptyView()
                        }
//                    OTPView()
                    NavigationLink(destination: ChooseYourInterestView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $otpView) {
                            EmptyView()
                        }

                    NavigationLink(destination: ForgotPasswordView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $logInVM.logInDataModel.navigate) {
                            EmptyView()
                        }

                    NavigationLink(destination: HomePageView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $homeView) {
                            EmptyView()
                        }
                    
//                    MarketView()   OTPTwoView()
                   
                    
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
                            
                            Text("Login to your")
                                .foregroundColor(Color("Black"))
                                .font(.custom("Urbanist-Bold", size: 44))
                            
                            Text("Account")
                                .foregroundColor(Color("Black"))
                                .font(.custom("Urbanist-Bold", size: 44))
                            
                            HStack {
                                
                                Text("Login with Email")
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
                                
                                Text("Login with Phone")
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
                            .background(
                                LinearGradient(colors: [
                                    Color("YelloTwo"),
                                    Color("YelloOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            
                            .cornerRadius(20)
                            .padding(.bottom)
                            
                            if currentTab == "signUpWithEmail" {
//                                CustomTextField(text: $logInVM.logInDataModel.email, placeholder: "Email")
                                CustomeTextFieldFive(text: $logInVM.logInDataModel.email, placeholder: "Email", color: $logInVM.logInDataModel.errorEmial)
                                    .padding(.bottom)
                                
                                HStack {
                                    Text(logInVM.logInDataModel.emailError)
                                        .font(.custom("Urbanist-Regular", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                        .padding(.top, -10)
                                }
                                
                                HStack {
                                    Text(logInVM.logInDataModel.emialErrorMessage)
                                        .font(.custom("Urbanist-Regular", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                        .padding(.top, -15)
                                }
                                
//                                PasswordTextField(password: $logInVM.logInDataModel.password, hiddenn: $bool, placeholder: "Password")
                                
                                PasswordTextFieldTwo(password: $logInVM.logInDataModel.password, hiddenn: $bool, placeholder: "Password", color: $logInVM.logInDataModel.errorPassword)
                                    .padding(.bottom)
                                
//                                HStack {
//                                    Text(logInVM.logInDataModel.emialErrorMessage)
//                                        .font(.custom("Urbanist-Regular", size: 14))
//                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
//                                        .padding(.top, -15)
//                                }
                                
                                HStack {
                                    Text(logInVM.logInDataModel.passwordError)
                                        .font(.custom("Urbanist-Regular", size: 14))
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 30)
                                        .padding(.top, -15)
                                }
                                
                                Button {
                                    
                                    logInVM.logInDataModel.emialErrorMessage = ""
                                    logInVM.logInDataModel.errorEmial = false
                                    if(logInVM.validationUserInputss()) {
                                        logInVM.logInWithEmailApi()
                                        logInVM.logInDataModel.emailError = ""
                                        
                                        logInVM.logInDataModel.passwordError = ""
                                        logInVM.logInDataModel.errorPassword = false
                                        
                                    }
                                } label: {
                                    Text("Sign in")
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
//                                .alert(isPresented: $logInVM.logInDataModel.isPresentingErrorAlert, content: {
//                                    Alert(title: Text("Alert"), message: Text(logInVM.logInDataModel.errorMessage), dismissButton: .cancel(Text("Ok")))
//                                })
                                
//                                self.logInDataModel.errorMessage = "Invalid login credentials."
//                                self.logInDataModel.isPresentingErrorAlert = true
                                
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
                                .padding(.vertical)
                                
                            } else {
                                
                                VStack {
                                    
                                    ZStack {
                                        
                                        HStack {
                                            
                                            Button {
                                                showCountryPicker = true
                                            } label: {
                                                HStack {
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
                                            CustomTextFieldTwo(text: $logInVM.logInDataModel.phone, placeholder: "6474567896")
                                                .focused($focusedField, equals: .phone)
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
                                    
                                    .overlay((focusedField != nil) ? RoundedRectangle(cornerRadius: 10).stroke(logInVM.logInDataModel.errorPhone ? Color(.red) : Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: logInVM.logInDataModel.errorPhone ? 2 : 0).cornerRadius(10))
                                    
                                    .padding(.bottom)
                                    
                                    HStack {
                                        Text(logInVM.logInDataModel.phoneError)
                                            .font(.custom("Urbanist-Regular", size: 14))
                                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                            .padding(.top, -16)
                                    }
                                    
                                    HStack {
                                        Text(logInVM.logInDataModel.phoneErrorMessage)
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
//                                    otpView.toggle()
                                    logInVM.logInDataModel.phoneErrorMessage = ""
                                    
                                    logInVM.logInDataModel.phoneCode = ("+\(country?.phoneCode ?? "1")")
                                    if(logInVM.validationPhoneNumber()) {
                                        logInVM.LogInWithPhone()
                                        
                                        logInVM.logInDataModel.phoneError = ""
                                        
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
                                
//                                .alert(isPresented: $logInVM.logInDataModel.isPresentingErrorAlert, content: {
//                                    Alert(title: Text("Alert"), message: Text(logInVM.logInDataModel.errorMessage), dismissButton: .cancel(Text("Ok")))
//                                })
         
                                
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
                                .padding(.vertical)
                                
                            }
                            
                            
                            
                            if currentTab == "signUpWithEmail" {
                                
                                Button {
    //                                forgotPasswordView.toggle()
                                    if(logInVM.validateForgotPassword()) {
                                        logInVM.forgotPasswordApi()
                                        
                                        logInVM.logInDataModel.emailError = ""
                                    }
                                    
                                } label: {
                                    Text("Forgot the password?")
                                        .foregroundStyle(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .font(.custom("Urbanist-SemiBold", size: 16))
                                }
                                .padding(.bottom)
                                .padding(.top, -7)
                                
                            }
                            
                            HStack {
                                Text("Don't have an account?")
                                    .foregroundColor(Color("gray"))
                                    .font(.custom("Urbanist-Regular", size: 14))
                                
                                Button {
                                    createAccount.toggle()
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
                            
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    
//        logInDataModel.successMessage = ""
        .alert(isPresented: $logInVM.logInDataModel.isPresentingSuccess, content: {
            Alert(title: Text(logInVM.logInDataModel.successMessage), message: Text(""), dismissButton: .default(Text("Ok"), action: {
                if currentTab == "signUpWithEmail" {
                    if logInVM.logInDataModel.successMessage == "Login successfull." {
                        homeView.toggle()
                    } else if logInVM.logInDataModel.successMessage == "Your OTP is 1234"  {
                        
                        otpViewThree.toggle()
                        selectEmailOrPhone.email = true
                        
                    } else {
                        
                        otpView.toggle()
                        logInVM.logInDataModel.errorEmial = false
                        logInVM.logInDataModel.errorPassword = false
                        
                        logInVM.logInDataModel.emailError = ""
                        logInVM.logInDataModel.emialErrorMessage = ""
                        
                        logInVM.logInDataModel.passwordError = ""

                    }
                    
                    
                } else {
                    print("Navigateee==========")
                    signUpVM.getOtpPhoneApi()
                    
                    logInVM.logInDataModel.phoneErrorMessage = ""
                    logInVM.logInDataModel.errorPhone = false
                    
                    otpViewTwo = true
                }
                
            }))
        })
        
        NavigationLink(destination: OTPTwoView()
            .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $otpViewTwo) {
                EmptyView()
            }
        
        NavigationLink(destination: OTPView()
            .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $otpViewThree) {
                EmptyView()
            }
        
            .environmentObject(selectEmailOrPhone)
        
    }
}

struct LoginViewTwo_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentTab: .constant("signUpWithEmail"))
    }
}
