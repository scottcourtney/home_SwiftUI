//
//  RoomDetailView.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import SwiftUI

struct RoomDetailView: View {
    // MARK: - PROPERTY
    @Environment(\.dismiss) var dismiss
    @State private var isEditing = false

    let room: Room

    var body: some View {
        NavigationView() {
            VStack {
                Form {
                    Section(header: Text("Walls")) {
                        Label {
                            Text("Paint Brand")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.walls?.wallPaintBrand ?? "N/A")
                        } icon: {}
                        Label {
                            Text("Paint Finish")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.walls?.wallPaintFinish ?? "N/A")

                        } icon: {}
                        Label {
                            Text("Paint Color")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.walls?.wallPaintColor ?? "N/A")

                        } icon: {}
                        if room.walls?.wallType == "Tile" {
                            Label {
                                Text("Grout Color")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Text(room.walls?.groutColor ?? "N/A")
                            } icon: {}
                        }
                        
                    }
                    Section(header: Text("Ceiling")) {
                        Label {
                            Text("Paint Brand")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.ceiling?.ceilingPaintBrand ?? "N/A")
                        } icon: {}
                        Label {
                            Text("Paint Finish")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.ceiling?.ceilingPaintFinish ?? "N/A")
                        } icon: {}
                        Label {
                            Text("Paint Color")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.ceiling?.ceilingPaintColor ?? "N/A")
                        } icon: {}
                    }
                    Section(header: Text("Floors")) {
                        Label {
                            Text("Type")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.flooring?.floorType ?? "N/A")
                        } icon: {}
                        Label {
                            Text("Brand")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.flooring?.floorBrand ?? "N/A")
                        } icon: {}
                        Label {
                            Text("Collection")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.flooring?.floorCollectionName ?? "N/A")
                        } icon: {}
                        Label {
                            Text("Style")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.flooring?.floorStyleNumber ?? "N/A")
                        } icon: {}
                        if room.flooring?.floorType == "Tile" {
                            Label {
                                Text("Grout Color")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Text(room.flooring?.groutColor ?? "N/A")
                            } icon: {}
                        }
                    }
                }//: FORM
            }//: VSTACK
            .navigationTitle(room.nickname!)
            
//            .toolbar {
//                if isEditing {
//                    ToolbarItemGroup(placement: .navigationBarTrailing){
//                        Button("Save", action: {
//                            isEditing.toggle()
//                            dismiss()
//                            print("Save Button Tapped")
//                        })//: BUTTON
//                    }
//                    ToolbarItemGroup(placement: .navigationBarLeading){
//                        Button("Cancel", action: {
//                            isEditing.toggle()
//                            print("Cancel Button Tapped")
//                        })//: BUTTON
//                    }
//                } else {
//                    ToolbarItemGroup(placement: .navigationBarTrailing){
//                        Button("Edit", action: {
//                            isEditing.toggle()
//                            print("Edit Button Tapped")
//                        })//: BUTTON
//                    }
//                }
//            }
        }//: NAVIGATIONVIEW
    }
}

// MARK: - PREVIEW

struct RoomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetailView(room: Room(flooring: Flooring(floorType: "Floor Type", floorCollectionName: "Lowes", floorStyleNumber: "1234", floorBrand: "Lowes Brand", groutColor: "blue"), roomType: "bedroom", ceiling: Ceiling(ceilingPaintBrand: "Lowes", ceilingPaintColor: "Green", ceilingPaintFinish: "Satin"), nickname: "Scotts Room", id: "1234", walls: Walls(wallType: "sheetrock", wallPaintBrand: "Sherwin Williams", wallPaintColor: "White", wallPaintFinish: "Gloss", groutColor: "Gray")))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
