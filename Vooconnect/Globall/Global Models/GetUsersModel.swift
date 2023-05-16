//
//  GetUsersModel.swift
//  Vooconnect
//
//  Created by Online Developer on 29/03/2023.
//

import Foundation

struct GetUsersModel: Codable {
    let status: Bool?
    let users: [UserDetail]?
}
