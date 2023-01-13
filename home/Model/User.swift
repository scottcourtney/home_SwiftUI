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
    let id: String?
    let userInfo: UserInfo?
    let house: [House]?

    enum CodingKeys: String, CodingKey {
           case id = "_id"
           case userInfo, house
       }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    
    var userID, email, uid, displayName: String?
    var firstName, lastName: String?
    
//    init(uid: String, displayName: String?) {
//            self.uid = uid
////            self.email = email
//            self.displayName = displayName
//        }

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, uid, displayName, firstName, lastName
    }
}


