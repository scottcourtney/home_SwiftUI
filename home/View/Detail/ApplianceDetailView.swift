//
//  ApplianceDetailView.swift
//  home
//
//  Created by Scott Courtney on 12/30/22.
//

import SwiftUI

struct ApplianceDetailView: View {
    // MARK: - PROPERTY

//    let room: Room
    let appliance: Appliance

    var body: some View {
        NavigationView() {
            VStack {
                Form {
                    Section(header: Text(appliance.nickname ?? "N/A")) {
                        Label {
                            Text(("Brand").uppercased())
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(appliance.brand ?? "")
                        } icon: {}
                        Label {
                            Text(("Model").uppercased())
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(appliance.model ?? "")
                        } icon: {}
                        Label {
                            Text(("Website").uppercased())
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Text(appliance.website ?? "")
                                Spacer()
                                if appliance.website != "" {
                                    Link(destination: URL(string: appliance.website ?? "")!) {
                                        Image(systemName: "paperplane.fill")
                                    }
                                }
                            }//: HSTACK
                        } icon: {}
                        Label {
                            Text(("Other").uppercased())
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(appliance.other ?? "")
                        } icon: {}
                    }
                }//: FORM
            }//: VSTACK
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button("Save", action: {
                        print("Save Button Tapped")
                    })//: BUTTON
                }
            }
        }//: NAVIGATIONVIEW
    }
}

struct ApplianceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApplianceDetailView(appliance: (users.document?.house![0].interior?.appliances![0])!)
    }
}
