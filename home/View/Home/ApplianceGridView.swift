//
//  ApplianceGridView.swift
//  home
//
//  Created by Scott Courtney on 12/29/22.
//

import SwiftUI

struct ApplianceGridView: View {
    // MARK: - PROPERTIES
    
    @Binding var houseIndex: Int
    @State private var showFormView: Bool = false


    // MARK: - BODY
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                Section(
                    header: SectionView(title: "Appliances", rotateClockwise: false),
                    footer: SectionView(title: "Appliances", rotateClockwise: true)
                )
                {
                    ForEach((users.document?.house?[self.houseIndex].interior?.appliances)!) { appliance in
                        ApplianceView(appliance: appliance)
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
                            
                            Text(("Add an Appliance").uppercased())
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
                    .sheet(isPresented: $showFormView) {
                        ApplianceFormView(houseIndex: $houseIndex)
                    }
                }
            })//: GRID
            .frame(height: 140)
//            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        })
    }
}

