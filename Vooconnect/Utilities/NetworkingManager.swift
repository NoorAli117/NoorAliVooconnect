//
//  NetworkingManagerWithAccessToken.swift
//  Vooconnect
//
//  Created by Vooconnect on 03/12/22.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingErrorr: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🤬]Bad responce With Access Token from URL.\(url)"
                
            case .unknown: return "[😌]Unknown error occured"
            
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
//        if let authToken = UserDefaults.standard.string(forKey: "access_token") {
//            request.allHTTPHeaderFields = ["Authorization" : "Bearer \(authToken)"]
//            request.addValue("application/json", forHTTPHeaderField: "content-type")
//        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
        
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponsee(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponsee(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
//        throw NetworkingError.badURLResponse(url: url)  // for checking bad url responce
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingErrorr.badURLResponse(url: url)
            
        }
        
        return output.data
 
        
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
