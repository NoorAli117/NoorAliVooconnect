//
//  HttpUtility.swift
//  Vooconnect
//
//  
//

import Foundation

final class HttpUtility {

    static let shared = HttpUtility()
    private init(){}

    func postApiData(request: URLRequest, complitionHandler: @escaping(Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { httpData, httpResponse, httpError in
            if let responseData = httpData {

                complitionHandler(.success(responseData))

            } else if let responseError = httpError {

                complitionHandler(.failure(responseError))

            }

        }.resume()
    }
}
