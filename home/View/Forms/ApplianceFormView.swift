//
//  ApplianceFormView.swift
//  home
//
//  Created by Scott Courtney on 1/2/23.
//

import SwiftUI


struct ApplianceFormView: View {
//    let userDefaults = UserDefaults.standard
    let userId = UserDefaults.standard.string(forKey: "UserId")
    let appliances: [String] = ["stove", "refrigerator", "microwave", "hood range", "dishwasher", "other"]

    @Environment(\.dismiss) private var dismiss

    @Binding var houseIndex: Int
    @State private var houses: [House] = []
    @State private var nickname: String = ""
    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var website: String = ""
    @State private var otherInformation: String = ""
    @State private var type: String = ""

    @FocusState private var focused: Bool

    var body: some View {
        NavigationView() {
            VStack {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                            ForEach(appliances, id: \.self) { appliance in
                                Button(action: {
                                    if appliance != "other" {
                                        self.nickname = appliance.uppercased()
                                        self.focused = true
                                        self.type = appliance
                                    } else {
                                        self.focused = true
                                        self.nickname = ""
                                        self.type = appliance
                                    }
                                }, label: {
                                    VStack {
                                        if appliance != "other" {
                                            Image(appliance)
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                                .padding(5)

                                            Text(appliance.uppercased())
                                                .font(.footnote)
                                                .foregroundColor(Color.gray)
                                        } else {
                                            Image(systemName: "")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                                .padding(.top, 5)
                                            Text("other".uppercased())
                                                .font(.footnote)
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                })
                        }
                    }
                }.padding(20)
                Form {
                    Section(header: Text("Appliance")) {
                        Label {
                            TextField("Name",
                                      text: $nickname
                            ).focused(self.$focused)
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
                    }
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
                            otherInformation: otherInformation,
                            type: type) { (result) in
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
//
//#if canImport(UIKit)
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil,
//            from: nil, for: nil)
//    }
//}
//#endif
