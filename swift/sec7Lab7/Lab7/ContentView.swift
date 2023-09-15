//
//  ContentView.swift
//  Lab7
//
//  Created by Sean Campbell on 4/4/23.
//

import SwiftUI
import MapKit

struct Earthquakes: Decodable {
    let earthquakes: [Earthquake]
//    enum CodingKeys: String, CodingKey {
//            case earthquakes = "earthquakes"
//    }
}

struct Earthquake: Decodable {
    let datetime: String
    let depth: Double
    let lng: Double
    let src: String
    let eqid: String
    let magnitude: Double
    let lat: Double
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    // default location set to Tempe
    private static let defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
    // state property that represents the current map region
    @State private var region = MKCoordinateRegion(
        center: defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0)
    )
    // state property that stores marker locations in current map region
    @State private var markers = [
        Location(name: "Tempe", coordinate: defaultLocation)
    ]
    @State private var searchText = ""
   
    var body: some View {
        Text("Lab 7 - Earthquakes").bold()
        ZStack(alignment: .bottom) {
                Map(coordinateRegion: $region,
                    interactionModes: .all,
                    annotationItems: markers
                ){ location in
                    MapMarker(coordinate: location.coordinate)
                    /*MapAnnotation(coordinate: location.coordinate){
                     Circle()
                     .strokeBorder(.red, lineWidth: 2)
                     .frame(width:20, height: 20)
                     }*/
                }
            }
            .ignoresSafeArea()
            .task {
                let n = String(format: "%.1f", region.center.latitude + 10.0)
                let s = String(format: "%.1f", region.center.latitude - 10.0)
                let e = String(format: "%.1f", region.center.longitude + 10.0)
                let w = String(format: "%.1f", region.center.longitude - 10.0)
                //print("Hi")
                // print("\(n), \(s), \(e), \(w)")
                
                
                let urlAsString = "http://api.geonames.org/earthquakesJSON?north="+n+"&south="+s+"&east="+e+"&west="+w+"&username=campbell37"
                //let urlAsString = "http://api.geonames.org/earthquakesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&username=campbell37"
                let url = URL(string: urlAsString)!
                let urlSession = URLSession.shared
                let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                    if let error = error {
                        print(error.localizedDescription)
                        // return
                    }
                    do {
                        let decodedData = try JSONDecoder().decode(Earthquakes.self, from: data!)
                        
                        markers = decodedData.earthquakes.map { quake in Location(name: "", coordinate: CLLocationCoordinate2D(latitude: quake.lat, longitude: quake.lng))}
                        //print(decodedData.earthquakes.count)
                    }
                    catch{
                        print("error: \(error)")
                    }
                })
                jsonQuery.resume()            }
            
            searchBar
        }
    
    
    private var searchBar: some View {
        HStack {
            Button {
                let searchRequest = MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = searchText
                searchRequest.region = region
                
                MKLocalSearch(request: searchRequest).start { response, error in
                    guard let response = response else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error").")
                        return
                    }
                    region = response.boundingRegion
                    
                    let n = String(format: "%.1f", response.boundingRegion.center.latitude + 10.0)
                    let s = String(format: "%.1f", response.boundingRegion.center.latitude - 10.0)
                    let e = String(format: "%.1f", response.boundingRegion.center.longitude + 10.0)
                    let w = String(format: "%.1f", response.boundingRegion.center.longitude - 10.0)
                    //print("Hi")
                    // print("\(n), \(s), \(e), \(w)")
                    
                    
                    let urlAsString = "http://api.geonames.org/earthquakesJSON?north="+n+"&south="+s+"&east="+e+"&west="+w+"&username=campbell37"
                    //let urlAsString = "http://api.geonames.org/earthquakesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&username=campbell37"
                    let url = URL(string: urlAsString)!
                    let urlSession = URLSession.shared
                    let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                        if let error = error {
                            print(error.localizedDescription)
                            // return
                        }
                        do {
                            let decodedData = try JSONDecoder().decode(Earthquakes.self, from: data!)
                            
                            markers = decodedData.earthquakes.map { quake in Location(name: "", coordinate: CLLocationCoordinate2D(latitude: quake.lat, longitude: quake.lng))}
                            //print(decodedData.earthquakes.count)
                        }
                        catch{
                            print("error: \(error)")
                        }
                    })
                    jsonQuery.resume()

                    
//                    markers = response.mapItems.map { item in
//                        Location(
//
//                            name: item.name ?? "",
//                            coordinate: item.placemark.coordinate
//                        )
//                    }
                }
            } label: {
                Image(systemName: "location.magnifyingglass")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 12)
            }
            TextField("Search e.g. California, Chile, etc", text: $searchText)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
