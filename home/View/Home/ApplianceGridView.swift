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
    @State private var houses: [House] = []
    @State private var showFormView: Bool = false
    @State private var appliances: [Appliance] = []
    @State private var didLongPress = false
    @State private var stored: Int = 0


    // MARK: - BODY
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            ScrollViewReader { proxy in
                LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                    Section(
                        header: SectionView(title: "Appliances", rotateClockwise: false),
                        footer: SectionView(title: "Appliances", rotateClockwise: true)
                    )
                    {
                        ForEach(appliances) { appliance in
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
                        .fullScreenCover(isPresented: $showFormView, onDismiss: {
                            readFile()
                        }, content: {
                            ApplianceFormView(houseIndex: $houseIndex)
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
            self.appliances = (jsonData.document?.house![self.houseIndex].interior?.appliances)!
        }
    }
}

