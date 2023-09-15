//
//  FitnessPalApp.swift
//  FitnessPal
//
//  Created by Sean Campbell on 3/16/23.
//

import SwiftUI
import UIKit
import CoreLocation

@main
struct FitnessPalApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        /**
         This running path map has several configurable settings. This code provides the default value for the settings, which
         are in `application(_:willFinishLaunchingWithOptions:)` because the app needs to set
         default values before the app fully launches.
         */
        let defaultPreferences: [String: Any] = [
            SettingsKeys.chimeOnLocationUpdate.rawValue: true,
            SettingsKeys.accuracy.rawValue: kCLLocationAccuracyBest,
            SettingsKeys.showRunBoundingArea.rawValue: true,
            SettingsKeys.activity.rawValue: CLActivityType.fitness.rawValue
        ]
        UserDefaults.standard.register(defaults: defaultPreferences)
        
        return true
    }
}
