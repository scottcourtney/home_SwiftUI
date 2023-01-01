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

    @Binding var houseIndex: Int

    @State var selectedItem = 0

    // MARK: - BODY
    var body: some View {
        TabView(selection: $selectedItem) {
            ForEach((users.document?.house!.indices)!, id: \.self) { index in
                HouseView(house: (users.document?.house![index])!, houseIndex: index)
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 40)
                    .tag(index)
            }
        }//: TAB
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onChange(of: selectedItem) { value in
            self.houseIndex = value
        }
    }
}
