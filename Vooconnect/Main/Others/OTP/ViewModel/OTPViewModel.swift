//
//  OTPViewModel.swift
//  Test
//
//  Created by Vooconnect on 09/11/22.
//

import SwiftUI

struct OTPDataModel {
    
    var successMessage: String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErrorAlert: Bool = false
    var isPresentingSuccess: Bool = false
    
    var emptyOTP: String = String()
    var invalidOTP: String = String()
    
    var errorEmptyOTP: Bool = false
    var errorInvalidOTP: Bool = false
    
}

class OTPViewModel: ObservableObject {
    
    @Published var otpDataModell: OTPDataModel = OTPDataModel()
    
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 6){
        didSet{
            // Checking if OTP is Pressed
            for index in 0..<6{
                if otpFields[index].count == 6{
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
    
    private let otpValidation = OTPValidation()
    private let optResource = OTPResource()
        
    // call the api
    func emailOTPApi() {
//        DispatchQueue.main.async { [self] in
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
                         self.otpDataModell.successMessage = "OTP verified."
                         self.otpDataModell.isPresentingSuccess = true
                         self.otpDataModell.navigate = true
                     }
                     
                     print("Sucesss=====")
                 } else {
                     print("Failure=====")
                     DispatchQueue.main.async {
                         
                         if sussesMessage == "Invalid OTP." {
                             
                             self.otpDataModell.emptyOTP = "Invalid OTP."
//                             self.otpDataModell.isPresentingErrorAlert = true
                             
                         } else if sussesMessage == "Please enter your otp." {
                             
                             self.otpDataModell.emptyOTP = "Please enter your OTP."
//                             self.otpDataModell.isPresentingErrorAlert = true
                             
                         } else {
                             self.otpDataModell.successMessage = sussesMessage ?? "sjdhbfjsdbf"
                             self.otpDataModell.isPresentingSuccess = true
                             print(sussesMessage ?? "sjdhbfjsdbf")
                         }
                         
                         
                         
                     }
                 }
             }
            
//        }

    }
    
    func phoneOTPApi() {
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
                    self.otpDataModell.successMessage = "OTP verified"
                    self.otpDataModell.isPresentingSuccess = true
                    self.otpDataModell.navigate = true
                }
                
                print("Sucesss=====")
            } else {
                print("Failure=====")
                DispatchQueue.main.async {
                    
                    if sussesMessage == "Invalid OTP." {
                        
                        self.otpDataModell.emptyOTP = "Invalid OTP."
//                             self.otpDataModell.isPresentingErrorAlert = true
                        
                    } else if sussesMessage == "Please enter your otp." {
                        
                        self.otpDataModell.emptyOTP = "Please enter your OTP."
//                             self.otpDataModell.isPresentingErrorAlert = true
                        
                    } else {
                        self.otpDataModell.successMessage = sussesMessage ?? "sjdhbfjsdbf"
                        self.otpDataModell.isPresentingSuccess = true
                        print(sussesMessage ?? "sjdhbfjsdbf")
                    }
                    
                    
                    
                }
            }
        }
        
    }
    
    
}
