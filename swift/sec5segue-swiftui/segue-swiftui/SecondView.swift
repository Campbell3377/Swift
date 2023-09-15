import SwiftUI

struct SecondView: View {
    // access the "dismiss" function from the NavigationView, when called this
    // function will pop the current view from the navigation stack
    @Environment(\.dismiss) var dismiss
    
    // this variable stores the data received from ContentView
    var dataFromFirst: String
    // this binding allows to send data back to the ContentView
    @Binding var dataSecond: String
    
    var body: some View {
        VStack{
            Spacer()
            Text(dataFromFirst)
            Spacer()
            Button("Go back to ContentView") {
                dataSecond = "Hello from SecondView"
                dismiss()
                    
            }.padding()
             .foregroundColor(.green)
             .border(Color.red, width: 3)
             .cornerRadius(10)
            
            Spacer()
            NavigationLink("Go to ThirdView") {
                    // Pass the state variable "dataFromSecond" as binding to the
                    // SecondView, doing so will allow the ContentView to stay
                    // updated on the changes made to this variable
                    ThirdView(dataFrom_Second: "Hello From Second")
            }
            .padding()
            .foregroundColor(.blue)
            .border(Color.red, width: 3)
            .cornerRadius(10)
              
            Spacer()
        }
        .navigationTitle("SecondView")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            print(dataFromFirst)
            
        }
    }
}


struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(dataFromFirst: "Some string", dataSecond: .constant(""))
    }
}
