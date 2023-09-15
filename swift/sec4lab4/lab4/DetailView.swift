//
//  DetailView.swift
//  lab4
//
//  Created by Sean Campbell on 3/4/23.
//

import SwiftUI

import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    let city: String
    let cityImage:String
    let cityDesc:String
    @ObservedObject  var cModel : CityModel
    
    private static let defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
    @State private var lat:Double = 33.4255
    @State private var long:Double = -111.9400
    
    // state property that represents the current map region
    @State private var region = MKCoordinateRegion(
        center: defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @State private var markers = [
        Location(name: "Tempe", coordinate: defaultLocation)
    ]
    
    @State private var searchText = ""
    
    
    
    var body: some View {
        
        VStack {
//            Text(city)
//            Map(coordinateRegion: $region,
//                interactionModes: .all,
//                annotationItems: markers
//            ){ location in
//                MapAnnotation(coordinate: location.coordinate)
//                VStack{
//                    Text(location.name)
//                                Image(systemName: "mappin.circle")
//                                    .font(.title)
//                                    .foregroundColor(.red)
//                }
//
//            }
            Map(coordinateRegion: $region,
                interactionModes: .all,
                annotationItems: markers
            ) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    ZStack {
                        VStack {
                            Text(location.name)
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
            Text("Latitude: \(lat)")
            Text("Longitude: \(long)")
        }
//        .ignoresSafeArea()
        .navigationTitle(city)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            let regionReq = MKLocalSearch.Request()
            regionReq.naturalLanguageQuery = city
            regionReq.region = region
            MKLocalSearch(request: regionReq).start { response, error in
                guard let response = response else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error").")
                    return
                }
                region = response.boundingRegion
                lat = region.center.latitude
                long = region.center.longitude
                markers = response.mapItems.map { item in
                    Location(
                        
                        name: item.name ?? "",
                        coordinate: item.placemark.coordinate
                    )
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(role: .destructive) {
                    let x = cModel.findCity(city: city)
                    print(x)
                    cModel.removeCity(at: x)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                }

            }
        }
        searchBar
    }
    private var searchBar: some View {
        HStack {
            Button {
                let regionReq = MKLocalSearch.Request()
                regionReq.naturalLanguageQuery = searchText
                regionReq.region = region
                MKLocalSearch(request: regionReq).start { response, error in
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
            TextField("Search e.g. Pizza", text: $searchText)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
        }
        .padding()
    }
    private func load(){
        let regionReq = MKLocalSearch.Request()
        regionReq.naturalLanguageQuery = city
        regionReq.region = region
        MKLocalSearch(request: regionReq).start { response, error in
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
    }
}
