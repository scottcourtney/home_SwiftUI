//
//  LightbulbDetailView.swift
//  home
//
//  Created by Scott Courtney on 1/13/23.
//

import SwiftUI

struct LightbulbDetailView: View {
    
    // MARK: - PROPERTY
    @Environment(\.dismiss) var dismiss
    @State private var houses: [House] = []
    @Binding var houseIndex: Int

    @State private var isEditing = false
    @State private var showingAlert = false
    @State private var showAddAlert = false
    @State private var nickname: String = ""
    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var watts: String = ""

    @State var lightbulbs: [Lightbulb]
    
    var body: some View {
        NavigationView() {
            VStack {
                Form {
                    ForEach(lightbulbs) { lightbulb in
                        Section(header:
                                    HStack {
                            Text(lightbulb.nickname ?? "N/A")
                            Spacer()
                            Button(action: { showingAlert = true }, label: {
                                Image(systemName: "x.circle")
                                    .foregroundColor(Color.red)
                            }).alert(isPresented: $showingAlert) {
                                Alert(
                                    title: Text("Remove \(lightbulb.nickname ?? "") from Lightbulbs?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        removeLightbulb(id: lightbulb.id)
                                    },
                                    secondaryButton: .cancel())
                            }
                        })
                        {
                            Label {
                                Text("Brand")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(lightbulb.brand ?? "N/A")
                                
                            } icon: {}
                            Label {
                                Text("Model")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(lightbulb.model ?? "N/A")
                            } icon: {}
                            Label {
                                Text("Watts")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(lightbulb.watts ?? "N/A")
                            } icon: {}
                        }//: SECTION
                        .id(lightbulb.id)
                    }
                }//: FORM
            }//: VSTACK
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action: { showAddAlert = true }, label: {
                        Image(systemName: "plus")
                    })//: BUTTON
                    .alert("", isPresented: $showAddAlert) {
                        TextField("Nickname", text: $nickname)
                        TextField("Brand", text: $brand)
                        TextField("Model", text: $model)
                        TextField("Watts", text: $watts)
                        Button("Submit", action: addLightbulb)
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Add a Lightbulb")
                    }
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Lightbulbs")
            
        }//: NAVIGATIONVIEW
        .onAppear {
            readFile()
        }
    }
    
    private func removeLightbulb(id: UUID) {
        print(id)
        lightbulbs.removeAll(where: { $0.id == id })
        delete(id: id)
    }
    
    private func addLightbulb() {
        lightbulbs.append(Lightbulb(id: UUID(), nickname: nickname, brand: brand, watts: watts, model: model))
        save()
    }
    
    private func save() {
        let newestLightBulb = lightbulbs.last
        ApiService().addLightbulb(
            houseId: houses[self.houseIndex].id!,
            nickname: newestLightBulb?.nickname ?? "",
            id: newestLightBulb?.id ?? UUID(),
            brand: newestLightBulb?.brand ?? "",
            model: newestLightBulb?.model ?? "",
            watts: newestLightBulb?.watts ?? ""
        ) { (result) in
            if result == true {
                ApiService().getUserData() { (result) in
                }
            }
            else {
                // TODO: REMOVE LAST LIGHTBULB AND DISPLAY ERROR MESSAGE
            }
        }
    }
    
    private func delete(id: UUID) {
        ApiService().removeLightbulb(
            houseId: houses[self.houseIndex].id!,
            id: id
        ) { (result) in
            if result == true {
                ApiService().getUserData() { (result) in
                }
            }
        }
    }
    
    private func readFile() {
        if let jsonData: User = Bundle.main.decode("data.json") {
            self.houses = (jsonData.document?.house!)!
//            self.lightbulbs = (jsonData.document.house[houseIndex].interior?.misc?.lightbulbs)
        }
    }
    
}
