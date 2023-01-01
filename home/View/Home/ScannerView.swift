//
//  ScannerView.swift
//  home
//
//  Created by Scott Courtney on 12/31/22.
//

import SwiftUI

struct ScannerView: View {
    var image: CGImage?
        private let label = Text("frame")
        
        var body: some View {
            if let image = image {
                Image(image, scale: 1.0, orientation: .up, label: label)
            } else {
                Color.black
            }
        }
}
