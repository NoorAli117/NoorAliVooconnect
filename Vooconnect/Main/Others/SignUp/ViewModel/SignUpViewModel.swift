//
//  SignUpViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 03/11/22.
//

import Foundation

struct SignUpDataModel {
    
    var userName: String = String()
    var firstName: String = String()
    var lastName: String = String()
    var email: String = String()
    var phoneNumber: String = String()
    var password: String = String()
    var confirmPassword: String = String()
    
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErrorAlert: Bool = false
    var isPresentingSuccess: Bool = false
    
}


class SignUpViewModel: ObservableObject {
    
    @Published var signUpDataModel: SignUpDataModel = SignUpDataModel()
    private let signUpValidation = SignUpValidation()
//    private let signUpResource = SignUpResource()
    
    // validate the user inputs
    func validationUserInputs() -> Bool {
        let result = signUpValidation.validationInputs(userName: signUpDataModel.userName, firstName: signUpDataModel.firstName, lastName: signUpDataModel.lastName, email: signUpDataModel.email, phoneNumber: signUpDataModel.phoneNumber, password: signUpDataModel.password, confirmPassword: signUpDataModel.confirmPassword)
        if(result.success == false) {
            signUpDataModel.errorMessage = result.errorMessage ?? "error occured"
            signUpDataModel.isPresentingErrorAlert = true
            
            return false
        }
        
        return true
        
    }
    
}
