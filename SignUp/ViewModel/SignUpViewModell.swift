//
//  SignUpViewModell.swift
//  Vooconnect
//
//  Created by Vooconnect on 11/11/22.
//

import Foundation
import CountryPicker

struct SignUpDataModell {
    
    var email: String = String()
    var password: String = String()
    
    var phone: String = String()
    var phoneCode: String = String()
    
    var successMessage: String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var otpPageNavigate: Bool = false
    var isPresentingErrorAlert: Bool = false
    var isPresentingSuccess: Bool = false
    
    var errorEmial: Bool = false
    var errorPassword: Bool = false
    
    var errorPhone: Bool = false
    
    var emailError: String = String()
    var passwordError: String = String()
    var emialErrorMessage: String = String()
    
    var phoneError: String = String()
    var phoneErrorMessage: String = String()
    
    var isPresentingSuccessHome: Bool = false
    
}

class SignUpViewModell: ObservableObject {
    @Published var signUpDataModell: SignUpDataModell = SignUpDataModell()
    private let signUpValidationn = SignUpValidationn()
    private let signUpPhoneValidation = SignUpPhoneValidation()
    private let signUpResource = SignUpResource()
    private let sendOTPtoMailResource = SendOTPtoMailResource()
    
    // validate the user inputs
    func validationUserInputss() -> Bool {
        let result = signUpValidationn.validationInputs(email: signUpDataModell.email, password: signUpDataModell.password)
        
        if(result.success == false) {
            
            //            signUpDataModell.errorMessage = result.errorMessage ?? "error occured"
            
            signUpDataModell.emailError = result.email ?? ""
            if signUpDataModell.emailError != "" {
                signUpDataModell.errorEmial = true
            } else {
                signUpDataModell.errorEmial = false
            }
            
            signUpDataModell.passwordError = result.password ?? ""
            if signUpDataModell.passwordError != "" {
                signUpDataModell.errorPassword = true
            }
            
            signUpDataModell.isPresentingErrorAlert = true
            
            return false
        }
        return true
    }
    
    // validate the user inputs Phone
    func validationPhoneNumber() -> Bool {
        let result = signUpPhoneValidation.validationPhoneInputs(phone: signUpDataModell.phone)
        
        if(result.success == false) {
//            signUpDataModell.errorMessage = result.errorMessage ?? "error occured"
            
            signUpDataModell.phoneError = result.phone ?? ""
            if signUpDataModell.phoneError != "" {
                signUpDataModell.errorPhone = true
            }
            
            signUpDataModell.isPresentingErrorAlert = true
            
            return false
        }
        return true
    }
    
    
    // call the email api
    func signUpApi() {
        
        let request = SignUpRequest(email: signUpDataModell.email, password: signUpDataModell.password, remember_me: "no")
        
        signUpResource.hittingSignupApi(signupRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    self.signUpDataModell.successMessage = "Your OTP is 1234"
                    self.signUpDataModell.isPresentingSuccess = true
                    self.signUpDataModell.navigate = true
                    
                }
                
            } else {
                DispatchQueue.main.async {
//                    self.signUpDataModell.emialErrorMessage = "This email address is already registered!"
//                    self.signUpDataModell.errorEmial = true
//                    self.signUpDataModell.isPresentingErrorAlert = true
                    
                    if sussesMessage == "Incorrect password!" {
                        self.signUpDataModell.passwordError = sussesMessage ?? "Incorrect password!"
                        self.signUpDataModell.errorPassword = true
                    } else if sussesMessage == "This email address is already registered!" {
                        self.signUpDataModell.emialErrorMessage = sussesMessage ?? "This email address is already registered!"
                        self.signUpDataModell.errorEmial = true
                    } else {
                        self.signUpDataModell.passwordError = sussesMessage ?? "This email address is already registered!"
                        self.signUpDataModell.errorPassword = true
                    }
                    
                }
                
            }
        }
        
    }
    
    //call the phone api
    func signUpWithPhone() {
        
        let request = SignUpRequestPhone(phone: signUpDataModell.phoneCode + signUpDataModell.phone, password: "123124313", remember_me: "no")
        
        print("PHONE++++++++++++++===", request)
        
        signUpResource.hittingSignUpPhoneApi(signupRequest: request) { isSuccess, sussesMessage in
            
            if isSuccess {
                DispatchQueue.main.async {
                    self.signUpDataModell.successMessage = "Your OTP is 1234"
                    self.signUpDataModell.isPresentingSuccess = true
                    self.signUpDataModell.navigate = true
                    
                }
                
            } else {
                DispatchQueue.main.async { // "Please enter your valid phone number!"
                    // "This phone number is already registered!"
                    self.signUpDataModell.phoneErrorMessage = sussesMessage ?? "Please enter your valid phone number!"
                    self.signUpDataModell.errorPhone = true
                    self.signUpDataModell.isPresentingErrorAlert = true
                    
                }
                
            }
        }
        
    }
    
    
    
    // call get OTP API
    func getOtpEmailApi() {
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = SendOTPRequest(uuid: uuid)
        
        sendOTPtoMailResource.hittingSendOTPtoMail(sendOTPRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    
//                    self.signUpDataModell.successMessage = "Your OTP is 1234"
//                    self.signUpDataModell.isPresentingSuccess = true
//                    self.signUpDataModell.navigate = true
                    
                    print("Success===============")
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    
                    print("Failure===============")
                    
//                    self.signUpDataModell.errorMessage = "The email has already been taken."
//                    self.signUpDataModell.isPresentingErrorAlert = true
                    
                }
                
            }
        }
    }
    
    // call get OTP API
    func getOtpPhoneApi() {
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = SendOTPRequest(uuid: uuid)
        
        sendOTPtoMailResource.hittingSendOTPtoPhone(sendOTPRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    
//                    self.signUpDataModell.successMessage = "Your OTP is 1234"
//                    self.signUpDataModell.isPresentingSuccess = true
//                    self.signUpDataModell.otpPageNavigate = true
                    
                    print("Success===============")
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    
                    print("Failure===============")
                    
//                    self.signUpDataModell.errorMessage = "The email has already been taken."
//                    self.signUpDataModell.isPresentingErrorAlert = true
                    
                }
                
            }
        }
    }
    
}

