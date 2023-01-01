//
//  ContentView.swift
//  home
//
//  Created by Scott Courtney on 12/7/22.
//

import SwiftUI

struct MotherView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var viewRouter: ViewRouter
        
    // MARK: - BODY
        var body: some View {
//            switch viewRouter.currentPage {
//            case .signUpPage:
//                SignUpView()
//            case .signInPage:
//                SignInView()
//            case .contentPage:
                ContentView()
//            }
        }
    }

// MARK: - PREVIEW
struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
            .environmentObject(ViewRouter())
    }
}
