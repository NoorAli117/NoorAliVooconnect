//
//  ShareSheet.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import Foundation
import SwiftUI
import UIKit
import LinkPresentation

struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}


/// Custom share item is used to create a rich share preview with metadata
class ShareItemURLSource : NSObject, UIActivityItemSource {
    var url: URL?
    var title: String
    var desc: String
    
    init(title: String = "", desc: String = "", url: URL? = nil) {
        self.title = title
        self.desc = desc
        self.url = url
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return desc
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return title
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        if let url = url, desc.isEmpty {
            return url
        }
        
        return title
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        
        if let url = url, desc == "" {
            metadata.imageProvider = NSItemProvider.init(contentsOf: url)
            metadata.iconProvider = NSItemProvider.init(contentsOf: url)
            metadata.originalURL = url
        } else {
            metadata.title = title
            
            if !desc.isEmpty {
                metadata.originalURL = URL(fileURLWithPath: desc)
            }
            
            if let url = url {
                metadata.iconProvider = NSItemProvider.init(contentsOf: urlInTemporaryDirForSharePreviewImage(url))
            } else {
                metadata.iconProvider = NSItemProvider(object: UIImage(named: "AppIcon")!)
            }
        }
        
        return metadata
    }
    
    func urlInTemporaryDirForSharePreviewImage(_ url: URL?) -> URL? {
        if let image = UIImage(named: "vooconnectLogo") {
            let applicationTemporaryDirectoryURL = FileManager.default.temporaryDirectory
            let sharePreviewURL = applicationTemporaryDirectoryURL.appendingPathComponent("sharePreview.png")
            if let data = image.pngData() {
                do {
                    try data.write(to: sharePreviewURL)
                    return sharePreviewURL
                } catch {
                    print ("Error: \(error.localizedDescription)")
                }
            }
        }
        return nil
    }
}
