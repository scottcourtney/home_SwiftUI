//
//  Wall.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import Foundation

// MARK: - Walls
struct Walls: Codable {
    let wallType, wallPaintBrand, wallPaintColor, wallPaintFinish: String?
    let groutColor: String?
}
