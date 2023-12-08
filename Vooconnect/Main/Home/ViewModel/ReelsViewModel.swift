//
//  ReelsViewModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 03/12/22.
//

import Foundation
import SwiftUI
import Combine
import Swinject

class ReelsViewModel: ObservableObject {
    
//    @Published var allReels: [ReelsModel] = []
    @Published var allReels: [Post] = []
    @Published var followingReels: [Post] = []
    
    init() {
        getAllReels()
        getFollowingReels()
    }
    
    private var sessionNextUrl = ""
    
    func getAllReels() {

        var urlRequest = URLRequest(url: URL(string:  "\(getBaseURL + EndPoints.reels)?take=\(3)")!)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 30
        
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            print("Access Token============",tokenData)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { httpData, httpResponse, httpError in
            if let data = httpData {
                
                do {
                    self.allReels = []
                    
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print("Reels json Data", jsonData)
                    
                    let decodedData = try JSONDecoder().decode(ReelsModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.allReels = decodedData.data?.posts ?? self.allReels
                    }
                    
                } catch {
                    
                    print("Error decoding Reels JSON: \(error.localizedDescription)")
                    
                }
                
            } else {
                
            }
            
        }.resume()

    }
    func getFollowingReels() {

        var urlRequest = URLRequest(url: URL(string:  "\(getBaseURL + EndPoints.followingReels)?take=\(3)")!)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 30
        
        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenData)"]
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            print("Access Token============",tokenData)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { httpData, httpResponse, httpError in
            if let data = httpData {
                
                do {
                    
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print("Following Reels json Data", jsonData)
                    
                    let decodedData = try JSONDecoder().decode(ReelsModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.followingReels = decodedData.data?.posts ?? self.allReels
                    }
                    
                } catch {
                    
                    print("Error decoding Reels JSON: \(error.localizedDescription)")
                    
                }
                
            } else {
                
            }
            
        }.resume()

    }
    func loadNext3Reels() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not available.")
            return
        }

        let offset = allReels.count // Calculate the offset based on the current count

        let url = URL(string: "\(getBaseURL + EndPoints.reels)?offset=\(offset)&take=3")!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(accessToken)"]
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(ReelsModel.self, from: data)
                        let newReels = decodedData.data?.posts ?? []

                        DispatchQueue.main.async {
                            self.allReels.append(contentsOf: newReels) // Append the new items
                            print("loadNext3Reels: \(newReels)")
                        }
                    } catch {
                        print("Error decoding Reels JSON: \(error.localizedDescription)")
                    }
                }
            } else if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
    }

    func loadNext3FollowingReels() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not available.")
            return
        }

        let offset = allReels.count // Calculate the offset based on the current count

        let url = URL(string: "\(getBaseURL + EndPoints.followingReels)?offset=\(offset)&take=3")!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(accessToken)"]
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(ReelsModel.self, from: data)
                        let newReels = decodedData.data?.posts ?? []

                        DispatchQueue.main.async {
                            self.followingReels.append(contentsOf: newReels) // Append the new items
                            print("loadNext3FollowingReels: \(newReels)")
                        }
                    } catch {
                        print("Error decoding Reels JSON: \(error.localizedDescription)")
                    }
                }
            } else if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}


class GetCreatorImageVM: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let creatorProfileImage: String
    private let dataService: CreatorImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(creatorProfileImage: String) {
        self.creatorProfileImage = creatorProfileImage
        self.dataService = CreatorImageService(creatorImage: creatorProfileImage)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returendImage) in
                self?.image = returendImage
            }
            .store(in: &cancellables)

    }
    
}


class GetProfileImageVM: ObservableObject {    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let dataService: ProfileImageService
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.dataService = ProfileImageService()
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returendImage) in
                self?.image = returendImage
            }
            .store(in: &cancellables)
    }
    
}
