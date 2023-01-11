//
//  RoomGridView.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import SwiftUI
import CodeScanner

struct RoomGridView: View {
    // MARK: - PROPERTIES
    
    @Binding var houseIndex: Int
    
    @State private var position: Int = 0
    @State private var rooms: [Room] = []

    // MARK: - BODY
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            ScrollViewReader { proxy in
                LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                    Section(
                        header: SectionView(title: "Rooms", rotateClockwise: false),
                        footer: SectionView(title: "Rooms", rotateClockwise: true)
                    ) {
                        ForEach(rooms) { room in
                            RoomView(room: room)
                        }
                        Button(action: {}, label: {
                            HStack(alignment: .center, spacing: 6) {
                                Image(systemName: "house.circle.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .foregroundColor(.gray)
                                
                                Text(("Add a Room").uppercased())
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }//: HSTACK
                            .padding()
                            .background(Color.white.cornerRadius(12))
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        })//: BUTTON
                    }
                })//: GRID
                .frame(height: 140)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .onChange(of: houseIndex) { value in
                    withAnimation {
                        proxy.scrollTo(0, anchor: .top)
                    }
                }
            }
        }).onAppear(perform: readFile)
    }
    
    func readFile() {
        if let jsonData: User = Bundle.main.decode("data.json") {
            self.rooms = (jsonData.document?.house![self.houseIndex].interior?.rooms)!
        }
    }
}

