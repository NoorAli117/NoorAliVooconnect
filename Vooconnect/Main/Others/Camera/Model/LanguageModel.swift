//
//  LanguageModel.swift
//  Vooconnect
//
//  Created by Farooq Haroon on 6/2/23.
//

import Foundation


struct LanguageModel: Codable {
    let lang: [Languages]
}


struct Languages: Codable  {
    let key, name: String
}
