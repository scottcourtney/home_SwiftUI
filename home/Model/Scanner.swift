//
//  Scanner.swift
//  home
//
//  Created by Scott Courtney on 12/31/22.
//

import Foundation

class Scanner: ObservableObject {
    
    let scanInterval: Double = 1.0
    
    @Published var torchIsOn: Bool = false
    
    @Published var lastQrCode: String = "QR code goes here"
    
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }
}
