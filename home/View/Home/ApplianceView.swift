//
//  ApplianceView.swift
//  home
//
//  Created by Scott Courtney on 12/29/22.
//

import SwiftUI

struct ApplianceView: View {
    // MARK: - PROPERTY
    @State var isModal: Bool = false
    @State private var didLongPress = false
    
    let appliance: Appliance
    
    // MARK: - BODY
    
    var body: some View {
        Button(action: {}, label: {
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "house.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.gray)
                
                Text((appliance.nickname?.uppercased())!)
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
            .contextMenu {
                Button(role: .destructive) {
                    print("Delete Appliance Pressed")
                } label: {
                    Label("Remove Appliance", systemImage: "minus.circle")
                        .foregroundColor(Color.red)
                }
                Button(role: .cancel) {
                    print("Cancel")
                } label: {
                    Label("Cancel", systemImage: "")
                }
            }
        })//: BUTTON
        .sheet(isPresented: $isModal, content: {
            ApplianceDetailView(appliance: appliance)
        })
        .simultaneousGesture(
            LongPressGesture().onEnded { _ in self.didLongPress = true
                print("Long Press")
            })
        .highPriorityGesture(TapGesture().onEnded { _ in
            if didLongPress != true {
                self.isModal = true
            }
            print("TAP")
        })
    }
}

// MARK: - PREVIEW
//
//struct ApplianceView_Previews: PreviewProvider {
//    static var previews: some View {
//        ApplianceView(appliance: (users.document?.house![0].interior?.appliances![0])!)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}

