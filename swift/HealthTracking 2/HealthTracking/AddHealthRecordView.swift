//
//  AddHealthRecordView.swift
//  HealthTracking
//
//  Created by Sean Campbell on 3/20/23.
//

import SwiftUI

struct AddHealthRecordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var coreDataController: coreDataController
    
    @State private var weight: Double = 150
    @State private var bloodPressureHigh: Double = 120
    @State private var bloodPressureLow: Double = 80
    @State private var bloodSugarLevel: Double = 80
    @State private var symptoms: String = "None"
    @State private var selectedDate: Date = Date()
    
    
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
            Section(header: Text("Date")) {
                DatePicker(
                    selection: $selectedDate,
                    in: ...Date(),
                    displayedComponents: [.date]
                ) {
                    Text("Select Date")
                }
            }
            Section {
                Button("Save") {
                    coreDataController.logEntry(date: selectedDate, weight: weight, bpHigh: bloodPressureHigh, bpLow: bloodPressureLow, sugarLevel: bloodSugarLevel, other: symptoms)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("Add Health Record")
    }
    
}
