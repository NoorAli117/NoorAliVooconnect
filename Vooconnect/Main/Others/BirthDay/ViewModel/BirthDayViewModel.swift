//
//  BirthDayViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 01/12/22.
//

import Foundation

struct BirthDayDataModel {
    
    var birthDate: String = String()
    
    var successMessage: String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErrorAlert: Bool = false
    var isPresentingSuccess: Bool = false
    
}


class BirthDayViewModel: ObservableObject {
    
    @Published var birthDayDataModel: BirthDayDataModel = BirthDayDataModel()
    private let birthDayResource = BirthDayResource()
    
    func birthDayApi() {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = BirthDayRequest(uuid: uuid, birthdate: birthDayDataModel.birthDate)
        
        print("REQUEST=========",request)
        
        print("BirthDay==========",birthDayDataModel.birthDate)
        
        birthDayResource.hittingBirthDayApi(birthDayRequest: request) { isSuccess, sussesMessage in
            if isSuccess {
                DispatchQueue.main.async {
                    
                    self.birthDayDataModel.successMessage = "Gender is updated"
                    self.birthDayDataModel.isPresentingSuccess = true
                    self.birthDayDataModel.navigate = true
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    self.birthDayDataModel.errorMessage = "The email has already been taken."
                    self.birthDayDataModel.isPresentingErrorAlert = true
                }
                
            }
        }
        
        
    }
    
}
