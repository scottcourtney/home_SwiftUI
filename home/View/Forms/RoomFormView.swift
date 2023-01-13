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
    @State private var houses: [House] = []
    @State private var nickname: String = ""
    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var website: String = ""
    @State private var otherInformation: String = ""

    var body: some View {
        NavigationView() {
            VStack {
                Form {
                    Section(header: Text("Wall")) {
                        Label {
                            TextField("Name",
                                      text: $nickname
                            )
                        } icon: {}
                        Label {
                            TextField("Brand",
                                      text: $brand
                            )
                        } icon: {}
                        Label {
                            TextField("Model",
                                      text: $model
                            )
                        } icon: {}
                        Label {
                                TextField("Website",
                                          text: $website
                                )
                        } icon: {}
                        Label {
                            TextField("Other Information",
                                      text: $otherInformation
                            )
                        } icon: {}
                    }//: SECTION
                    Section(header: Text("Ceiling")) {
                        Label {
                            TextField("Name",
                                      text: $nickname
                            )
                        } icon: {}
                        Label {
                            TextField("Brand",
                                      text: $brand
                            )
                        } icon: {}
                        Label {
                            TextField("Model",
                                      text: $model
                            )
                        } icon: {}
                        Label {
                                TextField("Website",
                                          text: $website
                                )
                        } icon: {}
                        Label {
                            TextField("Other Information",
                                      text: $otherInformation
                            )
                        } icon: {}
                    }//: SECTION
                    Section(header: Text("Flooring")) {
                        Label {
                            TextField("Name",
                                      text: $nickname
                            )
                        } icon: {}
                        Label {
                            TextField("Brand",
                                      text: $brand
                            )
                        } icon: {}
                        Label {
                            TextField("Model",
                                      text: $model
                            )
                        } icon: {}
                        Label {
                                TextField("Website",
                                          text: $website
                                )
                        } icon: {}
                        Label {
                            TextField("Other Information",
                                      text: $otherInformation
                            )
                        } icon: {}
                    }//: SECTION
                }//: FORM
            }//: VSTACK
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button("Save", action: {
                        ApiService().addAppliance(
                            userId: userId!,
                            houseId: houses[self.houseIndex].id!,
                            nickname: nickname,
                            brand: brand,
                            model: model,
                            website: website,
                            otherInformation: otherInformation) { (result) in
                                if result == true {
                                    ApiService().getUserData(userId: userId!) { (result) in
                                        ApplianceGridView(houseIndex: $houseIndex).readFile()
                                        print(result)
                                        withAnimation {
                                            dismiss()
                                        }
                                    }
                                }
                            }
                        
                        print("Edit Button Tapped")
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
            .onAppear(perform: readFile)
        }//: NAVIGATIONVIEW

    }
    private func readFile() {
        if let jsonData: User = Bundle.main.decode("data.json") {
            self.houses = (jsonData.document?.house!)!
        }
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

