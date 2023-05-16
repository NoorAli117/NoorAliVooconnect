//
//  FillYourProfileViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 19/11/22.
//

import Foundation

struct FillYourDataModel {
    
    
    
    var firstName: String = String()
    var lastName: String = String()
    var userName: String = String()
    var email: String = String()
    var phone: String = String()
    var phoneCode: String = String()
    var address: String = String()
    var image: String = String()
    
    var successMessage: String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErrorAlert: Bool = false
    var isPresentingSuccess: Bool = false
    
    var firstNameError: String = String()
    var lastNameError: String = String()
    var userNameError: String = String()
    var emailError: String = String()
    var phoneError: String = String()
    var phoneCodeError: String = String()
    var addressError: String = String()
    
    var errorFirstName: Bool = false
    var errorLastName: Bool = false
    var errorUserName: Bool = false
    var errorEmail: Bool = false
    var errorPhone: Bool = false
    var errorAddress: Bool = false
//    var errorFirstName: Bool = false
    
    var imageName: uploadImageSuccessData?
//    var profileDetail: ProfileDataResponse?
    
    var progressView: Bool = false
    
}


class FillYourProfileViewModel: ObservableObject {
    
    @Published var fillYourDataModel: FillYourDataModel = FillYourDataModel()
    private let uploadProfileValidation = UploadProfileValidation()
    private let fillYourProfileResource = FillYourProfileResource()
    
//    @Published private var imageName: uploadImageSuccessData = uploadImageSuccessData()
//    private var imageName = uploadImageSuccessData(from: self.Decoder)
    
    // validate the user inputs
    func validationUserProfileData() -> Bool {
        let result = uploadProfileValidation.uploadProfileValidationInputs(firstName: fillYourDataModel.firstName, lastName: fillYourDataModel.lastName, userName: fillYourDataModel.userName, email: fillYourDataModel.email, phone: fillYourDataModel.phone, address: fillYourDataModel.address)
        
        
        if(result.success == false) {
            
//            fillYourDataModel.errorMessage = result.errorMessage ?? "error occured"
            
            fillYourDataModel.firstNameError = result.firstName ?? ""
            if fillYourDataModel.firstNameError != "" {
                fillYourDataModel.errorFirstName = true
            } else {
                fillYourDataModel.errorFirstName = false
            }
            
            fillYourDataModel.lastNameError = result.lastName ?? ""
            if fillYourDataModel.lastNameError != "" {
                fillYourDataModel.errorLastName = true
            } else {
                fillYourDataModel.errorLastName = false
            }
            
            fillYourDataModel.userNameError = result.userName ?? ""
            if fillYourDataModel.userNameError != "" {
                fillYourDataModel.errorUserName = true
            } else {
                fillYourDataModel.errorUserName = false
            }
            
            fillYourDataModel.emailError = result.email ?? ""
            if fillYourDataModel.emailError != "" {
                fillYourDataModel.errorEmail = true
            } else {
                fillYourDataModel.errorEmail = false
            }
            
            fillYourDataModel.phoneError = result.phone ?? ""
            if fillYourDataModel.phoneError != "" {
                fillYourDataModel.errorPhone = true
            } else {
                fillYourDataModel.errorPhone = false
            }
            
            fillYourDataModel.addressError = result.address ?? ""
            if fillYourDataModel.addressError != "" {
                fillYourDataModel.errorAddress = true
            } else {
                fillYourDataModel.errorAddress = false
            }
            
            
            
            fillYourDataModel.isPresentingErrorAlert = true

            return false
        }
        
        
        return true
    }
    
    
    // call the upDateProfileApi api
    func upDateProfileApi() {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let imageName = UserDefaults.standard.string(forKey: "imageName") ?? ""
        
        print("UUID========",uuid)
        
        let request = ProfileDetailsRequest(uuid: uuid, username: fillYourDataModel.userName, first_name: fillYourDataModel.firstName, last_name: fillYourDataModel.lastName, email: fillYourDataModel.email, phone: fillYourDataModel.phoneCode + fillYourDataModel.phone, address: fillYourDataModel.address, profile_image: imageName)
        
        print("RQUEST======================",request)
        
        fillYourProfileResource.hittingUpdateProfile(profileDetailsRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
//                    self.fillYourDataModel.successMessage = "Your OTP is 1234"
                    self.fillYourDataModel.progressView = false
                    self.fillYourDataModel.successMessage = "Profile updated Successfully."
                    self.fillYourDataModel.isPresentingSuccess = true
                    self.fillYourDataModel.navigate = true
                    
                }
                
            } else {
                DispatchQueue.main.async {
//                    This username is already registered!"
//                    "This email address is already registered!"
//                    "Please enter a valid phone number."
//                    "This phone number is already registered!"
                    self.fillYourDataModel.progressView = false
                    
                    if sussesMessage == "This username is already registered!" {
                        self.fillYourDataModel.userNameError = sussesMessage ?? "This username is already registered!"
                        if self.fillYourDataModel.userNameError != "" {
                            self.fillYourDataModel.errorUserName = true
                        } else {
                            self.fillYourDataModel.errorUserName = false
                        }
                    }
                    
                    
                    if sussesMessage == "This email address is already registered!" {
                        self.fillYourDataModel.emailError = sussesMessage ?? "This email address is already registered!"
                        if self.fillYourDataModel.emailError != "" {
                            self.fillYourDataModel.errorEmail = true
                        } else {
                            self.fillYourDataModel.errorEmail = false
                        }
                    }
                    
                    if sussesMessage == "Please enter a valid phone number." {
                        self.fillYourDataModel.phoneError = sussesMessage ?? "Please enter your valid phone number!"
                        if self.fillYourDataModel.phoneError != "" {
                            self.fillYourDataModel.errorPhone = true
                        } else {
                            self.fillYourDataModel.errorPhone = false
                        }
                    }
                    
                    if sussesMessage == "This phone number is already registered!" {
                        self.fillYourDataModel.phoneError = sussesMessage ?? "Please enter your valid phone number!"
                        if self.fillYourDataModel.phoneError != "" {
                            self.fillYourDataModel.errorPhone = true
                        } else {
                            self.fillYourDataModel.errorPhone = false
                        }
                    }
                    
//                    self.fillYourDataModel.isPresentingSuccess = true
                }
                
            }
        }
        
    }
    
}
