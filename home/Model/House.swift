//
//  House.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import Foundation

// MARK: - House
struct House: Codable, Identifiable {
    let id, nickname: String?
    let interior: Interior?
    let exterior: Exterior?
    
    enum CodingKeys: String, CodingKey {
        case id = "house_id"
        case nickname = "nickname"
        case interior
        case exterior
    }
}
