//
//  RoomView.swift
//  home
//
//  Created by Scott Courtney on 12/13/22.
//

import SwiftUI

struct RoomView: View {
    // MARK: - PROPERTY
    
    @State var isPresented: Bool = false

    let room: Room

    // MARK: - BODY
    
    var body: some View {
        Button(action: {
            self.isPresented = true
        }, label: {
            HStack(alignment: .center, spacing: 6) {
                Image("interior_img")
//                    .renderingMode(.template)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100.0, height: 100.0)
                    .overlay(Circle().stroke(Color.white,lineWidth:4).shadow(radius: 10))
                    .padding(.all, 6)
                    .padding(.trailing, 20)
                VStack(alignment: .leading) {
                    Text((room.nickname?.uppercased())!)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding(.bottom, 6)
                    Text((room.roomType?.uppercased())!)
                        .font(.system(size: 12, weight: .light, design: .default))
                        .foregroundColor(.gray)
                }
                Spacer()

            }//: HSTACK
            .frame(maxWidth: .infinity, alignment: .center)
//            .padding()
            .background(Color.white.cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .contextMenu {
                Button(role: .destructive) {
                    print("Delete Room Pressed")
                } label: {
                    Label("Remove Room", systemImage: "minus.circle")
                        .foregroundColor(.red)
                }
                Button(role: .cancel) {
                    print("Cancel")
                } label: {
                    Label("Cancel", systemImage: "")
                }
            }
        })//: BUTTON
        .fullScreenCover(isPresented: $isPresented, content: {
            RoomDetailView(room: room)
        })
    }
}
