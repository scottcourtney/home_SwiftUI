//
//  ContentView.swift
//  home
//
//  Created by Scott Courtney on 12/28/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var viewRouter: ViewRouter
    
//    @State var users: User?

    @ObservedObject var houseIndex = HouseIndex()
    @State var location: Location = .interior

    
    enum Location: String, CaseIterable, Identifiable {
           case interior
           case exterior
           var id: String { self.rawValue }
       }

    // MARK: - BODY
    
    var body: some View {
        ZStack {
//            VStack(spacing: 0) {

                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 0) {
                        HouseTabView(houseIndex: $houseIndex.houseIndex)
                            .padding(.bottom, 0)
                            .frame(height: UIScreen.main.bounds.width)
             
                        RoomGridView(houseIndex: $houseIndex.houseIndex)
                            .padding(.bottom, 10)
                        
                        ApplianceGridView(houseIndex: $houseIndex.houseIndex)
                            .padding(.bottom, 10)

                        MiscGridView(houseIndex: $houseIndex.houseIndex)
                            
                    }//: VSTACK
                })//: SCROLL
//            } //: VSTACK
            .background(colorGray.ignoresSafeArea(.all, edges: .all))
        }//: ZSTACK
        .ignoresSafeArea(.all)
    }
}
