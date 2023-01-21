//
//  RoomGridView.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import SwiftUI

struct RoomGridView: View {
    // MARK: - PROPERTIES
    
    @Binding var houseIndex: Int
    
    @State private var position: Int = 0
    @State private var rooms: [Room] = []
    @State private var showFormView: Bool = false
    @State private var hideSection: Bool = false

    // MARK: - BODY
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            ScrollViewReader { proxy in
                LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                    Section(
                        header: SectionView(title: "Rooms", rotateClockwise: false).opacity(hideSection ? 0 : 1),
                        footer: SectionView(title: "Rooms", rotateClockwise: true).opacity(hideSection ? 0 : 1)
                    ){
                        ForEach(rooms) { room in
                            RoomView(room: room)
                        }
                        Button(action: {
                            showFormView.toggle()
                        }, label: {
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
                        .fullScreenCover(isPresented: $showFormView, onDismiss: {
                            readFile()
                        }, content: {
                            RoomFormView(houseIndex: $houseIndex)
                        })
                    }
                })//: GRID
                .frame(height: 140)
                .padding(.vertical, 10)
                .onChange(of: houseIndex) { value in
                    readFile()
                    withAnimation {
                        proxy.scrollTo(0, anchor: .top)
                    }
                }
            }
        }).onAppear(perform: readFile)
    }
    
    func readFile() {
        if let jsonData: User = Bundle.main.decode("data.json") {
            guard let rooms = jsonData.document?.house?[self.houseIndex].interior?.rooms else {
                self.rooms.removeAll()
                return
            }
            if rooms.count > 0 {
                hideSection = false
            }
            self.rooms = rooms
        }
    }
}

