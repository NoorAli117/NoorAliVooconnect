//
//  LanguageViewModel.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 22/04/2023.
//

import SwiftUI

enum Language: String{
    // Suggested
    case englishUS = "English (US)"
    case englishUK = "English (UK)"
    
    // Other Languages
    case mandarin = "Mandarin"
    case hindi = "Hindi"
    case spanish = "Spanish"
    case french = "French"
    case arabic = "Arabic"
    case bengali = "Bengali"
    case russian = "Russian"
    case indonesia = "Indonesia"
    
    /// Suggested Languages
    static var suggestedCases: [Language]{
        [.englishUS, .englishUK]
    }
    
    /// Other languages
    static var otherLanguagesCases: [Language]{
        [.mandarin, .hindi, .spanish, .french, .arabic, .bengali, .russian, .indonesia]
    }
}

class LanguageViewModel: ObservableObject{
    @Published var selectedLanguage: Language = .englishUS
}
