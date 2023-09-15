//
//  coreDataImageSwiftUIApp.swift
//  coreDataImageSwiftUI
//
//  Created by Janaka Balasooriya on 3/5/23.
//

import SwiftUI

@main
struct coreDataImageSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
