//
//  FilterDateView.swift
//  home
//
//  Created by Scott Courtney on 1/20/23.
//

import SwiftUI

struct FilterDateView: View {
    
    @State private var date = Date()
    @State var filterDate: String
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        DatePicker("",
                   selection: Binding(
                    get: { date },
                    set:{
                        date = $0
                        UIApplication.shared.inputView?.endEditing(true)
                    }),
                   displayedComponents: .date
        )
        .onAppear {
            if let date = dateFormatter.date(from: filterDate) {
                self.date = date
                print(self.date)
            }
        }
        .padding(.bottom, 2)
    }
}
