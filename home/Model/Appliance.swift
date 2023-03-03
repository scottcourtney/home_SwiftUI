//
//  Appliance.swift
//  home
//
//  Created by Scott Courtney on 12/29/22.
//

import Foundation

// MARK: - Appliance
struct Appliance: Codable, Identifiable, Hashable {
    let id: UUID
    let nickname, brand, model, website, other, type: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "appliance_id"
        case nickname = "nickname"
        case brand = "brand"
        case model = "model"
        case website = "website"
        case other = "other"
        case type = "type"
    }
}
