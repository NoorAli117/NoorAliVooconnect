//
//  CreatorViewModel.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 24/04/2023.
//

import SwiftUI

enum AddCreatorPlanRowType: String, CaseIterable{
    case planName = "Plan Name"
    case planImage = "Plan Image"
    case price = "Price"
    case description = "Description"
    
    var icon: String{
        switch self {
        case .planName:
            return "PlanNameS"
        case .planImage:
            return "UploadS"
        case .price:
            return "PriceS"
        case .description:
            return "DescriptionS"
        }
    }
    
    var placeHolder: String{
        switch self {
        case .planName:
            return "Add Plan Name"
        case .planImage:
            return "Upload Image"
        case .price:
            return "Add Price"
        case .description:
            return "Add Description"
        }
    }
}

class CreatorViewModel: ObservableObject{
    
}
