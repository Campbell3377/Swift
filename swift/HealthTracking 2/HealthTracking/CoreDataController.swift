//
//  CoreDataController.swift
//  HealthTracking
//
//  Created by Sean Campbell on 4/24/23.
//

import Foundation
import CoreData
class coreDataController : ObservableObject
{
    @Published var HealthData:[Log] = []
    
    //@Published var calorieGoal:Goal = Goal()
    
    // Handler to persistent object container
    let persistentContainer:NSPersistentContainer
    
    init()
    {
        //
        persistentContainer = NSPersistentContainer(name: "HealthModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("cannot load data \(error.localizedDescription)")
            }
            
        }
        HealthData = getEntries()
        
    }

    
    func logEntry(date: Date, weight: Double, bpHigh: Double, bpLow: Double, sugarLevel: Double, other: String)
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
        
        let fetchRequest: NSFetchRequest<Log> = Log.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", dateWithoutTime as NSDate)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingEntry = results.first {
                existingEntry.weight = weight
                existingEntry.bpHigh = bpHigh
                existingEntry.bpLow = bpLow
                existingEntry.sugarLevel = sugarLevel
                existingEntry.other = other
            } else {
                let newEntry = Log(context: context)
                //newEntry.id = UUID()
                newEntry.date = dateWithoutTime
                newEntry.weight = weight
                newEntry.bpHigh = bpHigh
                newEntry.bpLow = bpLow
                newEntry.sugarLevel = sugarLevel
                newEntry.other = other
                //newEntry.calories = calorie
            }
            try context.save()
            HealthData = getEntries()
        } catch {
            print("failed to save \(error)")
        }
    }

    
    // Delete entries from the CalorieEntry Entity
    func deleteEntry(log: Log)
    {
        persistentContainer.viewContext.delete(log)
        do {
            //print("saving")
            try persistentContainer.viewContext.save()
            //LanData = getLanguages()
        } catch{
            print("failed to save \(error)")
        }
        
    }
    // Fetch entries from the CalorieEntry Entity
    func getEntries() -> [Log]
    {
        let fetchRequest: NSFetchRequest<Log> = Log.fetchRequest()
        do {
            let x = try persistentContainer.viewContext.fetch(fetchRequest)
            /*print(x.count)
            print(x[0].name)*/
            return x
        }catch{
            return []
        }
    }
    


    

//    var lastRecord: Log {
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
//
//        }
//
//        let fetchRequest: NSFetchRequest<Log> = Log.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "date == %@", dateWithoutTime as NSDate)
//
//        do {
//            let results = try context.fetch(fetchRequest)
//            if let existingEntry = results.first {
//                return existingEntry
//            } else {
//                let newEntry = Log(context: context)
//                newEntry.date = dateWithoutTime
//                //newEntry.calories = 0.0
//                try context.save()
//                HealthData = getEntries()
//                return newEntry
//            }
//        } catch {
//            print("failed to fetch or save \(error)")
//        }
//    }
    

    
    // Get the last 7 entries in the CalorieEntry Entity
//    var last7Records: [CalorieEntry] {
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
    var getLast7Records: [Log] {
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
//        let fetchRequest: NSFetchRequest<Log> = Log.fetchRequest()
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
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Log> = Log.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        do {
            let results = try context.fetch(fetchRequest)
            let latestEntries = Array(results.prefix(7))
            return latestEntries.reversed() // return the entries in chronological order
        } catch {
            print("failed to fetch entries \(error)")
            return []
        }

    }

}
    


