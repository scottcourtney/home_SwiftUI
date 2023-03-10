//
//  HouseView.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import SwiftUI
import PhotosUI

struct HouseView: View {
    // MARK: - PROPERTY

    let house: House
    let houseIndex: Int

    // MARK: - BODY
    
    var body: some View {
        VStack(spacing: 10) {
            ImageView(houseId: house.id, roomId: nil, folderName: "house_folder")
            Text(house.nickname!)
        }
        .contextMenu {
            Button {
                print("Transfer House Pressed")
            } label: {
                Label("Transfer House To New Owner", systemImage: "shared.with.you")
                    .foregroundColor(Color.red)
            }
            Button(role: .destructive) {
                print("Delete House Pressed")
            } label: {
                Label("Remove House", systemImage: "minus.circle")
                    .foregroundColor(Color.red)
            }
            Button(role: .cancel) {
                print("Cancel")
            } label: {
                Label("Cancel", systemImage: "x.circle")
                    .labelStyle(TitleOnlyLabelStyle())
            }
        }
    }
}
