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
            VStack(spacing: 0) {
//                NavigationBarView()
//                    .padding(.horizontal, 15)
//                    .padding(.bottom)
//                    .padding(.top, UIApplication
//                        .shared
//                        .connectedScenes
//                        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
//                        .first { $0.isKeyWindow }?.safeAreaInsets.top)
//                    .background(.white)
//                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
//
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 0) {
                        HouseTabView(houseIndex: $houseIndex.houseIndex)
                            .padding(.vertical, 20)
                            .frame(height: UIScreen.main.bounds.width)
                        
                        //                            // Segment Picker
                        //                            Picker("Location", selection: $location) {
                        //                                ForEach(Location.allCases) { location in
                        //                                    Text(location.rawValue.capitalized).tag(location)
                        //                                }
                        //                            }
                        //                            .pickerStyle(SegmentedPickerStyle())
                        //                            .padding(.leading, 30)
                        //                            .padding(.trailing, 30)
                        
                        RoomGridView(houseIndex: $houseIndex.houseIndex)
                            .padding(.bottom, 10)
                        
                        ApplianceGridView(houseIndex: $houseIndex.houseIndex)
                            .padding(.bottom, 10)

                        MiscGridView(houseIndex: $houseIndex.houseIndex)
                            
//                        FooterView()
//                            .padding(.horizontal)
                    }//: VSTACK
                })//: SCROLL
            } //: VSTACK
            .background(colorGray.ignoresSafeArea(.all, edges: .all))
        }//: ZSTACK
        .ignoresSafeArea(.all, edges: .top)
    }
}
