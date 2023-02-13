//
//  FilterStepperView.swift
//  home
//
//  Created by Scott Courtney on 1/19/23.
//

import SwiftUI

struct FilterStepperView: View {
    
    @State var filterCount: Int

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

            
        }
    }
}
