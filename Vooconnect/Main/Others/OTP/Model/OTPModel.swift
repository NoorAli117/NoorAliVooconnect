//
//  OTPModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 11/11/22.
// birthdate

import Foundation

struct OTPRequest: Encodable {
    let uuid, otp, type: String
}

struct GenderRequest: Encodable {
    let uuid, gender: String
}

struct BirthDayRequest: Encodable {
    let uuid, birthdate: String
}

// MARK: - Welcome
struct OTPErrorResponce: Codable {
    let status: Bool?
    let errors: [OTPError]?
}

// MARK: - Error
struct OTPError: Codable {
    let value, msg, param, location: String?
}

// MARK: - Welcome
struct OTPInvalid: Codable {
    let status: Bool?
    let message: String?
}

struct UpdateInterestListRequest: Encodable {
    let uuid: String
    let interest_ids: [Int]
    
}
//"uuid": "{{user_uuid}}",
//    "interest_ids": [1,2,3,5]

// MARK: - Welcome
struct ProfileDataResponse: Codable {
    let status: Bool?
    let message: String?
    let data: ProfileData?
}

// MARK: - DataClass
struct ProfileData: Codable {
    let uuid: String?
    let username, firstName, lastName, middleName: String?
    let gender, birthdate, phone, phoneVerifiedAt: String?
    let email: String?
    let emailVerifiedAt, profileImage: String?
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
