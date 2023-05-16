//
//  SettingViewModel.swift
//  Vooconnect
//
//  Created by OnlineDeveloper on 19/02/2023.
//

import SwiftUI
import Swinject
import Combine

class SettingViewModel: ObservableObject {
    private var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    private var appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var isDarkModeOn = false
    @Published var selectedSettingRowType: SettingRowType = .viewProfile
    @Published var navigate = false
    
    init(){
        onLogoutButtonPressedObserver()
    }
    
    /// Getting current user full name
    func getFullName() -> String{
        let user = userAuthanticationManager.userDetail
        return (user?.firstName ?? "") + " " + (user?.lastName ?? "")
    }
    
    func settingRowActions(settingRowType: SettingRowType){
        switch settingRowType {
        case .viewProfile:
            selectedSettingRowType = .viewProfile
            navigate.toggle()
        case .manageAccount:
            selectedSettingRowType = .manageAccount
            navigate.toggle()
        case .creator:
            selectedSettingRowType = .creator
            navigate.toggle()
        case .privacy:
            print("Privacy")
        case .security:
            selectedSettingRowType = .security
            navigate.toggle()
        case .qrCode:
            selectedSettingRowType = .qrCode
            navigate.toggle()
        case .language:
            selectedSettingRowType = .language
            navigate.toggle()
        case .darkMode:
            isDarkModeOn.toggle()
        case .balance:
            selectedSettingRowType = .balance
            navigate.toggle()
        case .contentPrefrances:
            print("Content Preferences")
        case .reportAProblem:
            print("Report A Problem")
        case .contact:
            print("Contact")
        case .termsOfServices:
            print("Terms of Services")
        case .privacyPolicy:
            selectedSettingRowType = .privacyPolicy
            navigate.toggle()
        case .logout:
            appEventsManager.presentBottomSheet.send(.logout)
            selectedSettingRowType = .logout
        }
    }
    
    /// Hide bottom sheet
    private func onLogoutButtonPressedObserver() {
        appEventsManager.logoutButtonPressed
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] _ in
                navigate = true
            })
            .store(in: &cancellable)
    }
}
