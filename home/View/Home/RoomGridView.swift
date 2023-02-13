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
    
    @State private var position: [String] = []
    @State private var rooms: [Room] = []
    @State private var showFormView: Bool = false

    // MARK: - BODY
    
    var body: some View {
        VStack {
            HStack {
                Text("Rooms")
                    .padding(.leading, 10)
                Spacer()
            }
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false, content: {
                    //            ScrollViewReader { proxy in
                    HStack {
                        ForEach(rooms) { room in
                            RoomView(room: room)
                                .id(room.id)
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
                        
                        //                    .frame(height: 140)
                        //                    .padding(.vertical, 10)
                        .onChange(of: houseIndex, perform: { value in
                            readFile()
                            withAnimation {
                                scrollView.scrollTo(position.first)
                            }
                        })
                    }
                    //            }
                }).onAppear(perform: readFile)
                    .padding(.leading, 10)
            }
    }
        .padding(.bottom, 10)

    }
        func readFile() {
            if let jsonData: User = Bundle.main.decode("data.json") {
                guard let rooms = jsonData.document?.house?[self.houseIndex].interior?.rooms else {
                    self.rooms.removeAll()
                    return
                }
                self.rooms = rooms
                getPosition(rooms: rooms)
            }
        }
    
    func getPosition(rooms: [Room]) {
        if position.isEmpty {
            for room in rooms {
                position.append(room.id!)
            }
        }
    }
}

