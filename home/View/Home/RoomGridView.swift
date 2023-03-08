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
                    HStack {
                        ForEach(rooms) { room in
                            RoomView(houseIndex: $houseIndex, room: room)
                                .id(room.id)
                        }
                        Button(action: {
                            showFormView.toggle()
                        }, label: {
                            HStack(alignment: .center, spacing: 6) {
                                Image(systemName: "plus.app.fill")
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 50.0, height: 50.0)
                                    .overlay(Circle().stroke(Color.white,lineWidth:4).shadow(radius: 10))
                                    .padding(.all, 6)
                                    .foregroundColor(.gray)
                            }//: HSTACK
                            .frame(width: 100.0, height: 100.0)
                            .background(Color.white.cornerRadius(12))
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        })//: BUTTON
                        .padding(.trailing, 10)
                        .fullScreenCover(isPresented: $showFormView, onDismiss: {
                            readFile()
                        }, content: {
                            RoomFormView(houseIndex: $houseIndex)
                        })
                        .onChange(of: houseIndex, perform: { value in
                            readFile()
                            withAnimation {
                                scrollView.scrollTo(position.first, anchor: .leading)
                            }
                        })
                    }.padding(.leading, 10)
                }).onAppear(perform: readFile)
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

