//
//  CalorieView.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/13/23.
//

import Foundation
import SwiftUI
//import HealthKit
//import HealthKitUI
import CoreData

struct CalorieView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var dataController: coreDataController = coreDataController()
    
    @State var goal: Double = 2000.0
    
    @State var calorieAmount = ""
    
    @State var percentage: Double = 0.0
    
    //@State var week: [CalorieEntry] = []
    
    @State var selectedDate = Date()
    @State var log:Double = 0.0
    
    var navBarThickness = 10
    var ringThickness:Float = 20
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                //Color.black.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        Spacer()
                        ZStack {
                            self.createRings()
                            self.createLabels()
                        }
                        
                        Spacer()
                        self.createLogSection()
                        //self.createWeekRings()
                    }
                }
                HStack {
                        Spacer()
                        Button(action: {
                            // Prompt user to enter new goal value
                            let alert = UIAlertController(title: "Enter New Goal", message: "Enter a new calorie goal", preferredStyle: .alert)
                            alert.addTextField { textField in
                                textField.placeholder = "Calorie Goal"
                            }
                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                // Update goal value if user submits a new value
                                if let newGoalString = alert.textFields?.first?.text, let newGoal = Double(newGoalString) {
                                    goal = newGoal
                                    dataController.setNewGoal(newGoal)
                                    percentage = Double(dataController.lastRecord / dataController.currentGoal)
                                }
                            })
                            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                        }) {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding(.trailing, 20)
                        }
                    
                }
            }
            .task {
                percentage = Double(dataController.lastRecord / dataController.currentGoal)
                goal = dataController.currentGoal
            }
            .onChange(of: dataController.lastRecord) { _ in
                percentage = Double(dataController.lastRecord / dataController.currentGoal)
            }
        }
    }
    
    
    private func createRings() -> some View{
        ZStack {
            RingView(
                percentage: $percentage,
                backgroundColor: Color(UIColor(named: "moveBackground")!),
                startColor: Color(UIColor(named: "moveStartColor")!),
                endColor: Color(UIColor(named: "moveEndColor")!),
                thickness: CGFloat(ringThickness)
            )
            .frame(width: 280, height: 280)
            .aspectRatio(contentMode: .fit)
        }
        
    }
//    private func createWeekRings() -> some View{
//        ZStack {
//            List(week) {
//                entry in
//                RingView(
//                    percentage: $entry.calories,
//                    backgroundColor: Color(UIColor(named: "moveBackground")!),
//                    startColor: Color(UIColor(named: "moveStartColor")!),
//                    endColor: Color(UIColor(named: "moveEndColor")!),
//                    thickness: CGFloat(ringThickness)
//                )
//                .frame(width: 280, height: 280)
//                .aspectRatio(contentMode: .fit)
//                }
//            
//        }
//        
//    }
    private func createLabels() -> some View{
        
        VStack {
            HStack{
                VStack{
                    Text("Calories: ") +
                    Text("\(Int(round(((dataController.lastRecord / goal)*100))))%")
                        .foregroundColor(Color(UIColor(named: "moveStartColor")!))
                    Text("\n\(String(format: "%.0f", dataController.lastRecord))/\(String(format: "%.0f", goal))CAL")
                        .foregroundColor(Color(UIColor(named: "moveStartColor")!))
                }
            }
        }
    }
    
    func createLogSection() -> some View {
        VStack {
            HStack {
                Text("Log Calorie Entry")
                    .font(.headline)
                Spacer()
            }
            HStack {
                Text("Calories:")
                TextField("Enter calorie amount", text: $calorieAmount)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                    }
            }
            HStack {
                Text("Date:")
                DatePicker(
                    selection: $selectedDate,
                    in: ...Date(),
                    displayedComponents: [.date]
                ) {
                    Text("Select Date")
                }
            }
            Button(action: {
                if let calorie = Double(calorieAmount) {
                    dataController.logEntry(date: selectedDate, calorie: calorie)
                    calorieAmount = ""
                }
            }) {
                Text("Add")
            }
            .disabled(calorieAmount.isEmpty)
        }
        .padding()
    }

}
    
