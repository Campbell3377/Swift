//
//  FitnessTrackerApp.swift
//  FitnessTracker
//
//  Created by Sean Campbell on 2/28/23.
//

import SwiftUI

@main
struct FitnessTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
