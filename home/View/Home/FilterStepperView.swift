//
//  FilterStepperView.swift
//  home
//
//  Created by Scott Courtney on 1/19/23.
//

import SwiftUI

class DismissDisabled: ObservableObject {
    @Published var state = false
}

struct FilterStepperView: View {
    
    @EnvironmentObject var dismissDisabled: DismissDisabled
    
    @State var filterCount: Int
    @State private var newFilterCount = 0
    @Binding var filter: Filter

    var body: some View {
        HStack {
                
            Stepper("", onIncrement: {
                filter.filtersLeft! += 1
                        }, onDecrement: {
                            if filter.filtersLeft! >= 1 {
                                filter.filtersLeft! -= 1
                            }
                        })
            
            Text(String(filter.filtersLeft!))
                .onChange(of: filter.filtersLeft) { value in
                    if filter.filtersLeft == newFilterCount {
                        dismissDisabled.state = false
                        print("old \(String(filter.filtersLeft!))")
                              } else {
                                  dismissDisabled.state = true
                            print("new \(String(filter.filtersLeft!))")
                        }
                }
        }
        .onAppear {
            newFilterCount = filter.filtersLeft!
        }
        
    }
}
