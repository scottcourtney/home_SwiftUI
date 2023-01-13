//
//  MiscGridView.swift
//  home
//
//  Created by Scott Courtney on 1/13/23.
//

import SwiftUI

struct MiscGridView: View {
    // MARK: - PROPERTIES
    
    @Binding var houseIndex: Int
    @State private var filters: [Filter] = []
    @State private var lightbulbs: [Lightbulb] = []
    @State private var showLightbulbListView: Bool = false
    @State private var showFilterListView: Bool = false

    // MARK: - BODY
    
    var body: some View {
        
        HStack {
            Button(action: {
                showFilterListView.toggle()
            }, label: {
                HStack(alignment: .center, spacing: 6) {
                    Spacer()
                    
                    Text(("Filters").uppercased())
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }//: HSTACK
                .padding()
                .background(Color.white.cornerRadius(12))
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1)
                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                    
                )
            })//: BUTTON
            .sheet(isPresented: $showFilterListView, onDismiss: {
//                readFile()
            }, content: {
                FilterDetailView(filters: filters)
            })
            
            Spacer()
            
            Button(action: {
                showLightbulbListView.toggle()
            }, label: {
                HStack(alignment: .center, spacing: 6) {
                    Spacer()
                    
                    Text(("lightbulbs").uppercased())
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    Spacer()
                }//: HSTACK
                .padding()
                .background(Color.white.cornerRadius(12))
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1)
                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                )
            })//: BUTTON
            .sheet(isPresented: $showLightbulbListView, onDismiss: {
//                readFile()
            }, content: {
                LightbulbDetailView(lightbulbs: lightbulbs)
            })
        }//: HSTACK
        .onChange(of: houseIndex) { value in
            readFile()
        }
        .onAppear(perform: readFile)
    }
    //
            func readFile() {
                if let jsonData: User = Bundle.main.decode("data.json") {
                    self.filters = (jsonData.document?.house![self.houseIndex].interior?.misc?.filters)!
                    self.lightbulbs = (jsonData.document?.house![self.houseIndex].interior?.misc?.lightbulbs)!

                }
            }
}