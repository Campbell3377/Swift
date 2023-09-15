//
//  CalorieModel.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/13/23.
//

import Foundation
/**
 Create a function to `fetch all` `calorie entries` from CoreData.
 Create a function to `save` a new calorie entry to CoreData.
 Create a function to calculate the `total calories for the current day.`
 Create a function to calculate the average calories for each day of the past week.
 Create a variable to store the user's calorie goal.
 Create a function to update the user's calorie goal.
     */
//struct CalorieRecord: Identifiable {
//    var id = UUID()
//    var date: Date
//    var calories: Double
//}
//
//public class CalorieModel: ObservableObject {
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \CalorieEntry.date, ascending: true)],
//        animation: .default)
//    private var records: FetchedResults<CalorieRecord>
//
//    func logCalories(date: Date, cal: Double) {
//        // Check if a record for the given date already exists
//        if let existingRecord = records.first(where: { $0.date == date }) {
//            // If a record exists, update the existing record
//            existingRecord.calories += cal
//            saveContext()
//        } else {
//            // If no record exists, create a new record in CoreData
//            let newRecord = CalorieRecord(context: viewContext)
//            newRecord.date = date
//            newRecord.calories = cal
//            saveContext()
//        }
//    }
//    
//    func getLastDate() -> Date{
//        return records.last?.date ?? Date.from(year: 2023, month: 1, day: 1)
//    }
//    
//    private func saveContext() {
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//}

//
//
//struct CalorieRecord: Identifiable {
//    var id = UUID()
//    var date: Date
//    var calories: Double
//}
//
//public class CalorieModel: ObservableObject {
//    @Published var data:[CalorieRecord] = [
//        .init(date: Date.from(year: 2023, month: 1, day: 1), calories: 1500.0),
//        .init(date: Date.from(year: 2023, month: 1, day: 2), calories: 1300.0),
//        .init(date: Date.from(year: 2023, month: 1, day: 3), calories: 1500.0),
//        .init(date: Date.from(year: 2023, month: 1, day: 4), calories: 1700.0),
//        .init(date: Date.from(year: 2023, month: 1, day: 5), calories: 1200.0),
//        .init(date: Date.from(year: 2023, month: 1, day: 6), calories: 1900.0),
//        .init(date: Date.from(year: 2023, month: 1, day: 7), calories: 1300.0)
//    ]
//
//    func logCalories(date: Date, cal: Double) {
//        // Check if a record for the given date already exists
//        if let existingRecordIndex = data.firstIndex(where: { $0.date == date }) {
//            // If a record exists, update the existing record
//            data[existingRecordIndex].calories += cal
//        } else {
//            // If no record exists, add a new record to the data array
//            data.append(CalorieRecord(date: date, calories: cal))
//        }
//    }
//
//    func add(record: CalorieRecord) {
//        data.append(record)
//    }
//
//    func getLastDate() -> Date{
//        return data.last?.date ?? Date.from(year: 2023, month: 1, day: 1)
//    }
//}
//
//extension Date {
//    static func from(year: Int, month: Int, day: Int) -> Date {
//        let components = DateComponents(year: year, month: month, day:day)
//        return Calendar.current.date(from: components)!
//    }
//}
