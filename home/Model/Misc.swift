//
//  Misc.swift
//  home
//
//  Created by Scott Courtney on 1/13/23.
//

import Foundation

// MARK: - Misc
struct Misc: Codable {
    let lightbulbs: [Lightbulb]?
    let filters: [Filter]?
}

// MARK: - Lightbulb
struct Lightbulb: Codable, Identifiable {
    let id: UUID
    let nickname, brand, watts, model: String?
}

// MARK: - Filter
struct Filter: Codable, Identifiable {
    let id: UUID
    var filtersLeft: Int?
    let nickname, size, replacedDate: String?
}
