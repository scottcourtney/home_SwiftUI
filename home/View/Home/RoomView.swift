//
//  RoomView.swift
//  home
//
//  Created by Scott Courtney on 12/13/22.
//

import SwiftUI

struct RoomView: View {
    // MARK: - PROPERTY
    
    @State var isModal: Bool = false
    
    let room: Room

    // MARK: - BODY
    
    var body: some View {
        Button(action: {
            self.isModal = true
        }, label: {
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "house.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.gray)
                
                Text((room.nickname?.uppercased())!)
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
        .sheet(isPresented: $isModal, content: {
            RoomDetailView(room: room)
        })
    }
}

// MARK: - PREVIEW

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(room: (users.document?.house![0].interior?.rooms![0])!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
