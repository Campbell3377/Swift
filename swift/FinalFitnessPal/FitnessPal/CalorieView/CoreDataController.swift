//
//  CoreDataController.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/14/23.
//

import UIKit
import Foundation
import CoreData
class coreDataController : ObservableObject
{
    @Published var CalorieData:[CalorieEntry] = []
    
    //@Published var calorieGoal:Goal = Goal()
    
    // Handler to persistent object container
    let persistentContainer:NSPersistentContainer
    
    let persistentContainer2:NSPersistentContainer
    
    /* constructor initializes the persistentContainer and load data to the three lists
       
     LanData : Programming Language Objects in Language Entity
     OSData  : Operating System objects in OS Entity
     MoData  : Mobile System objescts in the Mobile Entity
       
     */
    init()
    {
        //
        persistentContainer = NSPersistentContainer(name: "FitnessPal")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("cannot load data \(error.localizedDescription)")
            }
            
        }
        
        persistentContainer2 = NSPersistentContainer(name: "CalorieGoal")
        persistentContainer2.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("cannot load data \(error.localizedDescription)")
            }
            
        }
        
        CalorieData = getEntries()
        
    }
    
    // Add new entries into the CalorieEntry Entity
//    func logEntry(date: Date, calorie: Double)
//    {
//        let context = persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<CalorieEntry> = CalorieEntry.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "date == %@", date as NSDate)
//        print(date)
//        do {
//            let results = try context.fetch(fetchRequest)
//            if let existingEntry = results.first {
//                existingEntry.calories += calorie
//            } else {
//                let newEntry = CalorieEntry(context: context)
//                newEntry.date = date
//                newEntry.calories = calorie
//            }
//            try context.save()
//            CalorieData = getEntries()
//        } catch {
//            print("failed to save \(error)")
//        }
//    }
    
    func logEntry(date: Date, calorie: Double)
    {
        let context = persistentContainer.viewContext
        let calendar = Calendar.current
        
        // Get date components for the given date
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        // Create a new date object with only the year, month, and day components
        guard let dateWithoutTime = calendar.date(from: components) else {
            print("Failed to remove time component from date")
            return
        }
        
        let fetchRequest: NSFetchRequest<CalorieEntry> = CalorieEntry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", dateWithoutTime as NSDate)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingEntry = results.first {
                existingEntry.calories += calorie
            } else {
                let newEntry = CalorieEntry(context: context)
                newEntry.date = dateWithoutTime
                newEntry.calories = calorie
            }
            try context.save()
            CalorieData = getEntries()
        } catch {
            print("failed to save \(error)")
        }
    }

    
    // Delete entries from the CalorieEntry Entity
    func deleteEntry(cal: CalorieEntry)
    {
        persistentContainer.viewContext.delete(cal)
        do {
            //print("saving")
            try persistentContainer.viewContext.save()
            //LanData = getLanguages()
        } catch{
            print("failed to save \(error)")
        }
        
    }
    // Fetch entries from the CalorieEntry Entity
    func getEntries() -> [CalorieEntry]
    {
        let fetchRequest: NSFetchRequest<CalorieEntry> = CalorieEntry.fetchRequest()
        do {
            let x = try persistentContainer.viewContext.fetch(fetchRequest)
            /*print(x.count)
            print(x[0].name)*/
            return x
        }catch{
            return []
        }
    }
    
    func setNewGoal(_ newGoal: Double) {
        let context = persistentContainer2.viewContext
        
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingEntry = results.first {
                existingEntry.goal = newGoal
            } else {
                let newEntry = Goal(context: context)
                newEntry.goal = newGoal
            }
            try context.save()
        } catch {
            print("failed to fetch or save \(error)")
        }
    }

    
    
    // Get the last entry in the CalorieEntry Entity
//    var lastRecord: Double {
//        return CalorieData.first?.calories ?? 0.0
//    }
    var lastRecord: Double {
        let context = persistentContainer.viewContext
        let calendar = Calendar.current
        
        // Get the current date
        let currentDate = Date()
        
        // Get date components for the current date
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        // Create a new date object with only the year, month, and day components
        guard let dateWithoutTime = calendar.date(from: components) else {
            print("Failed to remove time component from date")
            return 0.0
        }
        
        let fetchRequest: NSFetchRequest<CalorieEntry> = CalorieEntry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", dateWithoutTime as NSDate)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingEntry = results.first {
                return existingEntry.calories
            } else {
                let newEntry = CalorieEntry(context: context)
                newEntry.date = dateWithoutTime
                newEntry.calories = 0.0
                try context.save()
                CalorieData = getEntries()
                return 0.0
            }
        } catch {
            print("failed to fetch or save \(error)")
            return 0.0
        }
    }
    
    var currentGoal: Double {
        let context = persistentContainer2.viewContext

        
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingEntry = results.first {
                return existingEntry.goal
            } else {
                let newEntry = Goal(context: context)
                newEntry.goal = 2000.0
                try context.save()
                return 2000.0
            }
        } catch {
            print("failed to fetch or save \(error)")
            return 0.0
        }
    }

    
    // Get the last 7 entries in the CalorieEntry Entity
//    var last7Records: [CalorieEntry]? {
//        if CalorieData.count >= 7 {
//            return Array(CalorieData[0...6])
//        } else {
//            return nil
//        }
//    }
//    var lastSevenRecords: [Double] {
//        let context = persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<CalorieEntry> = CalorieEntry.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//        fetchRequest.fetchLimit = 7
//
//        do {
//            let results = try context.fetch(fetchRequest)
//            return results.map { $0.calories }
//        } catch {
//            print("Failed to fetch data: \(error)")
//            return []
//        }
//    }
//    func getLast7Records() -> [CalorieEntry] {
//        let context = persistentContainer.viewContext
//        let calendar = Calendar.current
//        
//        // Get the current date
//        let currentDate = Date()
//        
//        // Get date components for the current date
//        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
//        
//        // Create a new date object with only the year, month, and day components
//        guard let dateWithoutTime = calendar.date(from: components) else {
//            print("Failed to remove time component from date")
//            return []
//        }
//        
//        let fetchRequest: NSFetchRequest<CalorieEntry> = CalorieEntry.fetchRequest()
//        let startDate = calendar.date(byAdding: .day, value: -7, to: dateWithoutTime)!
//        fetchRequest.predicate = NSPredicate(format: "date >= %@", startDate as NSDate)
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            return results
//        } catch {
//            print("failed to fetch entries \(error)")
//            return []
//        }
//    }

}
    

