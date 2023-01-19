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
        VStack(alignment: .trailing) {
            Text(String(filterCount))
                
            Stepper("", onIncrement: {
                            filterCount += 1
                        }, onDecrement: {
                            filterCount -= 1
                        })        }
    }
}
