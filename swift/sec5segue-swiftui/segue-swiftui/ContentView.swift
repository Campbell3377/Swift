import SwiftUI
import HealthKit
import HealthKitUI

struct ContentView: View {
    // This variable is responsible for tracking the data sent from SecondView
    @State private var dataFromSecond = "";
    
    var body: some View {
        // NOTE: to navigate between views, the root view needs to be embedded
        
        NavigationView {
            NavigationLink("Go to SecondView") {
                // Pass the state variable "dataFromSecond" as binding to the
                // SecondView, doing so will allow the ContentView to stay
                // updated on the changes made to this variable
                SecondView(
                dataFromFirst: "Hello from ContentView",
                dataSecond: $dataFromSecond
                // Binding
                   
                )
            }
            .navigationTitle("ContentView")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
