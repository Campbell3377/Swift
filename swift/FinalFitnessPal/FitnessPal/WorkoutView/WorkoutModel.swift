//
//  WorkoutModel.swift
//  FitnessPal
//
//  Created by Sean Campbell on 3/18/23.
//

import Foundation
//
struct Workout: Decodable, Identifiable {
    var id: UUID?
    var name:String
    var type:String
    var muscle:String
    var equipment:String
    var difficulty:String
    var instructions:String
}
//
//struct WorkoutModel {
//    func fetchWorkouts(endpoint: String, params: [String: Any]?) {
//        guard let url = URL(string: endpoint) else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else { return }
//            do {
//                let decoder = JSONDecoder()
//                let decodedWorkouts = try decoder.decode([Workout].self, from: data)
//                DispatchQueue.main.async {
//                    self.workouts = decodedWorkouts
//                    if let params = params {
//                        self.filteredWorkouts = self.workouts.filter { workout in
//                            // filter based on params here
//                        }
//                    } else {
//                        self.filteredWorkouts = self.workouts
//                    }
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//
//        task.resume()
//    }
//
//}


//public class WorkoutModel: ObservableObject {
//    @Published var data: [Workout] = []
//
//    var count: Int {
//        data.count
//    }
//
//    func getWorkout(at index: Int) -> Workout {
//        return data[index]
//    }
//
//    func add(workout: Workout) {
//        data.append(workout)
//    }
//
//     func removeWorkout(at index: Int) {
//        data.remove(at: index)
//    }
//
//    
//    func findRoutine(routine: String) -> Int{
//        var loc:Int = 0
//        print(routine)
//        for r in data
//        {
//            if r.name == routine
//            {
//                break;
//              
//            }
//            loc = loc + 1
//            print(loc)
//        }
//        return loc
//    }
//}
