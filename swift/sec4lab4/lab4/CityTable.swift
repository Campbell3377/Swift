//
//  CityTable.swift
//  lab4
//
//  Created by Sean Campbell on 3/4/23.
//

import SwiftUI

struct CityTable: View {
    @StateObject  var cityModel = CityModel()
    //@ObservedObject  var fruitModel = FruitModel()
    /*Observrted object is more appropriate here since view doesn't need to keep data*/
    
    var body: some View {
        NavigationView {
            List {
               ForEach(cityModel.data, id: \.id) { city in
                   NavigationLink(destination: DetailView(city: city.name, cityImage: city.image, cityDesc: city.description, cModel: cityModel)) {
                        HStack{
                            Image(city.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height:50)
                                .cornerRadius(20)
                            VStack (alignment: .leading, spacing: 5){
                                
                                Text(city.name)
                                    .fontWeight(.semibold)
                                    .minimumScaleFactor(0.5)
                                Text("Healthy")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                    }
               }.onDelete(perform: {IndexSet in
                   cityModel.data.remove(atOffsets: IndexSet)
               })
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("List Introduction")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let c:City = City(name:"Phoenix", image: "phoenix", description: "Phoenix is a city located in the southwestern region of the United States, in the state of Arizona. It is known for its sunny weather, beautiful desert landscapes, and outdoor recreational activities such as hiking and golfing. Phoenix is also a center for education and healthcare, with Arizona State University and the Mayo Clinic located in the city. The city is also home to many sports teams, including the Arizona Cardinals and the Phoenix Suns.")
                        cityModel.add(city: c)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CityTable()
    }
}
