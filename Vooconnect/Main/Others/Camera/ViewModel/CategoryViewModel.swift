//
//  CategoryViewModel.swift
//  Vooconnect
//
//  Created by Farooq Haroon on 6/3/23.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories: [PostCategoriesModel] = []
    
    init() {
        fetchData()
    }

    func fetchData() {
        var url = URLRequest(url: URL(string:  baseURL + EndPoints.postInterest)!)
        url.httpMethod = "GET"
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            url.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            url.addValue("application/json", forHTTPHeaderField: "content-type")
            print("Access Token============",tokenData)
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let categories = try decoder.decode(GetCategoryResponse.self, from: data)
                print("categories =====> ", categories)
                DispatchQueue.main.async {
                    self.categories = categories.data
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
