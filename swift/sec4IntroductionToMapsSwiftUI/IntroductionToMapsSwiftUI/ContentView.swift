//
//  ContentView.swift
//  IntroductionToMapsSwiftUI
//
//  Created by Sameer Mungole on 2/21/23.
//  References:
//  Maps - https://www.hackingwithswift.com/books/ios-swiftui/integrating-mapkit-with-swiftui
//  Local Search - https://www.hackingwithswift.com/example-code/location/how-to-look-up-a-location-with-mklocalsearchrequest

import SwiftUI
import MapKit

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
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    // state property that stores marker locations in current map region
    @State private var markers = [
        Location(name: "Tempe", coordinate: defaultLocation)
    ]
    @State private var searchText = ""
   
    var body: some View {
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
                    markers = response.mapItems.map { item in
                        Location(
                            
                            name: item.name ?? "",
                            coordinate: item.placemark.coordinate
                        )
                    }
                }
            } label: {
                Image(systemName: "location.magnifyingglass")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 12)
            }
            TextField("Search e.g. Mill Cue Club", text: $searchText)
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
