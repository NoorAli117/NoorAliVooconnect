//
//  FillYourProfileValidation.swift
//  Vooconnect
//
//  Created by Vooconnect on 19/11/22.
//

import Foundation

struct UploadProfileValidationResult {
    var success: Bool = false
    var errorMessage: String?
    var firstName: String?
    var lastName: String?
    var userName: String?
    var email: String?
    var phone: String?
    var address: String?
}

struct UploadProfileValidation {
    
    func uploadProfileValidationInputs(firstName: String, lastName: String, userName: String, email: String, phone: String, address: String) -> UploadProfileValidationResult {

        if(firstName.isEmpty) {
            return UploadProfileValidationResult(success: false, firstName: "Please enter your first name!")
        }

        if(isValidFirstName(value: firstName) == false) {
            return UploadProfileValidationResult(success: false, firstName: "No special characters are allowed and should be at least 2 letters long.")
        }

        if(lastName.isEmpty) {
            return UploadProfileValidationResult(success: false, lastName: "Please enter your last name!")
        }

        if(isValidFirstName(value: lastName) == false) {
            return UploadProfileValidationResult(success: false, lastName: "No special characters are allowed and should be at least 2 letters long.")
        }

        if(userName.isEmpty) {
            return UploadProfileValidationResult(success: false, userName: "Please enter a username!")
        }

        if(isValidUserName(value: userName) == false ) {
            return UploadProfileValidationResult(success: false, userName: "Username only allowed underscore (_) and period (.) a-zA-Z0-9.")
        }

        if(email.isEmpty) {
            return UploadProfileValidationResult(success: false, email: "Please enter your Email.")
        }

        if(isValidEmail(value: email) == false ) {
            return UploadProfileValidationResult(success: false, email: "Please enter a valid email address.")
        }

        if(phone.isEmpty) {
            return UploadProfileValidationResult(success: false, phone: "Please enter your Phone Number.")
        }

        if(address.isEmpty) {
            return UploadProfileValidationResult(success: false, address: "Please enter your address.")
        }


        return UploadProfileValidationResult(success: true, errorMessage: nil, firstName: nil, lastName: nil, userName: nil, email: nil, phone: nil, address: nil)

    }
    
    private func isValidFirstName(value: String) -> Bool {
        let  regex = try! NSRegularExpression(pattern: "^[a-zA-Z]{2,50}+$", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
    // validate user name
    private func isValidUserName(value: String) -> Bool {
        let  regex = try! NSRegularExpression(pattern: "^[A-Za-z0-9_.]+$", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
    // validate the email id ^[A-Za-z0-9_]+$
    private func isValidEmail(value: String) -> Bool
    {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
    
}
