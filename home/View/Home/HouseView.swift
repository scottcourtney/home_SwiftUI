//
//  HouseView.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import SwiftUI

struct HouseView: View {
    // MARK: - PROPERTY

    let house: House
    let houseIndex: Int

    // MARK: - BODY
    
    var body: some View {
        VStack(spacing: 10) {
            Image("interior_img")
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
            Text(house.nickname!)
        }
    }
}

// MARK: - PREVIEW

struct HouseView_Previews: PreviewProvider {
    static var previews: some View {
        HouseView(house: (users.document?.house![0])!, houseIndex: 0)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
