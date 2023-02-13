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
                        .padding(.top, 20)
                        .padding(.bottom, 20)
//                        .ignoresSafeArea(edges: .top)

                        .tag(index)
                }
            } else {
                ProgressView()
            }
        }//: TAB
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .ignoresSafeArea(edges: .top)
        .onChange(of: selectedItem) { value in
            self.houseIndex = value
        }.onAppear(perform: readFile)
    }
    
    private func readFile() {
        if let jsonData: User = Bundle.main.decode("data.json") {
            guard let houses = jsonData.document?.house else {
                self.houses.removeAll()
                return
            }
            self.houses = houses
        }
    }
}
