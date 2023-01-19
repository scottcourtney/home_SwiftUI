//
//  HouseTabView.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import SwiftUI

class HouseIndex: ObservableObject {
    @Published var houseIndex: Int = 0
}

struct HouseTabView: View {
    
    // MARK: - PROPERTIES
    @State private var houses: [House] = []
    
    @Binding var houseIndex: Int
    
    @State var selectedItem = 0
    
    // MARK: - BODY
    var body: some View {
        TabView(selection: $selectedItem) {
            if houses.count > 0 {
                ForEach((houses.indices), id: \.self) { index in
                    HouseView(house: (houses[index]), houseIndex: index)
                        .padding(.top, 10)
//                        .padding(.horizontal, 15)
                        .padding(.bottom, 40)
                        .tag(index)
                }
            } else {
                ProgressView()
            }
        }//: TAB
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onChange(of: selectedItem) { value in
            self.houseIndex = value
        }.onAppear(perform: readFile)
    }
    
    private func readFile() {
        if let jsonData: User = Bundle.main.decode("data.json") {
            self.houses = (jsonData.document?.house!)!
        }
    }
}
