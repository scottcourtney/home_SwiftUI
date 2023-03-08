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

    var body: some View {
        HStack {
                
            Stepper("", onIncrement: {
                            filterCount += 1
                        }, onDecrement: {
                            if filterCount >= 1 {
                                filterCount -= 1
                            }
                        })
            
            Text(String(filterCount))
                .onChange(of: filterCount) { value in
                    if filterCount == newFilterCount {
                        dismissDisabled.state = false
                        print("old \(String(filterCount))")
                              } else {
                                  dismissDisabled.state = true
                            print("new \(String(filterCount))")
                        }
                }
        }
        .onAppear {
            newFilterCount = filterCount
        }
    }
}
