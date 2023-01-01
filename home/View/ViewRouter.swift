//
//  ViewRouter.swift
//  home
//
//  Created by Scott Courtney on 12/28/22.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .signInPage
    
}

enum Page {
    case signUpPage
    case signInPage
    case contentPage
}
