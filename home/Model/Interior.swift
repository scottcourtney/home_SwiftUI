//
//  Interior.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import Foundation

// MARK: - Interior
struct Interior: Codable {
    let rooms: [Room]?
    let appliances: [Appliance]?
    let misc: Misc?

    enum CodingKeys: String, CodingKey {
        case rooms = "Rooms"
        case appliances = "Appliances"
        case misc = "Misc"
    }
}
