//
//  ForgotPasswordViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 18/11/22.
//

import Foundation
//import Combine

struct ForgotPasswordDataModel {
   
    var email: String = String()
    var password: String = String()
    var confirmPassword: String = String()
    
    var phone: String = String()
    var phoneCode: String = String()
    
    var successMessage: String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErrorAlert: Bool = false
    var isPresentingSuccess: Bool = false
    
    var passwordError: String = String()
    var confirmPasswordError: String = String()
    
    var errorPassword: Bool = false
    var errorConfirmPassword: Bool = false
    
    var emptyOTP: String = String()
    var invalidOTP: String = String()
    
    var errorEmptyOTP: Bool = false
    var errorInvalidOTP: Bool = false
    
    
}

class ForgotPasswordViewModel: ObservableObject {
    
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 4){
        didSet{
            // Checking if OTP is Pressed
            for index in 0..<4{
                if otpFields[index].count == 4{
                    otpText = otpFields[index]
                    otpFields[0] = ""
                    
                    // Updating All TextFields with Value
                    for item in otpText.enumerated(){
                        otpFields[item.offset] = String(item.element)
                    }
                }
            }
        }
    }

    
    @Published var forgotPasswordDataModel: ForgotPasswordDataModel = ForgotPasswordDataModel()
    private let createNewPasswordValidation = CreateNewPasswordValidation()
//    private let signUpPhoneValidation = SignUpPhoneValidation()
    private let signUpResource = SignUpResource()
    private let sendOTPtoMailResource = SendOTPtoMailResource()
    private let optResource = OTPResource()
    private let otpResourceForgotPass = OTPResourceForgotPass()
    
    // call get OTP API
    func forgotGetOtpEmailApi() {
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = SendOTPRequest(uuid: uuid)
        
        sendOTPtoMailResource.hittingSendOTPtoMail(sendOTPRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    
                    self.forgotPasswordDataModel.successMessage = "Your OTP is 1234"
                    self.forgotPasswordDataModel.isPresentingSuccess = true
                    
                    print("Success===============")
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    
                    print("Failure===============")
                }
                
            }
        }
    }
    
    // call get OTP API
    func forgotGetOtpPhoneApi() {
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = SendOTPRequest(uuid: uuid)
        
        sendOTPtoMailResource.hittingSendOTPtoPhone(sendOTPRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    
                    self.forgotPasswordDataModel.successMessage = "Your OTP is 1234"
                    self.forgotPasswordDataModel.isPresentingSuccess = true
                    print("Success===============")
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Failure===============")
                }
                
            }
        }
    }
    
    func forgotVerifyOTPApi() {
        otpText = self.otpFields.reduce("") { partialResult, value in
            partialResult + value
        }
        print("OTPTEXT======",otpText)
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = OTPRequest(uuid: uuid, otp: otpText, type: "email")
        
        print(request)
       
        optResource.hittingOTPApi(signupRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    self.forgotPasswordDataModel.successMessage = "OTP verified."
                    self.forgotPasswordDataModel.isPresentingSuccess = true
                    self.forgotPasswordDataModel.navigate = true
                }
                
                print("Sucesss=====")
            } else {
                print("Failure=====")
                DispatchQueue.main.async {
                    
                    if sussesMessage == "Invalid OTP." {
                        
                        self.forgotPasswordDataModel.emptyOTP = "Invalid OTP."
//                             self.otpDataModell.isPresentingErrorAlert = true
                        
                    } else if sussesMessage == "Please enter your otp." {
                        
                        self.forgotPasswordDataModel.emptyOTP = "Please enter your OTP."
//                             self.otpDataModell.isPresentingErrorAlert = true
                        
                    } else {
                        self.forgotPasswordDataModel.successMessage = sussesMessage ?? "sjdhbfjsdbf"
                        self.forgotPasswordDataModel.isPresentingSuccess = true
                        print(sussesMessage ?? "sjdhbfjsdbf")
                    }
                    
                    
                    
                }
            }
        }
        
    }
    
    
    // validate the user inputs
    func createNewPasswordValidationInputs() -> Bool {
        let result = createNewPasswordValidation.CreateNewPasswordInputs(password: forgotPasswordDataModel.password, confirmPassword: forgotPasswordDataModel.confirmPassword)
        
        if(result.success == false) {
//            forgotPasswordDataModel.errorMessage = result.errorMessage ?? "error occured"
            
            forgotPasswordDataModel.passwordError = result.password ?? ""
            if forgotPasswordDataModel.passwordError != "" {
                forgotPasswordDataModel.errorPassword = true
            } else {
                forgotPasswordDataModel.errorPassword = false
            }
            
            forgotPasswordDataModel.confirmPasswordError = result.confirmPassword ?? ""
            if forgotPasswordDataModel.confirmPasswordError != "" {
                forgotPasswordDataModel.errorConfirmPassword = true
            } else {
                forgotPasswordDataModel.errorConfirmPassword = false
            }
            
            forgotPasswordDataModel.isPresentingErrorAlert = true
            
            return false
        }
        return true
    }
    
    func createNewPasswordApi() {
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = CreateNewPasswordRequest(uuid: uuid, password: forgotPasswordDataModel.password, confirm_password: forgotPasswordDataModel.confirmPassword)
        
        otpResourceForgotPass.hittingCreateNewPasswordApi(createNewPasswordRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    self.forgotPasswordDataModel.successMessage = "OTP verified."
                    self.forgotPasswordDataModel.isPresentingSuccess = true
                    self.forgotPasswordDataModel.navigate = true
                }
                
                print("Sucesss=====")
            } else {
                print("Failure=====")
                DispatchQueue.main.async {
                    
//                    if sussesMessage == "Failed" {
                        self.forgotPasswordDataModel.errorMessage = "Invalid OTP."
                        self.forgotPasswordDataModel.isPresentingErrorAlert = true
//                    } else {
//                        self.forgotPasswordDataModel.successMessage = sussesMessage ?? "sjdhbfjsdbf"
//                        self.forgotPasswordDataModel.isPresentingSuccess = true
//                    }
                    
                }
            }
        }
        
        
    }
    
    
}
