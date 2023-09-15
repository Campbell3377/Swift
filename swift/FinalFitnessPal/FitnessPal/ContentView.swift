//
//  ContentView.swift
//  FitnessPal
//
//  Created by Sean Campbell on 3/16/23.
//
import Foundation
import SwiftUI
//import HealthKit
//import HealthKitUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    
    var body: some View {
        //let wModel = WorkoutModel()
        TabView {
            CalorieView()
                .tabItem {
                    Label("Calories", systemImage: "bolt.heart")
                }
            
            WorkoutView(workouts: [])
                .tabItem {
                    Label("Exercise", systemImage: "dumbbell")
                }
            RunView()
                .tabItem {
                    Label("Run Path", systemImage: "figure.run")
                }
            //ActivityView()
        }
    }
    
    
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
