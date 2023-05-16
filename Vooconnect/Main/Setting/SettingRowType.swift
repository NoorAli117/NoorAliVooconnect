//
//  SettingRowType.swift
//  Vooconnect
//
//  Created by OnlineDeveloper on 19/02/2023.
//

import SwiftUI

enum SettingRowType: CaseIterable{
    case viewProfile
    case manageAccount
    case creator
    case privacy
    case security
    case qrCode
    case language
    case darkMode
    case balance
    case contentPrefrances
    case reportAProblem
    case contact
    case termsOfServices
    case privacyPolicy
    case logout
    
    static var settingCases: [SettingRowType] {
        [.manageAccount, .creator, .privacy, .security, .qrCode, .language, .darkMode, .balance, .contentPrefrances, .reportAProblem, .contact, .termsOfServices, .privacyPolicy, .logout]
    }
    
    var iconName: String{
        switch self {
        case .viewProfile:
            return ""
        case .manageAccount:
            return "ProfileSetting"
        case .creator:
            return "StarSetting"
        case .privacy:
            return "LockSetting"
        case .security:
            return "ShieldDoneSettings"
        case .qrCode:
            return "ScanSettings"
        case .language:
            return "MoreCircleSettings"
        case .darkMode:
            return "ShowSettings"
        case .balance:
            return "MoreCircleSettings"
        case .contentPrefrances:
            return "VideoSettings"
        case .reportAProblem:
            return "EditSettings"
        case .contact:
            return "DangerSquareSettings"
        case .termsOfServices:
            return "PaperSettings"
        case .privacyPolicy:
            return "InfoSquareSettings"
        case .logout:
            return "LogoutSettings"
        }
    }
    
    var title: String{
        switch self {
        case .viewProfile:
            return ""
        case .manageAccount:
            return "Manage Account"
        case .creator:
            return "Creator"
        case .privacy:
            return "Privacy"
        case .security:
            return "Security"
        case .qrCode:
            return "QR Code"
        case .language:
            return "Language"
        case .darkMode:
            return "Dark Mode"
        case .balance:
            return "Balance"
        case .contentPrefrances:
            return "Content Prefrances"
        case .reportAProblem:
            return "Report A Problem"
        case .contact:
            return "Contact"
        case .termsOfServices:
            return "Terms Of Services"
        case .privacyPolicy:
            return "Privacy Policy"
        case .logout:
            return "Logout"
        }
    }
}
