//
//  User.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import Foundation

// MARK: - User
struct User: Codable {
    let document: Document?
}

// MARK: - Document
struct Document: Codable, Identifiable {
    let id, userID: String?
    let house: [House]?
    let userInfo: UserInfo?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case house
        case userInfo = "UserInfo"
    }
}

