//
//  ForgotPasswordValidation.swift
//  Vooconnect
//
//  Created by Vooconnect on 18/11/22.
// , phone: String

import Foundation

struct ForgotPasswordValidationResult {
    var success: Bool = false
    var errorMessage: String?
    var email: String?
}

struct ForgotPasswordValidation {
    // validate the user inputs
    func forgotPasswordInputs(email: String) -> ForgotPasswordValidationResult {
        
        if(email.isEmpty) {
            return ForgotPasswordValidationResult(success: false, email: "Please enter your Email.")
        }
        
        if(isValidEmail(value: email) == false ) {
            return ForgotPasswordValidationResult(success: false, email: "Please enter a valid email address.")
        }
            
            return ForgotPasswordValidationResult(success: true, errorMessage: nil, email: nil)
        
    }
    
    private func isValidEmail(value: String) -> Bool
    {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
}
