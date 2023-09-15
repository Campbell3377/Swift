//
//  HealthGraphViewModel.swift
//  HealthTracking
//
//  Created by Sean Campbell on 3/20/23.
//

import Foundation
import Combine

class HealthGraphViewModel: ObservableObject {
    @Published var last7Records: [Log] = []
    private var cancellables: Set<AnyCancellable> = []
    private let coreDataController: coreDataController
    
    init(coreDataController: coreDataController) {
        self.coreDataController = coreDataController
        updateLast7Records()
        observeHealthModelUpdates()
    }
    
    func updateLast7Records() {
        last7Records = Array(coreDataController.getEntries().suffix(7))
    }
    
    func observeHealthModelUpdates() {

    }
}
