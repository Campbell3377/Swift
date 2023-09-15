//
//  Lab6App.swift
//  Lab6
//
//  Created by Sean Campbell on 3/28/23.
//

import SwiftUI

@main
struct Lab6App: App {

    var body: some Scene {
        WindowGroup {
            ContentView(dataController: coreDataController())
        }
    }
}
