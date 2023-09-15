//
//  WorkoutViewModel.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/13/23.
//
//
import SwiftUI

struct WorkoutViewModel: View {
    let workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(workout.name)
                .font(.title)
            HStack {
                Text("Type:")
                Text(workout.type)
            }
            HStack {
                Text("Muscle:")
                Text(workout.muscle)
            }
            HStack {
                Text("Equipment:")
                Text(workout.equipment)
            }
            HStack {
                Text("Difficulty:")
                Text(workout.difficulty)
            }
            Text(workout.instructions)
                .padding(.top, 10)
        }
        .padding()
        .foregroundColor(Color.white)
        .background(Color.black)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
