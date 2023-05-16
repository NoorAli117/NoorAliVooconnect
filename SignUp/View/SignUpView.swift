//
//  SignUpView.swift
//  Vooconnect
//
//  Created by Naveen Yadav on 04/04/23.
//

import SwiftUI

struct SignUpView: View {
    
    //    @State private var fullName: String = ""
    //    @State private var userName: String = ""
    //    @State private var firstName: String = ""
    //    @State private var lastName: String = ""
    //    @State private var email: String = ""
    //    @State private var phoneNo: String = ""
    //    @State private var password: String = ""
    //    @State private var confirmPassword: String = ""
        @State private var checkBox: Bool = false
        
        let termAndCondition = URL(string: "https://www.termsfeed.com/live/3e715dd9-7f54-4ff6-b06f-34c1c4cf9bd3")!
        
        @StateObject var signUpVM = SignUpViewModel()
        
        @FocusState private var focusedField: Field?
        private enum Field: Int, CaseIterable {
            case userName, firstName, lastName, email, phoneNo, password, confirmPassword
            }
        
        @Environment(\.presentationMode) var presentaionMode
        
        var body: some View {
            NavigationView {
                ZStack {
                    Color(#colorLiteral(red: 0.1294117647, green: 0.3019607843, blue: 0.6156862745, alpha: 1))
                        .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            Button {
                                presentaionMode.wrappedValue.dismiss()
                            } label: {
                                if #available(iOS 16.0, *) {
                                    Image(systemName: "arrow.backward")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.leading)
                                } else {
                                    // Fallback on earlier versions
                                    Image(systemName: "arrow.backward")
    //                                    .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.leading)
                                }
                            }
                            
                            Spacer()
                            
                            Text("Vooconnect".uppercased())
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .offset(x: -18)
                            Spacer()
                        }
                        
                        HStack{
                            //                    Spacer()
                            Text("Create New Account")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width, height: 50)
                                .background(Color(#colorLiteral(red: 0.8292957271, green: 0.3784125703, blue: 0.8705882353, alpha: 1)))
                        }
                        //            Spacer()
                        
                        ScrollView(showsIndicators: false) {
                            
                            VStack {
                                
                                HStack {
                                    Text("User Name:")
                                    Spacer()
                                }
                                CustomTextField(text: $signUpVM.signUpDataModel.userName, placeholder: "User Name")
                                    .focused($focusedField, equals: .userName)
                                
                                HStack {
                                    Text("First Name:")
                                    Spacer()
                                }
                                CustomTextField(text: $signUpVM.signUpDataModel.firstName, placeholder: "First Name")
                                    .focused($focusedField, equals: .firstName)
                                
                                HStack {
                                    Text("Last Name:")
                                    Spacer()
                                }
                                CustomTextField(text: $signUpVM.signUpDataModel.lastName, placeholder: "Last Name")
                                    .focused($focusedField, equals: .lastName)
                                
                                HStack {
                                    Text("Email:")
                                    Spacer()
                                }
                                CustomTextField(text: $signUpVM.signUpDataModel.email, placeholder: "Email")
                                    .focused($focusedField, equals: .email)
                                
                                HStack {
                                    Text("Phone Number:")
                                    Spacer()
                                }
                                CustomTextField(text: $signUpVM.signUpDataModel.phoneNumber, placeholder: "Phone Number")
                                    .focused($focusedField, equals: .phoneNo)
                                    .keyboardType(.decimalPad)
                                
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

                                VStack {
                                    HStack {
                                        Text("Password:")
                                        Spacer()
                                    }
                                    CustomTextField(text: $signUpVM.signUpDataModel.password, placeholder: "Password")
                                        .focused($focusedField, equals: .password)
                                    
                                    HStack {
                                        Text("Confirm Password:")
                                        Spacer()
                                    }
                                    CustomTextField(text: $signUpVM.signUpDataModel.confirmPassword, placeholder: "Confirm Password")
                                        .focused($focusedField, equals: .confirmPassword)
                                        .padding(.bottom, 30)
                                
                                    
    //                                HStack {
    //                                    Button {
    //                                        checkBox.toggle()
    //                                    } label: {
    //                                        ZStack{
    //                                            Image("squareTwo")
    //                                                .renderingMode(.template)
    //                                                .resizable()
    //                                                .frame(width: 30, height: 30)
    //                                                .scaledToFit()
    //                                                .foregroundColor(.blue)
    //                                            if checkBox == true {
    //                                                Image(systemName: "checkmark")
    //                                                    .frame(width: 10, height: 10)
    //                                                    .scaledToFill()
    //                                            } else {
    //
    //                                            }
    //                                        }
    //                                    }
    //
    //                                    Text("I accept the ")
    //                                        .foregroundColor(.white)
    //                                    Button {
    //
    //                                    } label: {
    //                                        Text("EULA")
    //                                    }
    //
    //                                    Text("for App access.")
    //                                        .foregroundColor(.white)
    //                                    Spacer()
    //                                }
    //                                .padding(.horizontal, 8)
    //                                .padding(.vertical, 4)
    //                                .background(.black)
    //                                .cornerRadius(6)
                                    
                                    
                                    HStack {
                                        
                                        Button {
                                            if(signUpVM.validationUserInputs()) {
                                                presentaionMode.wrappedValue.dismiss()
                                            }
    //                                        presentaionMode.wrappedValue.dismiss()
                                        } label: {
                                            Text("Sign Up")
                                                .foregroundColor(.white)
                                                .padding(.vertical)
                                                .frame(maxWidth: .infinity)
    //                                            .background(Color.red)
                                                .background(Color(#colorLiteral(red: 0.8292957271, green: 0.3784125703, blue: 0.8705882353, alpha: 1)))
                                                .cornerRadius(6)
                                            
                                        }
                                        .alert(isPresented: $signUpVM.signUpDataModel.isPresentingErrorAlert, content: {
                                            Alert(title: Text("Alert"), message: Text(signUpVM.signUpDataModel.errorMessage), dismissButton: .cancel(Text("Ok")))
                                        })
                                       
                                    }

                                    
                                    VStack {

                                            Text("By signing up, you agree with the")
    //                                    Spacer()
                                            HStack {
    //                                                Button(action: { }){ Text("Terms").underline() }
                                                if #available(iOS 16.0, *) {
                                                    Link("Terms of Service", destination: termAndCondition).underline()
                                                } else {
                                                    // Fallback on earlier versions
                                                    Link("Terms of Service", destination: termAndCondition)
                                                }
                                                Text(" and ")
    //                                                Button(action: { }){ Text("Privacy Policy").underline()}
                                                if #available(iOS 16.0, *) {
                                                    Link("Privacy Policy", destination: termAndCondition).underline()
                                                } else {
                                                    // Fallback on earlier versions
                                                    Link("Privacy Policy", destination: termAndCondition)
                                                }
                                                
    //                                            Spacer()
                                                
                                            }
                                        Spacer()

                                            }
                                    
                                    
    //                                HStack {
    //                                    Text("By signing up, you agree with the")
    //                                    Link("Terms of Service", destination: termAndCondition)
    //                                    Text("and")
    //                                    Link("Privacy Policy", destination: termAndCondition)
    //                                }
                                    
                                    HStack {
                                        
                                        Button {
                                            //                                        if(signUpVM.validationUserInputs()) {
                                            //                                            presentaionMode.wrappedValue.dismiss()
                                            //                                        }
                                            presentaionMode.wrappedValue.dismiss()
                                        } label: {
                                            
                                            Text("Already have an account?")
                                                .padding(.vertical)
                                                .frame(maxWidth: .infinity)
                                                .foregroundColor(.white)
                                                .background(Color.red)
                                            
                                                .cornerRadius(6)
                                            
                                        }
                                    }
    //                                padding(.top, 30)
                                        
          
                                    
    //                                .padding(.vertical)
    //                                .background(Color(#colorLiteral(red: 0.8292957271, green: 0.3784125703, blue: 0.8705882353, alpha: 1)))
    //                                .background(Color.red)
    //                                .cornerRadius(6)
                                    
                                    
                                    Text("Copyright ⓒ 2021 vooconnect.com")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12))
                                        .padding(.top, 40)
                                    
                                }
                                
                            
    //                    .statusBarHidden()
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationBarHidden(true)
    //            .navigationBarBackButtonHidden()
            }
        }
    }

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
