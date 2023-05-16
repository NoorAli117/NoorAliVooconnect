//
//  GenderViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 12/11/22.
//

import Foundation

struct GenderDataModel {
    
    var gender: String = "male"
    
    var successMessage: String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErrorAlert: Bool = false
    var isPresentingSuccess: Bool = false
    
}


class GenderViewModel: ObservableObject {
    
    @Published var genderDataModel: GenderDataModel = GenderDataModel()
    private let genderResource = GenderResource()
    
    func genderApi() {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = GenderRequest(uuid: uuid, gender: genderDataModel.gender)
        
        print("REQUEST=========",request)
        
        print("Gender==========",genderDataModel.gender)
        
        genderResource.hittingGenderApi(genderRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    
                    self.genderDataModel.successMessage = "Gender is updated"
                    self.genderDataModel.isPresentingSuccess = true
                    self.genderDataModel.navigate = true
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    self.genderDataModel.errorMessage = "The email has already been taken."
                    self.genderDataModel.isPresentingErrorAlert = true
                }
                
            }
        }
        
        
    }
    
}
