//
//  SignUpModel.swift
//  Vooconnect
//
//  Created by Vooconnect on 11/11/22.
//

import Foundation

struct SignUpRequest: Encodable {
    let email, password, remember_me: String
}

struct SignUpRequestPhone: Encodable {
    let phone, password, remember_me: String
}

// MARK: - Errors
struct SignUpFaile: Codable {
    let status: Bool?
    let errors: [SignUpErrors]?
}

struct SignUpErrors: Codable {
    let value, msg, param, location: String?
}

struct LogInPhoneError: Codable {
    let status: Bool?
    let message: String?
}

struct SignUpSucces: Codable {
    let status: Bool?
    let message: String?
    let data: DataClass?
}

struct DataClass: Codable {
    let uuid: String?
}

struct SendOTPRequest: Encodable {
    let uuid: String
}


struct CreateNewPasswordRequest: Encodable {
    let uuid, password, confirm_password: String?
}

//// MARK: - Welcome
//struct SignUpError: Codable {
//    let status: Bool?
//    let errors: [Error]?
//}
//
//// MARK: - Error
//struct Error: Codable {
//    let value, msg, param, location: String?
//}
