//
//  WorkoutViewController.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/13/23.
//

import UIKit

class WorkoutViewController: UIViewController {

    var workouts: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make API call and parse JSON response
        if let url = URL(string: "https://api.example.com/workouts") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode([Workout].self, from: data) {
                        self.workouts = response
                        DispatchQueue.main.async {
                            // Refresh view after data is loaded
                            self.tableView.reloadData()
                        }
                    }
                }
            }.resume()
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func loadView() {
        view = tableView
    }
}

extension WorkoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let workout = workouts[indexPath.row]
        cell.textLabel?.text = workout.name
        return cell
    }
}

