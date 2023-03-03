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
                                Image(systemName: "plus.app.fill")
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 50.0, height: 50.0)
                                    .overlay(Circle().stroke(Color.white,lineWidth:4).shadow(radius: 10))
                                    .padding(.all, 6)
                                    .foregroundColor(.gray)
                            }//: HSTACK
                            .frame(width: 80.0, height: 80.0)
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
                            ApplianceFormView(houseIndex: $houseIndex)
                        })
                    
                        .onChange(of: houseIndex) { value in
                            readFile()
                            withAnimation {
                                scrollView.scrollTo(position.first)
                            }
                        }
                    }.padding(.leading, 10)
                    
                }).onAppear(perform: readFile)
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

