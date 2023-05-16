//
//  SignUpValidationn.swift
//  Vooconnect
//
//  Created by Vooconnect on 11/11/22.
//

import Foundation

struct SignUpValidationResultt {
    var success: Bool = false
    var errorMessage: String?
    var email: String?
    var password: String?
}

struct SignUpValidationn {
    // validate the user inputs
    func validationInputs(email: String, password: String) -> SignUpValidationResultt {
        
        if(email.isEmpty) {
//            return SignUpValidationResultt(success: false, errorMessage: "Please enter your Email.")
            return SignUpValidationResultt(success: false, errorMessage: nil, email: "Please enter a valid email address.", password: nil)
        }
        
        if(isValidEmail(value: email) == false ) {
//            return SignUpValidationResultt(success: false, errorMessage: "Please enter a valid email address.")
            return SignUpValidationResultt(success: false, errorMessage: nil, email: "Please enter a valid email address.", password: nil)
        }
        
        if(password.isEmpty) {
//            return SignUpValidationResultt(success: false, errorMessage: "Please enter your Password.")
            return SignUpValidationResultt(success: false, errorMessage: nil, email: nil, password: "Please enter your Password.")
        }

        if(isValidPassword(value: password) == false) {
//            Password should be 8-32 characters long and contain at least 1 special character!
//            return SignUpValidationResultt(success: false, errorMessage: "Password should be at least 8 characters long max 32 characters and contains at least 1 special character.")
            return SignUpValidationResultt(success: false, errorMessage: nil, email: nil, password: "Password should be 8-32 characters long and contain at least 1 special character!")
        }
        
        return SignUpValidationResultt(success: true, errorMessage: nil)
        
    }
    
    // validate the email id ^[A-Za-z0-9_]+$
    private func isValidEmail(value: String) -> Bool
    {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
//    "^(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,32}$"
//    "(?=.*[@$!%*#?&_\-/:;\(\)\".,!'])[A-Za-z\\d@$!%*#?&_\-/:;\(\)\".,!']{8,32}"
//    "(?=.*[@$!%*#?&_-/:;()\".,!'])[A-Za-z\\d@$!%*#?&_-/:;()\".,!']{8,32}"
//    "^(?=.*[A-Za-z0-9])(?=.*[$@$!%*#_?&,/-])[A-Za-z\\d$@$!%*#_?&,/-]{8,32}$"
    
    private func isValidPassword(value: String) -> Bool {
        let  regex = try! NSRegularExpression(pattern: "^(?=.*[A-Za-z0-9])(?=.*[$@$!%*#_?&,/-])[A-Za-z\\d$@$!%*#_?&,/-]{8,32}$", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
}

struct SignUpPhoneValidationResult {
    var success: Bool = false
    var errorMessage: String?
    var phone: String?
}

struct SignUpPhoneValidation {
    // validate the user inputs
    func validationPhoneInputs(phone: String) -> SignUpPhoneValidationResult {
        
        if(phone.isEmpty) {
//            return SignUpPhoneValidationResult(success: false, errorMessage: "Please enter your valid Phone number.")
            return SignUpPhoneValidationResult(success: false, errorMessage: nil, phone: "Please enter a valid phone number.")
        }
        
        return SignUpPhoneValidationResult(success: true, errorMessage: nil)
    }
    
}
