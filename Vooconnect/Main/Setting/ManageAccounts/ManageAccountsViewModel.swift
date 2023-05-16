//
//  ManageAccountsViewModel.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 23/04/2023.
//

import SwiftUI

enum ManageAccountsRowType: String, CaseIterable{
    case phoneNumber = "Phone Number"
    case email = "Email"
    case dob = "Date of Birth"
    case city = "City"
    case country = "Country"
    
    var icon: String{
        switch self {
        case .phoneNumber:
            return "CallS"
        case .email:
            return "EmailS"
        case .dob:
            return "CalendarS"
        case .city:
            return "MapS"
        case .country:
            return "LocationS"
        }
    }
    
    var placeholder: String{
        switch self {
        case .phoneNumber:
            return "Add Phone Number"
        case .email:
            return "Add Email"
        case .dob:
            return "Add DOB"
        case .city:
            return "Add your city"
        case .country:
            return "Add your country"
        }
    }
    
    var trailingIcon: String{
        switch self {
        case .phoneNumber, .email:
            return "ArrowLogo"
        case .dob:
            return "CalendarS"
        case .city:
            return "MapS"
        case .country:
            return "LocationS"
        }
    }
}

class ManageAccountsViewModel: ObservableObject{
    
}
