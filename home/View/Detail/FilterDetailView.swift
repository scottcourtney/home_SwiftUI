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
    @StateObject var dismissDisabled = DismissDisabled()
    @State private var isPresentingConfirm: Bool = false
    @State private var isPresentingAlert: Bool = false

    
    @State private var isEditing = false
    @State private var filterCount: Int = 0
    @State private var date = Date()
    @State private var futureDate = Date()
    @State private var replaceNotification = false
    
    @State var filters: [Filter]
    
    @State private var showingAlert = false
    @State private var showAddAlert = false
    
    @State private var nickname: String = ""
    @State private var size: String = ""
    @State private var filtersLeft: String = ""
    @State private var replacementDate: String = ""
    
    let notification = NotificationService()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    var body: some View {
     
        NavigationView() {
            VStack {
                Form {
                    HStack {
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("Add a Filter")
                        })
                        .alert("", isPresented: $showAddAlert) {
                            TextField("Nickname", text: $nickname)
                            TextField("Size", text: $size)
                            TextField("Filters Left", text: $filtersLeft)
                            Button("Submit", action: addFilter)
                            Button("Cancel", role: .cancel) {}
                        } message: {
                            Text("Add a Filter")
                        }
                        
                        Spacer()
                    }
                    ForEach(filters.indices, id: \.self) { index in
                        Section(header:
                                    HStack {
                            Text(filters[index].nickname ?? "N/A")
                            Spacer()
                            Button(action: { showingAlert = true }, label: {
                                Image(systemName: "x.circle")
                                    .foregroundColor(Color.red)
                            }).alert(isPresented: $showingAlert) {
                                Alert(
                                    title: Text("Remove \(filters[index].nickname ?? "") from Filters?"),
                                    primaryButton: .destructive(Text("Delete")) {
//                                        removeLightbulb(id: lightbulb.id)
                                    },
                                    secondaryButton: .cancel())
                            }
                        }) {
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
                                
                                if let filtersLeft = filters[index].filtersLeft {
                                    FilterStepperView(filterCount: filtersLeft)
                                        .environmentObject(dismissDisabled)

                                } else {
                                    FilterStepperView(filterCount: 0)
                                        .environmentObject(dismissDisabled)

                                }
                            } icon: {}
                                
                            Label {
                                Text("Replacement Date")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                                if let replacedDate = filters[index].replacedDate {
                                    FilterDateView(filterDate: replacedDate)
                                } else {
                                    FilterDateView(filterDate: dateFormatter.string(from: Date()))
                                }
                       
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
                                    notification.scheduleNotification(date: futureDate,
                                                                      title: "Replace Filter",
                                                                      body: "\(filters[index].nickname!) Filter needs to be replaced.",
                                                                      uuid: filters[index].id)
                                    print("Replace \(filters[index].nickname!) Filter on \(dateFormatter.string(from: futureDate))")
                                } else {
                                    notification.cancelNotification(uuid: filters[index].id)
                                    print("Cancelled Notification")
                                }
                            }
                        }//: SECTION
                        .id(filters[index].id)

                    }
                }//: FORM
            }//: VSTACK
            .onAppear {
                notification.setupNotificationAuth()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action: {
                        if !dismissDisabled.state {
                            dismiss()
                        } else {
                            isPresentingAlert = true
                        }
                    }, label: {
                        Label("Cancel", systemImage: "plus")
                            .labelStyle(.titleOnly)
                    })//: BUTTON
                }
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button(action: { save() }, label: {
                        Label("Save", systemImage: "plus")
                            .labelStyle(.titleOnly)
                    })//: BUTTON
                }
            }
            .navigationBarTitle("Filters", displayMode: .inline)
        }//: NAVIGATIONVIEW
        .alert("Do you want to save the changes?", isPresented: $isPresentingAlert, actions: {
            Button("Cancel", role: .destructive, action: {
                print("Change values back")
                dismiss()
            })
            Button("Save", role: .cancel, action: {
                print("Save the values")
                save()
            })
        }, message: {
            Text("Pressing Cancel will remove your changes.")
        })
    }
    
    

    private func removeFilter(id: UUID) {
        print(id)
        filters.removeAll(where: { $0.id == id })
        delete(id: id)
    }
    
    private func addFilter() {
        filters.append(Filter(id: UUID(), filtersLeft: Int(filtersLeft), nickname: nickname, size: size, replacedDate: dateFormatter.string(from: futureDate), filterNotification: false, filterReplacementDate: dateFormatter.string(from: futureDate)))
    }
    
    private func save() {
        for filter in filters {
            print(filter.id)
        }
        //        let newestLightBulb = lightbulbs.last
        //        ApiService().addLightbulb(
        //            houseId: houses[self.houseIndex].id!,
        //            nickname: newestLightBulb?.nickname ?? "",
        //            id: newestLightBulb?.id ?? UUID(),
        //            brand: newestLightBulb?.brand ?? "",
        //            model: newestLightBulb?.model ?? "",
        //            watts: newestLightBulb?.watts ?? ""
        //        ) { (result) in
        //            if result == true {
        //                ApiService().getUserData() { (result) in
        //                }
        //            }
        //        }
        dismiss()
    }
    
    private func delete(id: UUID) {
        //        ApiService().removeLightbulb(
        //            houseId: houses[self.houseIndex].id!,
        //            id: id
        //        ) { (result) in
        //            if result == true {
        //                ApiService().getUserData() { (result) in
        //                }
        //            }
        //        }
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
