//
//  UpdateInterestViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 29/11/22.
//

import Foundation

struct UpdateInterestDataModel {
    
    var interestID: [Int] = []
    
    var successMessage: String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErrorAlert: Bool = false
    var isPresentingSuccess: Bool = false
}

class UpdateInterestViewModel: ObservableObject {
    
    @Published var updateInterestDataModel: UpdateInterestDataModel = UpdateInterestDataModel()
    private let interestListResource = InterestListResource()
    
    func validationUserInputss() -> Bool {
        if updateInterestDataModel.interestID.isEmpty {
            updateInterestDataModel.isPresentingErrorAlert = true
            
            return false
        }
        
        return true
    }
    
    func updateInterestApi() {
        
        let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
        let request = UpdateInterestListRequest(uuid: uuid, interest_ids: updateInterestDataModel.interestID)
        
        
        print(updateInterestDataModel.interestID)
        print(request)
        
        interestListResource.hittingUpdateInterestApi(updateInterestListRequest: request) {isSuccess, sussesMessage in
            
            if isSuccess {
                DispatchQueue.main.async {
                    
                    self.updateInterestDataModel.successMessage = "Gender is updated"
                    self.updateInterestDataModel.isPresentingSuccess = true
                    self.updateInterestDataModel.navigate = true
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    
                    self.updateInterestDataModel.errorMessage = "The email has already been taken."
                    self.updateInterestDataModel.isPresentingErrorAlert = true
                    
                }
                
            }
        }
        
    }
    
}
 
