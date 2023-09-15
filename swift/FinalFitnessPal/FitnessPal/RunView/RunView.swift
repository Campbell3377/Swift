//
//  RunView.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/11/23.
//

import SwiftUI

struct RunView: View {
    var body: some View {
        ZStack{
            storyboardView()
        }
    }
}

struct storyboardView: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Map")
//        return controller
        return UINavigationController(rootViewController: controller)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        guard let mapViewController = uiViewController as? MapViewController else { return }
    }
}
//import SwiftUI
//import MapKit
//
//struct MapViewControllerRepresentable: UIViewControllerRepresentable {
//    typealias UIViewControllerType = MapViewController
//
//    func makeUIViewController(context: Context) -> MapViewController {
//        return MapViewController
//    }
//
//    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
//        // You can update any properties of your MapViewController here
//        // For example, you can update the mapView region and annotations
//        // based on the context of your SwiftUI view.
//        // You can also call methods on your MapViewController.
//    }
//}

