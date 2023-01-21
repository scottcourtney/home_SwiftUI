//
//  LightbulbDetailView.swift
//  home
//
//  Created by Scott Courtney on 1/13/23.
//

import SwiftUI

struct LightbulbDetailView: View {
        
            // MARK: - PROPERTY
            @Environment(\.dismiss) var dismiss
            @State private var isEditing = false
            @State private var filterReplaced = false

            var lightbulbs: [Lightbulb]

            var body: some View {
                NavigationView() {
                    VStack {
                        Form {
                        ForEach(lightbulbs) { lightbulb in
                                Section(header: Text(lightbulb.nickname ?? "N/A")) {
                                    Label {
                                        Text("Brand")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text(lightbulb.brand ?? "N/A")

                                    } icon: {}
                                    Label {
                                        Text("Model")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text(lightbulb.model ?? "N/A")
                                    } icon: {}
                                    Label {
                                        Text("Watts")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text(lightbulb.watts ?? "N/A")
                                    } icon: {}
                                }//: SECTION
                            }
                            Button(action: {}) {
                                HStack {
                                    Spacer()
                                    Text("Add Lightbulb")
                                    Spacer()
                                }
                            }
                        }//: FORM
                    }//: VSTACK
                    .toolbar {
                        
                        ToolbarItemGroup(placement: .navigationBarTrailing){
                            Button("Save", action: {
                                print("Edit Button Tapped")
                            })//: BUTTON
                        }
                        ToolbarItemGroup(placement: .navigationBarLeading){
                            Button("Cancel", action: {
                                withAnimation {
                                    dismiss()
                                }
                                
                                print("Cancel Button Tapped")
                            })//: BUTTON
                            
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Lightbulbs")

                }//: NAVIGATIONVIEW
            }
        }
