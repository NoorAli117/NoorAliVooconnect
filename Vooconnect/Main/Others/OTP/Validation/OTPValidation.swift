//
//  OTPValidation.swift
//  Vooconnect
//
//  Created by Vooconnect on 11/11/22.
//

import Foundation
 
struct OTPValidationResult {
    var success: Bool = false
    var errorMessage: String?
}

struct OTPValidation {
    // validate the user inputs
    
    func otpValidationInputs(one: String, two: String, three: String, four: String) -> OTPValidationResult {
        
        if(one.isEmpty) {
            return OTPValidationResult(success: false, errorMessage: "Please enter your OTP")
        }
        
        if(two.isEmpty) {
            return OTPValidationResult(success: false, errorMessage: "Please enter your OTP")
        }
        
        if(three.isEmpty) {
            return OTPValidationResult(success: false, errorMessage: "Please enter your OTP")
        }
        
        if(four.isEmpty) {
            return OTPValidationResult(success: false, errorMessage: "Please enter your OTP")
        }
        
        return OTPValidationResult(success: true, errorMessage: nil)
        
    }
    
}
