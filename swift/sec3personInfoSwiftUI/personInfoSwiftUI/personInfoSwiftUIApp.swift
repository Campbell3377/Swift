//
//  personInfoSwiftUIApp.swift
//  personInfoSwiftUI
//
//  Created by Janaka Balasooriya on 2/11/23.
//

import SwiftUI

@main
struct personInfoSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(title: "Janaka", genre: "10", price: "1", searchTitle: "", searchGenre: "", searchPrice: "", deleteS: "", list: [], listIndex: 0, message:"")
        }
    }
}
