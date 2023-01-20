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
    @State private var futureDate = Date()
    @State private var replaceNotification = false
    @State private var uuidString = ""

    @State var filters: [Filter]
    
    let notification = NotificationService()
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        NavigationView() {
            VStack {
                Form {
                    ForEach(filters.indices) { index in
                        Section(header: Text(filters[index].nickname ?? "N/A")) {
                            Label {
                                Text("Size")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(filters[index].size ?? "N/A")
                                
                            } icon: {}
                            Label {
                                Text("Filters Left")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                FilterStepperView(filterCount: filters[index].filtersLeft!)
                                
                            } icon: {}
                            
                            Label {
                                Text("Replacement Date")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                                FilterDateView(filterDate: filters[index].replacedDate!)
                       
                            } icon: {}
                            Label {
                                Text("Order More")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Button(action: {
                                    guard let size = filters[index].size else { return }
                                    openAmazonProduct(withSize: size)
                                    print("Order more pressed")
                                }, label: {
                                    Image(systemName: "square.and.arrow.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                })
                                
                            } icon: {}
                                                        
                            Toggle(isOn: $filters[index].filterNotification, label: {
                                Text("Replacement Notification")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            })
                            .onChange(of: filters[index].filterNotification) { value in
                                print(filters[index].filterNotification)
                                if filters[index].filterNotification == true {
                                    futureDateConversion(replacedDate: dateFormatter.date(from: filters[index].replacedDate!)!)
                                    uuidString = notification.scheduleNotification(date: futureDate,
                                                                      title: "Replace Filter",
                                                                      body: "\(filters[index].nickname!) Filter needs to be replaced.")
                                    print("Replace \(filters[index].nickname!) Filter on \(dateFormatter.string(from: futureDate))")
                                } else {
                                    notification.cancelNotification(uuidString: uuidString)
                                    print("Cancelled Notification")
                                }
                            }
                        }//: SECTION
                    }//: FORM
                }
            }//: VSTACK
            .onAppear {
                notification.setupNotificationAuth()
            }
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
            .navigationTitle("Filters")
        }//: NAVIGATIONVIEW

    }
        
    func openAmazonProduct(withSize size: String) {
        
        guard let amazonWebURL = URL(string: "https://www.amazon.com/s?k=Filter+Size+\(size)"),
              let amazonAppURL = URL(string: "com.amazon.mobile.shopping://www.amazon.com/s?k=Filter+Size+\(size)") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(amazonAppURL) {
            UIApplication.shared.open(amazonAppURL, options: [:], completionHandler: nil)
        }
        else if UIApplication.shared.canOpenURL(amazonWebURL) {
            UIApplication.shared.open(amazonWebURL, options: [:], completionHandler: nil)
        }
    }
    
    func futureDateConversion(replacedDate: Date) {
        var dateComponent = DateComponents()
//        dateComponent.month = 3
        dateComponent.day = 10
        
        futureDate = Calendar.current.date(byAdding: dateComponent, to: replacedDate)!
    }
}
