//
//  HealthGraphViewModel.swift
//  HealthTracking
//
//  Created by Sean Campbell on 3/20/23.
//

import Foundation
import Combine

class HealthGraphViewModel: ObservableObject {
    @Published var last7Records: [HealthRecord] = []
    private var cancellables: Set<AnyCancellable> = []
    private let healthModel: HealthModel
    
    init(healthModel: HealthModel) {
        self.healthModel = healthModel
        updateLast7Records()
        observeHealthModelUpdates()
    }
    
    func updateLast7Records() {
        last7Records = Array(healthModel.data.suffix(7))
    }
    
    func observeHealthModelUpdates() {
        healthModel.$data.sink { [weak self] data in
            self?.updateLast7Records()
        }.store(in: &cancellables)
    }
}
