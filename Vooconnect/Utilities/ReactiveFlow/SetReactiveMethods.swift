//
//  SetReactiveMethods.swift
//  Skillr (iOS)
//
//  Created by Tony Buckner on 6/9/22.
//

import Combine
import Foundation
import SwiftUI
import Swinject

/// This class will house all of the root background reactive subscribers. They will all go in the initializer so while initialized, the subscribers will always be listening for changes. This is to be declared in 'MainTabbedView' as [private let currentReactives = SetReactiveMethods()]
class SetReactiveMethods: ObservableObject {
    
    

    private var cancellable = Set<AnyCancellable>()
    private let appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!
    
    @Published var isPresentBottomSheet = false
    @Published var bottomSheetType: BottomSheetType = .home
    
    init() {
        
        // Set subscribers
        logger.info("Setting Combine subscribers", category: .lifecycle)
    
        // VoIP Subscribers
        presentBottomSheet()
        hideBottomSheet()
    }
    
    // MARK: - Subscriber methods
    
    /// Present bottom sheet
    private func presentBottomSheet() {
        appEventsManager.presentBottomSheet
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] type in
                self.bottomSheetType = type
                self.isPresentBottomSheet = true
            })
            .store(in: &cancellable)
    }
    
    /// Hide bottom sheet
    private func hideBottomSheet() {
        appEventsManager.hideBottomSheet
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] _ in
                self.isPresentBottomSheet = false
            })
            .store(in: &cancellable)
    }
}
