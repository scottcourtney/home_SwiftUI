//
//  FilterDetailView.swift
//  home
//
//  Created by Scott Courtney on 1/13/23.
//

import SwiftUI

struct FilterDetailView: View {
    
        // MARK: - PROPERTY
        @Environment(\.dismiss) var dismiss
        @State private var isEditing = false
        @State private var filterReplaced = false

        var filters: [Filter]

        var body: some View {
            NavigationView() {
                VStack {
                    ForEach(filters) { filter in
                        Form {
                            Section(header: Text(filter.nickname ?? "N/A")) {
                                Label {
                                    Text("Size")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text(filter.size ?? "N/A")

                                } icon: {}
                                Label {
                                    Text("Filters Left")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    HStack {
                                        Text(String(filter.filtersLeft ?? 0))
//                                        Stepper("", onIncrement: {
//                                            filter.filtersLeft += 1
//                                        }, onDecrement: {
//                                            filter.filtersLeft -= 1
//                                        })
                                    }

                                } icon: {}
                                Label {
                                    Text("Date Filter was Replaced")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text(filter.replacedDate ?? "N/A")



                                } icon: {}
                                
                                Toggle("Filter Replaced?", isOn: $filterReplaced)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
//                                if filterReplaced {
//                                    print("Filter was replaced")
//                                }
//                                
                            }//: SECTION
                        }//: FORM
                    }
                }//: VSTACK

                .navigationTitle("Filters")

            }//: NAVIGATIONVIEW
        }
    }
