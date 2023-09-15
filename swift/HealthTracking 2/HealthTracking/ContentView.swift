//
//  ContentView.swift
//  HealthTracking
//
//  Created by Sean Campbell on 3/20/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataController = coreDataController()
    //@StateObject var healthGraphViewModel: HealthGraphViewModel = HealthGraphViewModel(healthModel: HealthModel())
    //@StateObject var healthGraphViewModel: HealthGraphViewModel
    @State private var showAddHealthRecordView = false


//    init() {
//        let viewModel = HealthGraphViewModel(healthModel: hModel)
//        _healthGraphViewModel = StateObject(wrappedValue: viewModel)
//    }

    var body: some View {
        let graphViewModel = HealthGraphViewModel(coreDataController: dataController)
        let riskViewModel = RiskViewModel(coreDataController: dataController)
        //healthGraphViewModel = HealthGraphViewModel(healthModel: hModel)
//        NavigationView {
//            VStack {
//                HealthGraphView(viewModel: viewModel)
//                Button("Add Health Record") {
//                                    //updateDate()
//                                    showAddHealthRecordView = true
//                                }
//                                .padding()
//                                .sheet(isPresented: $showAddHealthRecordView) {
//                                    AddHealthRecordView(healthModel: hModel)
//                                }
//            }
//            .padding()
//        }

        TabView {
            NavigationView {
                VStack {
                    HealthGraphView(viewModel: graphViewModel)
                    Button("Add Health Record") {
                                        //updateDate()
                                        showAddHealthRecordView = true
                                    }
                                    .padding()
                                    .sheet(isPresented: $showAddHealthRecordView) {
                                        AddHealthRecordView(coreDataController: dataController)
                                    }
                }
                .padding()
            }
                .tabItem {
                    Label("Overview", systemImage: "heart.fill")
                }
            RiskView(viewModel: riskViewModel)
                .tabItem {
                    Label("Risks", systemImage: "list.clipboard")
                }
//            AddHealthRecordView(healthModel: hModel)
//                .tabItem {
//                    Label("Log", image: "checklist")
//                }
        }
    }
}


