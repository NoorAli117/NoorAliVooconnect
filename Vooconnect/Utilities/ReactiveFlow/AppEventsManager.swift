//
//  AppEventsManager.swift
//  MeetMe
//
//  Created by Online Developer on 05/12/2022.
//

import Combine
import SwiftUI


/// This class will handle some the LiveChef apps core events
final public class AppEventsManager {
    
    // MARK: - Publishers
    
    /// Present Bottom Sheet with Type
    var presentBottomSheet = PassthroughSubject<BottomSheetType, Never>()
    /// Hide Bottom Sheet
    var hideBottomSheet = PassthroughSubject<Bool, Never>()
    /// Present Login View
    var presentLoginView = PassthroughSubject<Bool, Never>()
    /// Restart App
    var restartApp = PassthroughSubject<Bool, Never>()
    /// Update Profile Image
    var updateProfileImage = PassthroughSubject<Bool, Never>()
    /// On logout button pressed present the login screen
    var logoutButtonPressed = PassthroughSubject<Bool, Never>()
}
