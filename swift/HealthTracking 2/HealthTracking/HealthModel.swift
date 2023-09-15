//
//  HealthModel.swift
//  HealthTracking
//
//  Created by Sean Campbell on 3/20/23.
//

import Foundation

struct HealthRecord: Identifiable {
    var id = UUID()
    var date: Date
    var weight: Int
    var bloodPressure: [Int]
    var sugarLevel: Int
    var otherSymptoms: String
}

public class HealthModel: ObservableObject {
    @Published var data:[HealthRecord] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), weight: 145, bloodPressure: [120,80], sugarLevel: 98, otherSymptoms: "None"),
        .init(date: Date.from(year: 2023, month: 1, day: 2), weight: 147, bloodPressure: [110,85], sugarLevel: 95, otherSymptoms: "None"),
        .init(date: Date.from(year: 2023, month: 1, day: 3), weight: 149, bloodPressure: [115,85], sugarLevel: 96, otherSymptoms: "None"),
        .init(date: Date.from(year: 2023, month: 1, day: 4), weight: 148, bloodPressure: [120,80], sugarLevel: 92, otherSymptoms: "None"),
        .init(date: Date.from(year: 2023, month: 1, day: 5), weight: 148, bloodPressure: [110,70], sugarLevel: 98, otherSymptoms: "None"),
        .init(date: Date.from(year: 2023, month: 1, day: 6), weight: 146, bloodPressure: [110,75], sugarLevel: 99, otherSymptoms: "None"),
        .init(date: Date.from(year: 2023, month: 1, day: 7), weight: 145, bloodPressure: [120,85], sugarLevel: 94, otherSymptoms: "None")
    ]
    
    func add(record: HealthRecord) {
        data.append(record)
    }
    
    func getLastDate() -> Date{
        return data.last?.date ?? Date.from(year: 2023, month: 1, day: 1)
    }
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day:day)
        return Calendar.current.date(from: components)!
    }
}
