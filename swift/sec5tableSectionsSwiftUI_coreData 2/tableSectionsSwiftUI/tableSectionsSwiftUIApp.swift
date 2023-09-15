//
//  tableSectionsSwiftUIApp.swift
//  tableSectionsSwiftUI
//
//  Created by Janaka Balasooriya on 2/18/23.
//

import SwiftUI

@main
struct tableSectionsSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(dataController: coreDataController())
        }
    }
}
