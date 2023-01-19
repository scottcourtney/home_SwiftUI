//
//  InteriorView.swift
//  home
//
//  Created by Scott Courtney on 1/17/23.
//

import SwiftUI

struct InteriorView: View {
    
    @ObservedObject var houseIndex = HouseIndex()

    var body: some View {
        
        RoomGridView(houseIndex: $houseIndex.houseIndex)
        
        ApplianceGridView(houseIndex: $houseIndex.houseIndex)
        
        MiscGridView(houseIndex: $houseIndex.houseIndex)
        
    }
}

struct InteriorView_Previews: PreviewProvider {
    static var previews: some View {
        InteriorView()
    }
}
