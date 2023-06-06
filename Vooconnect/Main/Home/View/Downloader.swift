//
//  Downloader.swift
//  Vooconnect
//
//  Created by Mbp on 31/05/2023.
//

import Foundation


class Downloader {
    class func load(URL: NSURL) {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as NSHTTPURLResponse).statusCode
                println("Success: \(statusCode)")

                // This is your file-variable:
                // data
            }
            else {
                // Failure
                println("Failure: %@", error.localizedDescription);
            }
        })
        task.resume()
    }
}
