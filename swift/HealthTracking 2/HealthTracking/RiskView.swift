//
//  RiskView.swift
//  HealthTracking
//
//  Created by Sean Campbell on 3/25/23.
//

import SwiftUI

struct RiskView: View {
    @ObservedObject var viewModel: RiskViewModel
    
    @State var message = "You Are In Good Health, Keep up the Good Work!"
    
    var body: some View {
        VStack {
            Text("Using Last 7 Health Records")
                .font(.headline)
                .padding()
            
            
            displayMessage(for: viewModel.last7Records)
        }
    }
}

func displayMessage(for records: [Log]) -> some View {
    guard records.count >= 4 else { return
        Label("Not enough records to determine health status", systemImage: "hand.raised.square") }

    
    var response = ""
    
    let latestRecord = records.last!
    let previousRecord = records[records.count - 2]

    let currSugar:Double = Double(latestRecord.sugarLevel)
    let prevSugar:Double = Double(previousRecord.sugarLevel) * 1.1
    if (currSugar >= prevSugar) {
        //return "Your sugar level is high"
        response.append("Your sugar level is high\n")
    }

    let latestBP = [latestRecord.bpHigh, latestRecord.bpLow]
    let previousBP = [previousRecord.bpHigh, previousRecord.bpLow]
    
    let currBP:[Double] = [Double(latestBP[0]), Double(latestBP[0])]
    let prevBP:[Double] = [Double(previousBP[0]), Double(previousBP[0])]
    
    if currBP[0] > prevBP[0] * 1.1 ||
        currBP[1] > prevBP[1] * 1.1 {
        //return "Your blood pressure is high"
        response.append("Your blood pressure is high\n")
    }

    let firstThreeRecords = Array(records[0..<3])
    let lastFourRecords = Array(records[records.count - 4..<records.count])
    let averageWeightFirstThree = firstThreeRecords.reduce(0) { $0 + $1.weight } / 3
    let averageWeightLastFour = lastFourRecords.reduce(0) { $0 + $1.weight } / 4
    if averageWeightLastFour > averageWeightFirstThree {
        //return "You are gaining weight"
        response.append("You are gaining weight")
    }
    if (!response.isEmpty){
        return Label(response, systemImage: "hand.raised.square")
    }
    else{
        return Label("You are in good health, \nkeep up the good work", systemImage: "face.smiling")
    }
}


struct RiskView_Previews: PreviewProvider {
    static var previews: some View {
        //let healthModel = HealthModel()
        let viewModel = RiskViewModel(coreDataController: coreDataController())
        
        return RiskView(viewModel: viewModel)
    }
}

