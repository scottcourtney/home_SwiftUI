//
//  homeApp.swift
//  home
//
//  Created by Scott Courtney on 12/7/22.
//

import SwiftUI
import Firebase

@main
struct homeApp: App {
    // MARK: - PROPERTIES
    @StateObject var viewRouter = ViewRouter()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(ViewRouter())
        }
    }
}
