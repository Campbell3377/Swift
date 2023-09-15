//
//  WorkoutView.swift
//  FitnessPal
//
//  Created by Sean Campbell on 3/18/23.
//
import SwiftUI

struct WorkoutView: View {
    @State private var typeSelection = types.all
    @State private var muscleSelection = muscles.all
    @State private var difficultySelection = difficulties.all
    @State private var searchText = ""
    @State private var filteredWorkouts: [Workout] = []

    var workouts: [Workout]

    enum types: String, CaseIterable {
        case all, strength, cardio, powerlifting, plyometrics, stretching
    }

    enum muscles: String, CaseIterable {
        case all, biceps, triceps, chest, lowerBack = "lower_back", middleBack = "middle-back", shoulders, quadriceps, calves, abdominals, lats
    }

    enum difficulties: String, CaseIterable {
        case all, easy, medium, hard
    }

    init(workouts: [Workout]) {
        self.workouts = workouts
    }

    var body: some View {
        
        ZStack {
//            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                HStack {
                    Text("Type:")
                    Picker("", selection: $typeSelection) {
                        ForEach(types.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                HStack {
                    Text("Muscle:")
                    Picker("", selection: $muscleSelection) {
                        ForEach(muscles.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                HStack {
                    Text("Difficulty:")
                    Picker("", selection: $difficultySelection) {
                        ForEach(difficulties.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Button(action: {
                    //self.showAlert = true
                    fetchWorkouts()
                }) {
                    Text("Search")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                NavigationView {
                    List(filteredWorkouts) {
                        workout in
                        //WorkoutViewModel(workout: workout)
                        NavigationLink(destination:
                                        WorkoutDetailView(workout: workout))
                        {
                            Text(workout.name)
                        }
                    }
                }
                    
                }
//                .scrollContentBackground(.hidden)
                .navigationTitle("Workouts")
                .onAppear {
                    filteredWorkouts = workouts
                }
//                .foregroundColor(Color.white)
//                .background(Color.black)
            }
        
            .padding()
        }
    func fetchWorkouts() {
        //et url = URL(string: "https://api.api-ninjas.com/v1/exercises")!
        var queryItems: [URLQueryItem] = []
        if typeSelection != types.all {
                queryItems.append(URLQueryItem(name: "type", value: typeSelection.rawValue))
        }
        if muscleSelection != muscles.all {
                queryItems.append(URLQueryItem(name: "muscle", value: muscleSelection.rawValue))
        }
        if difficultySelection != difficulties.all {
                queryItems.append(URLQueryItem(name: "difficulty", value: difficultySelection.rawValue))
        }

        var urlComponents = URLComponents(string: "https://api.api-ninjas.com/v1/exercises")!
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems

        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.setValue("h2Njn+dljBErbVJMrQNOuQ==r61WuN8PoC164EPq", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching workouts: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("Error fetching workouts: Invalid response")
                return
            }

            guard let data = data else {
                print("Error fetching workouts: No data returned")
                return
            }

            do {
                let decoder = JSONDecoder()
                let fetchedWorkouts = try decoder.decode([Workout].self, from: data)
                DispatchQueue.main.async {
                    //self.workouts = fetchedWorkouts
                    self.filteredWorkouts = fetchedWorkouts.map({ workout in
                        return Workout(id: UUID(), name: workout.name, type: workout.type, muscle: workout.muscle, equipment: workout.equipment, difficulty: workout.difficulty, instructions: workout.instructions)
                    })

                }
            } catch {
                print("Error decoding workouts: \(error.localizedDescription)")
                return
            }
        }

        task.resume()
    }
}
    

//    private func fetchWorkouts() {
//        // Construct URL with query parameters
//        var queryItems: [URLQueryItem] = []
//        if typeSelection != types.all {
//                queryItems.append(URLQueryItem(name: "type", value: typeSelection.rawValue))
//        }
//        if muscleSelection != muscles.all {
//                queryItems.append(URLQueryItem(name: "muscle", value: muscleSelection.rawValue))
//        }
//        if difficultySelection != difficulties.all {
//                queryItems.append(URLQueryItem(name: "difficulty", value: difficultySelection.rawValue))
//        }
//
//        var urlComponents = URLComponents(string: "https://api.api-ninjas.com/v1/exercises")!
//        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
//
//        guard let url = urlComponents.url else {
//            print("Invalid URL")
//            return
//        }
//        print(url)
//        var request = URLRequest(url: url)
//        request.setValue("h2Njn+dljBErbVJMrQNOuQ==r61WuN8PoC164EPq", forHTTPHeaderField: "X-Api-Key")
//
//        // Make API request
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                do {
//                    // Parse response JSON into array of Workout objects
//                    //let decodedData = try JSONDecoder().decode([Workout].self, from: data)
//                    if let decodedData = try? JSONDecoder().decode([Workout].self, from: data) {
//                                        // Assign ids to each workout based on its index in the array
//                        workouts = decodedData.enumerated().map { index, workout in
//                            var newWorkout = workout
//                            newWorkout.id = index
//                            return newWorkout
//                        }
//                    }
//                    // Update filteredWorkouts on main thread
////                    DispatchQueue.main.async {
////                        //filteredWorkouts = decodedData
////                        ForEach(Workout w in decodedData){
////                            filteredWorkouts.append(<#T##newElement: Workout##Workout#>)
////                        }
////                    }
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
//  }
//}

//    let types = ["all", "strength", "cardio", "powerlifting", "plyometrics", "stretching"]
//    let muscles = ["all", "biceps", "triceps", "chest", "lower_back", "middle-back", "shoulders", "quadriceps", "calves", "abdominals", "lats"]
//    let difficulties = ["all", "easy", "medium", "hard"]
