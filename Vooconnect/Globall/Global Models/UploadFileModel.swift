//
//  UploadFileModel.swift
//  Vooconnect
//
//  Created by Online Developer on 31/03/2023.
//

import Foundation

struct UploadFileModel: Codable {
    let status: Bool
    let data: [UploadFileData]?
}

// MARK: - Datum
struct UploadFileData: Codable {
    let name, size: String?
}
