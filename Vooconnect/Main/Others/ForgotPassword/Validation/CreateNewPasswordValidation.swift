//
//  CreateNewPasswordValidation.swift
//  Vooconnect
//
//  Created by Vooconnect on 18/11/22.
//

import Foundation

struct CreateNewPasswordValidationResult {
    var success: Bool = false
    var errorMessage: String?
    var password: String?
    var confirmPassword: String?
}

struct CreateNewPasswordValidation {
    // validate the user inputs
    func CreateNewPasswordInputs(password: String, confirmPassword: String) -> CreateNewPasswordValidationResult {
        
        if(password.isEmpty) {
            return CreateNewPasswordValidationResult(success: false, password: "Please enter your Password.")
        }
        
        if(isValidPassword(value: password) == false) {
            return CreateNewPasswordValidationResult(success: false, password: "Password should be 8-32 characters long and contain at least 1 special character!")
        }
        
        if(confirmPassword.isEmpty) {
            return CreateNewPasswordValidationResult(success: false, confirmPassword: "Please enter the Confirm Password.")
        }
        
        if(password != confirmPassword) {
            return CreateNewPasswordValidationResult(success: false, confirmPassword: "Password and Confirm Password should be matched.")
        }
            
            return CreateNewPasswordValidationResult(success: true, errorMessage: nil, password: nil, confirmPassword: nil)
        
    }
    
    private func isValidPassword(value: String) -> Bool {
        let  regex = try! NSRegularExpression(pattern: "^(?=.*[A-Za-z0-9])(?=.*[$@$!%*#_?&])[A-Za-z\\d$@$!%*#_?&]{8,32}$", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
    
}
