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

    let appliance: Appliance

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
        })//: BUTTON
        .sheet(isPresented: $isModal, content: {
            ApplianceDetailView(appliance: appliance)
        })
    }
}

// MARK: - PREVIEW

struct ApplianceView_Previews: PreviewProvider {
    static var previews: some View {
        ApplianceView(appliance: (users.document?.house![0].interior?.appliances![0])!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

