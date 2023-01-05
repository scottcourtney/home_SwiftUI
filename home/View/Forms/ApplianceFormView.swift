//
//  ApplianceFormView.swift
//  home
//
//  Created by Scott Courtney on 1/2/23.
//

import SwiftUI

struct ApplianceFormView: View {
    let userDefaults = UserDefaults.standard
    
    @Environment(\.dismiss) private var dismiss

    @Binding var houseIndex: Int

    @State private var nickname: String = ""
    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var website: String = ""
    @State private var otherInformation: String = ""

    var body: some View {
        NavigationView() {
            VStack {
                Form {
                    Section(header: Text("Appliance")) {
                        Label {
                            TextField("Name",
                                      text: $nickname
                            )
                        } icon: {}
                        Label {
                            TextField("Brand",
                                      text: $brand
                            )
                        } icon: {}
                        Label {
                            TextField("Model",
                                      text: $model
                            )
                        } icon: {}
                        Label {
                                TextField("Website",
                                          text: $website
                                )
                        } icon: {}
                        Label {
                            TextField("Other Information",
                                      text: $otherInformation
                            )
                        } icon: {}
                    }
                }//: FORM
            }//: VSTACK
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button("Save", action: {
                        Api().addAppliance(
                            token: SignInView().token,
                            userId: (users.document?.userInfo?.userID)!,
                            houseId: (users.document?.house?[self.houseIndex].id)!,
                            nickname: nickname,
                            brand: brand,
                            model: model,
                            website: website,
                            otherInformation: otherInformation) { (result) in
                                if result == true {
                                    Api().getUserData(token: token, userId: (users.document?.userInfo?.userID)!) { (result) in
                                        print(result)
                                    }
                                }
                            }
                        withAnimation {
                            dismiss()
                        }
                        print("Edit Button Tapped")
                    })//: BUTTON
                    
                }
            }
        }//: NAVIGATIONVIEW
    }
}

//struct ApplianceFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ApplianceFormView()
//    }
//}
