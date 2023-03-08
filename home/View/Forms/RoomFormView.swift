//
//  RoomFormView.swift
//  home
//
//  Created by Scott Courtney on 1/12/23.
//

import SwiftUI

struct RoomFormView: View {
//    let userDefaults = UserDefaults.standard
    let userId = UserDefaults.standard.string(forKey: "UserId")

    @Environment(\.dismiss) private var dismiss

    @Binding var houseIndex: Int
    var room: Room?
    @State private var houses: [House] = []
    @State private var nickname: String = ""
    @State private var wallPaintBrand: String = ""
    @State private var wallPaintColor: String = ""
    @State private var wallPaintFinish: String = ""
    @State private var ceilingPaintBrand: String = ""
    @State private var ceilingPaintColor: String = ""
    @State private var ceilingPaintFinish: String = ""
    @State private var floorType: String = ""
    @State private var floorBrand: String = ""
    @State private var floorCollectionName: String = ""
    @State private var floorStyleNumber: String = ""
    @State private var floorGroutColor: String = ""


    var body: some View {
    
        NavigationView() {
        
            VStack {
                HStack {
                    Spacer()
                    Label {
                        TextField("Name",
                                  text: $nickname
                        )
                    } icon: {}
                    Spacer()
                }
                Form {
                    Section(header: Text("Wall")) {
                        Label {
                            TextField("Paint Brand",
                                      text: $wallPaintBrand
                            )
                        } icon: {}
                        Label {
                            TextField("Color",
                                      text: $wallPaintColor
                            )
                        } icon: {}
                        Label {
                                TextField("Finish",
                                          text: $wallPaintFinish
                                )
                        } icon: {}
                    }//: SECTION
                    Section(header: Text("Ceiling")) {
                        Label {
                            TextField("Paint Brand",
                                      text: $ceilingPaintBrand
                            )
                        } icon: {}
                        Label {
                            TextField("Color",
                                      text: $ceilingPaintColor
                            )
                        } icon: {}
                        Label {
                            TextField("Finish",
                                      text: $ceilingPaintFinish
                            )
                        } icon: {}
                    }//: SECTION
                    Section(header: Text("Flooring")) {
                        Label {
                            TextField("Type",
                                      text: $floorType
                            )
                        } icon: {}
                        Label {
                            TextField("Brand",
                                      text: $floorBrand
                            )
                        } icon: {}
                        Label {
                            TextField("Collection",
                                      text: $floorCollectionName
                            )
                        } icon: {}
                        Label {
                                TextField("Style",
                                          text: $floorStyleNumber
                                )
                        } icon: {}
                        Label {
                            TextField("Grout Color",
                                      text: $floorGroutColor
                                      
                            )
                        } icon: {}
                    }//: SECTION
                }//: FORM
            }//: VSTACK
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button("Save", action: {
//                        ApiService().addAppliance(
//                            userId: userId!,
//                            houseId: houses[self.houseIndex].id!,
//                            nickname: nickname,
//                            brand: brand,
//                            model: model,
//                            website: website,
//                            otherInformation: otherInformation,
//                            type: type) { (result) in
//                                if result == true {
//                                    ApiService().getUserData(userId: userId!) { (result) in
//                                        ApplianceGridView(houseIndex: $houseIndex).readFile()
//                                        print(result)
//                                        withAnimation {
//                                            dismiss()
//                                        }
//                                    }
//                                }
//                            }
//                        
//                        print("Edit Button Tapped")
                    })//: BUTTON
                    
                }
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button("Cancel", action: {
                        withAnimation {
                            dismiss()
                        }
                        
                        print("Cancel Button Tapped")
                    })//: BUTTON
                    
                }
            }
            .onAppear {
                readFile()
                loadEditData()
            }
        }//: NAVIGATIONVIEW

    }
    private func readFile() {
        if let jsonData: User = Bundle.main.decode("data.json") {
            self.houses = (jsonData.document?.house!)!
        }
    }
    
    private func loadEditData() {
        self.nickname = room?.nickname ?? ""
        self.wallPaintBrand = room?.walls?.wallPaintBrand ?? ""
        self.wallPaintColor = room?.walls?.wallPaintColor ?? ""
        self.wallPaintFinish = room?.walls?.wallPaintFinish ?? ""
        self.ceilingPaintBrand = room?.ceiling?.ceilingPaintBrand ?? ""
        self.ceilingPaintColor = room?.ceiling?.ceilingPaintColor ?? ""
        self.ceilingPaintFinish = room?.ceiling?.ceilingPaintFinish ?? ""
        self.floorType = room?.flooring?.floorType ?? ""
        self.floorBrand = room?.flooring?.floorBrand ?? ""
        self.floorCollectionName = room?.flooring?.floorCollectionName ?? ""
        self.floorStyleNumber = room?.flooring?.floorStyleNumber ?? ""
        self.floorGroutColor = room?.flooring?.groutColor ?? ""

    }
}

//#if canImport(UIKit)
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil,
//                                        from: nil, for: nil)
//    }
//}
//#endif

