//
//  URLExtension.swift
//  Vooconnect
//
//  Created by JV on 25/02/23.
//
import UIKit

extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}
