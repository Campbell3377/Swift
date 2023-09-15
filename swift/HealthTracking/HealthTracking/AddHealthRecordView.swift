//
//  AddHealthRecordView.swift
//  HealthTracking
//
//  Created by Sean Campbell on 3/20/23.
//

import SwiftUI

struct AddHealthRecordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var healthModel: HealthModel
    
    @State private var weight: Int = 0
    @State private var bloodPressureHigh: Int = 0
    @State private var bloodPressureLow: Int = 0
    @State private var bloodSugarLevel: Int = 0
    @State private var symptoms: String = ""
    
    
    //@State private var date:Date = Date.from(year: 2023, month: 1, day: 7)
    
    var body: some View {
        Form {
            Section(header: Text("Weight")) {
                TextField("Enter weight", value: $weight, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
            }
            Section(header: Text("Blood Pressure")) {
                HStack {
                    TextField("High", value: $bloodPressureHigh, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    Text("/")
                    TextField("Low", value: $bloodPressureLow, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
            }
            Section(header: Text("Blood Sugar Level")) {
                TextField("Enter blood sugar level", value: $bloodSugarLevel, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
            }
            Section(header: Text("Symptoms")) {
                TextField("Enter symptoms", text: $symptoms)
            }
            Section {
                Button("Save") {
                    var date = healthModel.getLastDate()
                    date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                    let record = HealthRecord(
                        date: date,
                        weight: weight,
                        bloodPressure: [bloodPressureHigh, bloodPressureLow],
                        sugarLevel: bloodSugarLevel,
                        otherSymptoms: symptoms
                    )
                    healthModel.add(record: record)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("Add Health Record")
    }
    
}
