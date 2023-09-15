//
//  CityModel.swift
//  lab4
//
//  Created by Sean Campbell on 3/4/23.
//

import Foundation

struct City: Identifiable{
    var id = UUID()
    var name = String()
    var image = String()
    var description = String()
}
public class CityModel: ObservableObject {
  
    @Published var data = [City(name:"Los Angeles", image:"losangeles", description:"Los Angeles, also known as LA, is a sprawling city located in southern California. It is known for its sunny weather, beautiful beaches, and iconic landmarks such as the Hollywood Sign, Santa Monica Pier, and the Walk of Fame. LA is home to the entertainment industry, with Hollywood and the film industry located in the city. It is also a center for technology, aerospace, and international trade."),
                     City(name:"New York City",image:"newyorkcity", description:"New York City, also known as NYC or the Big Apple, is a bustling metropolis located on the east coast of the United States. It is the most populous city in the country and is known for its iconic landmarks such as the Statue of Liberty, Central Park, and the Empire State Building. The city is a cultural hub, home to many museums, theaters, and art galleries. It is also a global financial center, with Wall Street and the New York Stock Exchange located in the city. NYC is a diverse and multicultural city, with a rich history and a vibrant nightlife."),
                     City(name:"Chicago",image:"chicago", description:"Chicago is a major city located in the Midwest region of the United States, on the shores of Lake Michigan. It is known for its architecture, museums, and cultural institutions, such as the Art Institute of Chicago and the Field Museum. The city is also famous for its food, particularly its deep-dish pizza and hot dogs. Chicago is a center for finance, commerce, and transportation, with O'Hare International Airport being one of the busiest airports in the world."),
                     City(name:"Seattle",image:"seattle", description:"Seattle is a city located in the Pacific Northwest region of the United States, in the state of Washington. It is known for its stunning natural surroundings, including mountains, forests, and waterways. The city is also home to many tech companies, including Microsoft and Amazon, and is known for its coffee culture, with the first Starbucks store located in Seattle."),
                     City(name:"Phoenix",image:"phoenix", description:"Phoenix is a city located in the southwestern region of the United States, in the state of Arizona. It is known for its sunny weather, beautiful desert landscapes, and outdoor recreational activities such as hiking and golfing. Phoenix is also a center for education and healthcare, with Arizona State University and the Mayo Clinic located in the city. The city is also home to many sports teams, including the Arizona Cardinals and the Phoenix Suns.")]
    
    var count: Int {
        data.count
    }
    
    func getCity(at index: Int) -> City {
        return data[index]
    }
    
    func add(city: City) {
        data.append(city)
    }
    
     func removeCity(at index: Int) {
        data.remove(at: index)
    }
    
    func findCity(city: String) -> Int{
        var loc:Int = 0
        print(city)
        for c in data
        {
            if c.name == city
            {
                break;
              
            }
            loc = loc + 1
            print(loc)
        }
        return loc
    }
}
