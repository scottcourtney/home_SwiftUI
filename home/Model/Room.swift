//
//  Room.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import Foundation

// MARK: - Room
struct Room: Codable, Identifiable {
    let flooring: Flooring?
    let roomType: String?
    let ceiling: Ceiling?
    let nickname, id: String?
    let walls: Walls?

    enum CodingKeys: String, CodingKey {
        case flooring = "Flooring"
        case roomType
        case ceiling = "Ceiling"
        case nickname
        case id = "room_id"
        case walls = "Walls"
    }
}

