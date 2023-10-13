//
//  ARNetworkManager.swift
//  ARGearSample
//
//  Created by Jihye on 2020/01/07.
//  Copyright © 2020 Seerslab. All rights reserved.
//

import Foundation
import ARGear

let API_HOST = "https://apis.argear.io/api/v3/"
let API_KEY = "b4b1a87674939d6a76a99cfb"
let API_SECRET_KEY = "ee33adf106b69a5c7f134c044af05ef7ac3dc28d85e50377124545a10b31f0e3"
let API_AUTH_KEY = "U2FsdGVkX1+vrOWRMSQcgQIbgbdxkVz6fvy6GT+NCIByXFjq8LwJNvjF8V5eZhYYqPj6CoZhVLUOUXdAzzir0w=="

enum APIError: Error {
    case network
    case data
    case serializeJSON
}

enum DownloadError: Error {
    case network
    case auth
    case content
}

class ARNetworkManager {

    static let shared = ARNetworkManager()
    
    var argSession: ARGSession?
    
    init() {
    }
    
    func connectAPI(completion: @escaping (Result<[String: Any], APIError>) -> Void) {
        
        let urlString = API_HOST + API_KEY + "?dev=true"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return completion(.failure(.network))
            } else {
                guard let data = data else {
                    return completion(.failure(.data))
                }
                
                guard let json: [String : Any] = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    return completion(.failure(.serializeJSON))
                }
                
                completion(.success(json))
            }
        }
        task.resume()
    }
    
    func downloadItem(_ item: Item, completion: @escaping (Result<URL, DownloadError>) -> Void) {
        guard let session = self.argSession, let auth = session.auth
            else {
                completion(.failure(.auth))
                return
        }
        
        guard let zipUrl = item.zip_file
            else {
                completion(.failure(.content))
                return
        }

        let authCallback : ARGAuthCallback = {(url: String?, code: ARGStatusCode) in
            if (code.rawValue == ARGStatusCode.SUCCESS.rawValue) {
                guard let url = url
                    else {
                        completion(.failure(.auth))
                        return
                }
                
                // download task
                let authUrl = URL(string: url)!
                let task = URLSession.shared.downloadTask(with: authUrl) { (downloadUrl, response, error) in
                   if error != nil {
                       completion(.failure(.network))
                       return
                   }

                   guard
                       let httpResponse = response as? HTTPURLResponse,
                       let response = response,
                       let downloadUrl = downloadUrl
                       else {
                           completion(.failure(.network))
                           return
                   }

                   if httpResponse.statusCode == 200 {
                       guard
                           var cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first,
                           let suggestedFilename = response.suggestedFilename
                           else {
                               completion(.failure(.content))
                               return
                       }
                       cachesDirectory.appendPathComponent(suggestedFilename)

                       let fileManager = FileManager.default
                       // remove
                       do {
                           try fileManager.removeItem(at: cachesDirectory)
                       } catch {
                       }
                       // copy
                       do {
                           try fileManager.copyItem(at: downloadUrl, to: cachesDirectory)
                       } catch {
                           completion(.failure(.content))
                           return
                       }

                       completion(.success(cachesDirectory))
                       return
                   }
                   completion(.failure(.network))
                }
                task.resume()
            } else {
                if code.rawValue > ARGStatusCode.VALID_AUTH.rawValue {
                    completion(.failure(.auth))
                } else {
                    completion(.failure(.network))
                }
            }
        }

        auth.requestSignedUrl(withUrl: zipUrl, itemTitle: item.title ?? "", itemType: item.type ?? "", completion: authCallback)
    }
}
