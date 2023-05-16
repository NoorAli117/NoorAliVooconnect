//
//  FillYourProfileModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 19/11/22.
//

import Foundation

struct ProfileDetailsRequest: Encodable {
    let uuid, username, first_name, last_name, email, phone, address: String?
    let profile_image: String?
}

struct UploadImageRequest: Encodable {
    let asset: Data
    let upload_path: String
}

// MARK: - Welcome
struct uploadImageSuccess: Codable {
    let status: Bool?
    let data: [uploadImageSuccessData]?
}

// MARK: - Datum
struct uploadImageSuccessData: Codable {
    let name, size: String?
}
