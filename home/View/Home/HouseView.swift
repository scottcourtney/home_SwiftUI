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
    var image = "interior_img"

    // MARK: - BODY
    
    var body: some View {
        VStack(spacing: 10) {
            Image(image)
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .overlay(ImageOverlay(), alignment: .bottomTrailing)
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
                Label("Cancel", systemImage: "")
            }
        }
    }
}

struct ImageOverlay: View {
    
    @State var selectedItem: [PhotosPickerItem] = []
    @State var data: Data?
    let houseView = HouseView?.self
    
    var body: some View {
        ZStack {
            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ) {
                Image(systemName: "photo.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.bottom, 10)
                    .padding(.trailing, 10)
                    .foregroundColor(Color.white)
            }

        }//: ZStack
    }
}
