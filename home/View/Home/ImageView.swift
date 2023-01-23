//
//  ImageView.swift
//  home
//
//  Created by Scott Courtney on 1/22/23.
//

import SwiftUI
import PhotosUI

struct ImageView: View {
    
    @State var selectedItem: [PhotosPickerItem] = []
    @State private var data: Data?
    @State private var image: UIImage?
    @StateObject var localFileService = LocalFileService()
    private let folderName = "house_folder"
    private let fileManager = LocalFileService.instance
    
    let houseId: String?

    
    var body: some View {
        if let image = image
        {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .overlay(
                    PhotosPicker(
                        selection: $selectedItem,
                        maxSelectionCount: 1,
                        matching: .images
                    ) {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.bottom, 10)
                            .padding(.trailing, 10)
                            .foregroundColor(Color.white)
                    }
                        .onChange(of: selectedItem) { newValue in
                            Task {
                                guard let item = selectedItem.first else { return }
                                if let data = try? await item.loadTransferable(type: Data.self) {
                                    self.data = data
                                    if let img = UIImage(data: data) {
                                        self.image = img
                                        fileManager.saveImage(image: img, imageName: houseId!, folderName: folderName)
                                    }
                                }
                            }
                        }
                    , alignment: .bottomTrailing)
                .onAppear {
                    self.checkIfImageExists()
                }
               
        } else {
            Image("interior_img")
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .overlay(
                    PhotosPicker(
                        selection: $selectedItem,
                        maxSelectionCount: 1,
                        matching: .images
                    ) {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.bottom, 10)
                            .padding(.trailing, 10)
                            .foregroundColor(Color.white)
                    }
                        .onChange(of: selectedItem) { newValue in
                            Task {
                                guard let item = selectedItem.first else { return }
                                if let data = try? await item.loadTransferable(type: Data.self) {
                                    self.data = data
                                    if let img = UIImage(data: data) {
                                        self.image = img
                                        fileManager.saveImage(image: img, imageName: houseId!, folderName: folderName)
                                    }
                                }
                            }
                        }
                    , alignment: .bottomTrailing)
                .onAppear {
                    self.checkIfImageExists()
                }
        }
    }
    
    func checkIfImageExists() {
        if image == nil {
            image = fileManager.loadImage(imageName: houseId!, folderName: folderName)
        }
    }