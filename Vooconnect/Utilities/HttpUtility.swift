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
extension Encodable {

    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
        return json
    }
}
