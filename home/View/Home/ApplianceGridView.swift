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
    
    @State private var position: [UUID] = []
    @State private var houses: [House] = []
    @State private var showFormView: Bool = false
    @State private var appliances: [Appliance] = []
    @State private var didLongPress = false
    @State private var stored: Int = 0
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            HStack {
                Text("Appliances")
                    .padding(.leading, 10)
                Spacer()
            }
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack {
                        ForEach(appliances) { appliance in
                            ApplianceView(appliance: appliance)
                                .id(appliance.id)
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
                        
                        //                    .frame(height: 140)
                        //                    .padding(.vertical, 10)
                        .onChange(of: houseIndex) { value in
                            readFile()
                            withAnimation {
                                scrollView.scrollTo(position.first)
                            }
                        }
                    }.padding(.leading, 10)
                    
                }).onAppear(perform: readFile)
//                    .padding(.leading, 10)
            }
        }
        .padding(.bottom, 10)
        
    }
    
    func readFile() {
        if let jsonData: User = Bundle.main.decode("data.json") {
            guard let appliances = jsonData.document?.house?[self.houseIndex].interior?.appliances else {
                self.appliances.removeAll()
                return
            }
            self.appliances = appliances
            getPosition(appliances: appliances)
            
        }
    }
    
    func getPosition(appliances: [Appliance]) {
        if position.isEmpty {
            for appliance in appliances {
                position.append(appliance.id)
            }
        }
    }
}

