//
//  coreData1App.swift
//  coreData1
//
//  Created by Janaka Balasooriya on 3/5/23.
//

import SwiftUI

@main
struct coreData1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(name:"", phone: "", address: "")
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
