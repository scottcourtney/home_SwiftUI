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
    @State private var filterCount: Int = 0
    @State private var date = Date()
        
    var filters: [Filter]
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
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
                                
                                FilterStepperView(filterCount: filter.filtersLeft!)
                                
                            } icon: {}
                            
                            Label {
                            Text("Replacement Date")
                                    .font(.footnote)
                                    .foregroundColor(.gray)

                                DatePicker("",
                                           selection: Binding(
                                            get: { date },
                                            set:{
                                                date = $0
                                                UIApplication.shared.inputView?.endEditing(true)
                                            }),
                                           displayedComponents: .date
                                )
                            } icon: {}
                            Label {
                                Text("Order More")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Button(action: {
                                    guard let size = filter.size else { return }
                                    openAmazonProduct(withSize: size)
                                    print("Order more pressed")
                                }, label: {
                                    Image(systemName: "square.and.arrow.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                })
                                
                            } icon: {}
                        }//: SECTION
                    }//: FORM
                }
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
            .navigationTitle("Filters")
        }//: NAVIGATIONVIEW
    }
    
    func openAmazonProduct(withSize size: String) {
        
        guard let amazonWebURL = URL(string: "https://www.amazon.com/s?k=filter+size+\(size)"),
                 let amazonAppURL = URL(string: "com.amazon.mobile.shopping://www.amazon.com/products/\(size)/") else {
                     return
           }
                
           if UIApplication.shared.canOpenURL(amazonAppURL) {
                    UIApplication.shared.open(amazonAppURL, options: [:], completionHandler: nil)
           }
           else if UIApplication.shared.canOpenURL(amazonWebURL) {
                    UIApplication.shared.open(amazonWebURL, options: [:], completionHandler: nil)
           }
    }
    
}
