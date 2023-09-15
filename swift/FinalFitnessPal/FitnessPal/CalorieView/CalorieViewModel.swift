//
//  CalorieViewModel.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/14/23.
//
//
//import Foundation
//import CoreData
//
//class HealthGraphViewModel: NSObject, NSFetchedResultsControllerDelegate, ObservableObject {
//    
//    @Published var last7Records: [CalorieRecord] = []
//    
//    private var fetchedResultsController: NSFetchedResultsController<CalorieRecord>
//    private var cancellables: Set<AnyCancellable> = []
//    
//    init(fetchedResultsController: NSFetchedResultsController<CalorieRecord>) {
//        self.fetchedResultsController = fetchedResultsController
//        super.init()
//        
//        self.fetchedResultsController.delegate = self
//        
//        do {
//            try self.fetchedResultsController.performFetch()
//            updateLast7Records()
//        } catch {
//            print("Error fetching results: \(error)")
//        }
//    }
//    
//    func updateLast7Records() {
//        let records = fetchedResultsController.fetchedObjects ?? []
//        last7Records = Array(records.suffix(7))
//    }
//    
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        updateLast7Records()
//    }
//}

//import Foundation
//import Combine
//
//class HealthGraphViewModel: ObservableObject {
//    @Published var last7Records: [CalorieRecord] = []
//    private var cancellables: Set<AnyCancellable> = []
//    private let calModel: CalorieModel
//
//    init(calModel: CalorieModel) {
//        self.calModel = calModel
//        updateLast7Records()
//        observeCalModelUpdates()
//    }
//
//    func updateLast7Records() {
//        last7Records = Array(calModel.data.suffix(7))
//    }
//
//    func observeCalModelUpdates() {
//        calModel.$data.sink { [weak self] data in
//            self?.updateLast7Records()
//        }.store(in: &cancellables)
//    }
//}
