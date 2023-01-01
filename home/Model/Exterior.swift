//
//  Exterior.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import Foundation

struct Exterior: Codable {
    let rooms: [Room]?

    enum CodingKeys: String, CodingKey {
        case rooms = "Rooms"
    }
}
