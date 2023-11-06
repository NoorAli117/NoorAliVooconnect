//
//  OTPView.swift
//  Vooconnect
//
//  Created by Vooconnect on 08/11/22.
//

import SwiftUI

struct OTPView: View {
    
    @StateObject var otpModel: OTPViewModel = OTPViewModel()
    // MARK: TextField FocusState
    @FocusState var activeField: OTPField?
    @Environment(\.presentationMode) var presentaionMode
    @State private var chooseYourInterest: Bool = false
    @State private var homeView: Bool = false
    
//    @StateObject var otpViewModel: OTPViewModel = OTPViewModel()
    
    @EnvironmentObject var selectEmailOrPhone: SelectEmailOrPhone
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Color.white
                    .ignoresSafeArea()
       
                VStack {
                    
                    NavigationLink(destination: ChooseYourInterestView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $chooseYourInterest) {
                            EmptyView()
                        }
                    
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
                        Spacer()
                    }
                    .padding(.leading)
                    
                    ScrollView {
                        
                        GifImage("earthvoo")
                            .frame(width: 300, height: 260)
                        
                        Text("Enter Your OTP")
                            .foregroundColor(.black)
                            .font(.custom("Urbanist-Bold", size: 24))
                            .padding(.top)
                            .padding(.bottom, 50)
                        
                        VStack {
                            OTPField()
                        }
                        .onChange(of: otpModel.otpFields) { newValue in
                            OTPCondition(value: newValue)
                        }
                        .padding(.bottom, 20)
                        
                        HStack {
                            Text(otpModel.otpDataModell.emptyOTP)
                                .font(.custom("Urbanist-Regular", size: 14))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                                .padding(.top, -15)
                        }
                        
                        Button {
//                            if selectEmailOrPhone.email == true {
                                otpModel.emailOTPApi()
//                            } else {
//                                otpModel.phoneOTPApi()
//                            }
                            
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
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
            
        }
        
        .alert(isPresented: $otpModel.otpDataModell.isPresentingSuccess, content: {
            Alert(title: Text("Alert"), message: Text(otpModel.otpDataModell.successMessage), dismissButton: .default(Text("Ok"), action: {
                if otpModel.otpDataModell.successMessage == "OTP verified" {
                    homeView = true
                } else {
                    chooseYourInterest = true
                    otpModel.otpDataModell.emptyOTP = ""
                }
                print("Navigateee==========")
                
            }))
        })
        
    }
    
    // MARK: Condition For Custom OTP Field $ Limiting Only one Text
    func OTPCondition(value: [String]) {
        
        // Moving Next Field If Current Field Type
        for index in 0..<6 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        
        // Moving Back if Current is Empty And Previous is not Empty
        for index in 1..<6 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        
        // Limiting Only one Text
        for index in 0..<6 {
            if value[index].count > 1 {
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
        
        // MARK: Custom OTP TextField
        @ViewBuilder
        func OTPField()->some View {
            HStack(spacing: 14) {
                ForEach(0..<6, id: \.self){ index in
                    VStack(spacing: 8) {
                        TextField("", text: $otpModel.otpFields[index])
                            .foregroundColor(.black)
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .multilineTextAlignment(.center)
                            .focused($activeField,equals: activeStateForIndex(index: index))
                        
                            .padding()
                                                
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
            case 3: return .field4
            case 4: return .field5
            default: return .field6
            }
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}

// MARK: FocusState Enum
enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}
