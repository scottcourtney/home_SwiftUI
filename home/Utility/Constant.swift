//
//  Constant.swift
//  home
//
//  Created by Scott Courtney on 12/8/22.
//

import SwiftUI

// DATA

//let users: User = Bundle.main.decode("data.json")
//let users: User = Bundle.main.decodeFile("data.json")


// COLOR

let colorBackground: Color = Color("")
let colorGray: Color = Color(UIColor.systemGray4)

// LAYOUT

let columnSpacing: CGFloat = 10
let rowSpacing: CGFloat = 10
var gridLayout: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}

// UX

// API

let API_URL = "https://data.mongodb-api.com/app/data-nlwkp/endpoint/data/v1/action"
let COLLECTION = "UserData"
let DATABASE = "home"
let DATASOURCE = "home"
let EMAIL = "sncourtney11@yahoo.com"
let PASSWORD = "nicole"


// IMAGE
// FONT
// STRING
// MISC
