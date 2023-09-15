//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Sean Campbell on 2/25/23.
//

import SwiftUI

@main
struct movieInfoSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(title: "It", genre: "Horror", price: "12", searchTitle: "", searchGenre: "", searchPrice: "", deleteS: "", list: [], listIndex: 0, message: "")
        }
    }
}
