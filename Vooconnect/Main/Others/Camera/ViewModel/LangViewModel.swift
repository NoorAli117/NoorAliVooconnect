//
//  LanguageViewModel.swift
//  Vooconnect
//
//  Created by Farooq Haroon on 6/2/23.
//

import SwiftUI

class LangViewModel: ObservableObject {
    @Published var languages: [Languages] = []
    
    init() {
        getAllLanguages()
    }


    func getAllLanguages() {
        guard let url = URL(string: userApiEndPoint + EndPoints.subtitles) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let languages = try decoder.decode(LanguageModel.self, from: data)
                DispatchQueue.main.async {
                    self.languages = languages.lang
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
