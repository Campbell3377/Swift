//
//  HealthGraphView.swift
//  HealthTracking
//
//  Created by Sean Campbell on 3/20/23.
//

import SwiftUI
import Charts

struct HealthGraphView: View {
    @ObservedObject var viewModel: HealthGraphViewModel
    
    var body: some View {
        VStack {
            Text("Last 7 Health Records")
                .font(.headline)
                .padding()
            
            VStack{
                Text("Weight: lbs")
                    .font(.subheadline)
                Chart{
                    ForEach(viewModel.last7Records) {viewEntry in
                        LineMark(x: .value("Date", viewEntry.date), y: .value("Weight", viewEntry.weight))
                    }
                }
            }
            VStack{
                Text("Blood Sugar Level: mg/dL")
                    .font(.subheadline)
                Chart{
                    ForEach(viewModel.last7Records) {viewEntry in
                        LineMark(x: .value("Date", viewEntry.date), y: .value("Blood Sugar Level", viewEntry.sugarLevel))
                    }
                }
            }
            VStack{
                Text("Systolic/Diastolic: mmHg")
                    .font(.subheadline)
                Chart{
                    ForEach(viewModel.last7Records) {viewEntry in
                        RectangleMark(x: .value("Date", viewEntry.date), yStart: CGFloat(viewEntry.bloodPressure[0]), yEnd: CGFloat(viewEntry.bloodPressure[1]))
                    }
                }
            }
        }
    }
}

struct HealthGraphView_Previews: PreviewProvider {
    static var previews: some View {
        let healthModel = HealthModel()
        let viewModel = HealthGraphViewModel(healthModel: healthModel)
        
        return HealthGraphView(viewModel: viewModel)
    }
}
