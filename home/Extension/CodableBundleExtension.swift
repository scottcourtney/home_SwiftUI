//
//  CodableBundleExtension.swift
//  home
//
//  Created by Scott Courtney on 12/8/22.
//

import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        // 1. locate JSON File
        guard let dir = FileManager.default.urls(for: .documentDirectory,     in: .userDomainMask).first else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        let fileURL = dir.appendingPathComponent(file)


//        guard let url = self.url(forResource: file, withExtension: nil) else {
//            fatalError("Failed to locate \(file) in bundle.")
//        }
        
        // 2. Create a property for the data
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        
        // 4. Create a property for the decoded data
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        // 5. Return the ready to use data
        return decodedData
    }
    
    func decodeFile<T: Codable>(_ file: String) -> T {
        // 1. locate JSON File
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // 2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        
        // 4. Create a property for the decoded data
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        // 5. Return the ready to use data
        return decodedData
    }

}
