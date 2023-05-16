//
//  LogInModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 15/11/22.
//

import Foundation

// MARK: - Welcome
struct LogInSuccesDataModel: Codable {
    let status: Bool?
    let message: String?
    let data: LogInSuccesDetail?
}

// MARK: - DataClass
struct LogInSuccesDetail: Codable {
    let uuid: String?
    let username, firstName, lastName, middleName: String?
    let gender, birthdate, phone: String?
    let phoneVerifiedAt, email, emailVerifiedAt: String?
    let profileImage: String?
    let interestIDS: [Int]?
    let accessToken, refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case uuid, username
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case gender, birthdate, phone
        case phoneVerifiedAt = "phone_verified_at"
        case email
        case emailVerifiedAt = "email_verified_at"
        case profileImage = "profile_image"
        case interestIDS = "interest_ids"
        case accessToken, refreshToken
    }
}

struct Users: Hashable, Decodable {
    let uuid: String?
    let username, first_name, last_name, middleName: String?
    let gender, birthdate, phone: String?
    let profile_image: String?
}

struct ForgotPasswordRequest: Encodable {
    let email: String
}


// MARK: - Welcome
struct ForgotPasswordSuccessData: Codable {
    let status: Bool?
    let data: ForgotPasswordSuccessDetail?
}

// MARK: - DataClass
struct ForgotPasswordSuccessDetail: Codable {
    let uuid, email: String?
    let phone: String?
}

//{
//    "status": true,
//    "data": {
//        "uuid": "d6d529b1-b3d6-4091-9728-0e9c45999155",
//        "email": "sajid@gmail.com",
//        "phone": null
//    }
//}
//struct
