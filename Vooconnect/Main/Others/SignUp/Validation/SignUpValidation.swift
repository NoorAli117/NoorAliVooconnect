//
//  SignUpValidation.swift
//  Vooconnect
//
//  Created by Vooconnect on 03/11/22.
//

import Foundation

struct SignUpValidationResult {
    var success: Bool = false
    var errorMessage: String?
}


struct SignUpValidation {
    
    // validate the user inputs
    func validationInputs(userName: String, firstName: String, lastName: String, email: String, phoneNumber: String, password: String, confirmPassword: String) -> SignUpValidationResult {
        
        if(userName.isEmpty) {
            return SignUpValidationResult(success: false, errorMessage: "Please enter your User Name.")
        }
        
        if(isValidUserName(value: userName) == false ) {
            return SignUpValidationResult(success: false, errorMessage: "Username only allowed underscore (_) and period (.) a-zA-Z0-9.")
        }

        if(firstName.isEmpty) {
            return SignUpValidationResult(success: false, errorMessage: "Please enter your First Name.")
        }
        
        if(isValidFirstName(value: firstName) == false) {
            return SignUpValidationResult(success: false, errorMessage: "Firstname No special characters allowed and at least 2 letters long.")
        }
        
        if(lastName.isEmpty) {
            return SignUpValidationResult(success: false, errorMessage: "Please enter your Last Name.")
        }
        
        if(isValidFirstName(value: lastName) == false) {
            return SignUpValidationResult(success: false, errorMessage: "Lastname No special characters allowed and at least 2 letters long.")
        }

        if(email.isEmpty) {
            return SignUpValidationResult(success: false, errorMessage: "Please enter your Email.")
        }
        
        if(isValidEmail(value: email) == false ) {
            return SignUpValidationResult(success: false, errorMessage: "Please enter a valid email address.")
        }

        if(phoneNumber.isEmpty) {
            return SignUpValidationResult(success: false, errorMessage: "Please enter your Phone Number.")
        }

        if(password.isEmpty) {
            return SignUpValidationResult(success: false, errorMessage: "Please enter your Password.")
        }

        if(confirmPassword.isEmpty) {
            return SignUpValidationResult(success: false, errorMessage: "Please enter your Confirm Password.")
        }

        
        if(isValidEmail(value: email) == false ) {
            return SignUpValidationResult(success: false, errorMessage: "Please enter a valid email address.")
        }
        
        if(isValidPassword(value: password) == false) {
            return SignUpValidationResult(success: false, errorMessage: "Password should be at least 8 characters long max 32 characters and contains at least 1 special character.")
        }

        if(password != confirmPassword) {
            return SignUpValidationResult(success: false, errorMessage: "Password and Confirm Password should be matched.")
//            Password and Confirm Password should be matched.
        }

        
        return SignUpValidationResult(success: true, errorMessage: nil)
        
    }
    
    // validate the email id ^[A-Za-z0-9_]+$
    private func isValidEmail(value: String) -> Bool
    {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
    // validate user name
    private func isValidUserName(value: String) -> Bool {
        let  regex = try! NSRegularExpression(pattern: "^[A-Za-z0-9_.]+$", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
    private func isValidFirstName(value: String) -> Bool {
        let  regex = try! NSRegularExpression(pattern: "^[a-zA-Z]{2,50}+$", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
    private func isValidPassword(value: String) -> Bool {
        let  regex = try! NSRegularExpression(pattern: "^(?=.*[A-Za-z0-9])(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,32}$", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
}

//  isValidPassword "^(?=.*[A-Za-z])(?=.*[$@$!%*#?&])[A-Za-z\\@$!%*#?&]{8,32}$"

// UserName "^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$"

///^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{8,32}$/
///"^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,32}$"

//^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$

//"^[a-zA-Z0-9_-]*$"

//"^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,32}$"

// My requirement is as follows: Password must be more than 6 characters, with at least one capital, numeric or special character

//(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}

// "^(?=.*[A-Za-z])(?=.*[$@$!%*#?&])[A-Za-z\$@$!%*#?&]{8,32}$"
