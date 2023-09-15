//
//  MapViewController.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/10/23.
//

import AVFoundation
import CoreLocation
import Foundation
import MapKit
import UIKit

class MapViewController: UIViewController {

    // MARK: Overlay Properties

    /// A custom `MKOverlay` that contains the path a user travels.
    var run: RunPath!
    
    /// A custom overlay renderer object that draws the data in `crumbs` on the map.
    var runPathRenderer: RunPathRenderer?
    
    /// A setting that controls whether the `crumbBoundingPolygon` overlay is present on the map.
    var showRunBounds = UserDefaults.standard.bool(forKey: SettingsKeys.showRunBoundingArea.rawValue) {
        didSet {
            UserDefaults.standard.set(showRunBounds, forKey: SettingsKeys.showRunBoundingArea.rawValue)
            if showRunBounds {
                updateRunBoundsOverlay()
            } else {
                removeRunBoundsOverlay()
            }
        }
    }
    
    /// The bounding rectangle of the breadcrumb overlay. This is only visible when `showBreadcrumbBounds` is `true`.
    var runBoundingPolygon: MKPolygon?
    
    // MARK: - Location Mangement Properties
    
    /// The manager interfacing with Core Location.
    let locationManager = CLLocationManager()
    
    /// Location tracking is in an enabled state, and the system is delivering updates to the location manager delegate functions.
    var isMonitoringLocation = false
    
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    var locationAccuracy: CLLocationAccuracy = UserDefaults.standard.double(forKey: SettingsKeys.accuracy.rawValue) {
        didSet {
            locationManager.desiredAccuracy = locationAccuracy
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            UserDefaults.standard.set(locationAccuracy, forKey: SettingsKeys.accuracy.rawValue)
        }
    }
    
    /// The type of activity for the location updates.
    var activityType: CLActivityType = CLActivityType(rawValue: UserDefaults.standard.integer(forKey: SettingsKeys.activity.rawValue))! {
        didSet {
            locationManager.activityType = activityType
            UserDefaults.standard.set(activityType.rawValue, forKey: SettingsKeys.activity.rawValue)
        }
    }
    
    /// A setting indicating whether the chime plays on location updates.
    var chimeOnLocationUpdate = UserDefaults.standard.bool(forKey: SettingsKeys.chimeOnLocationUpdate.rawValue) {
        didSet {
            UserDefaults.standard.set(chimeOnLocationUpdate, forKey: SettingsKeys.chimeOnLocationUpdate.rawValue)
        }
    }
    
    // MARK: - Audio Properties
    

    var audioPlayer: AVAudioPlayer?
    
    // MARK: - Outlets
    
    @IBOutlet var mapView: MKMapView!
//    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    @IBOutlet weak var recordButton: UIBarButtonItem!
    @IBOutlet weak var mapTrackingButton: UIBarButtonItem!
    
    /// This system initalizes this object when it decodes the contents of `Main.storyboard`.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Tells the location manager to send updates to this object.
        locationManager.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allow the user to change the map view's tracking mode by placing this button in the navigation bar.
        mapTrackingButton.customView = MKUserTrackingButton(mapView: mapView)
        
        configureRecordingMenu()
        configureSettingsMenu()
    }
    
    // MARK: - Overlay Methods
    
    func displayNewBreadcrumbOnMap(_ newLocation: CLLocation) {

        let result = run.addLocation(newLocation)
        
        
         if result.locationAdded {
            // Compute the currently visible map zoom scale.
            let currentZoomScale = mapView.bounds.size.width / mapView.visibleMapRect.size.width
            
            let lineWidth = MKRoadWidthAtZoomScale(currentZoomScale)
            var areaToRedisplay = run.pathBounds
            areaToRedisplay = areaToRedisplay.insetBy(dx: -lineWidth, dy: -lineWidth)
            
            runPathRenderer?.setNeedsDisplay(areaToRedisplay)
        }
        
        if result.boundingRectChanged {
            updateRunBoundsOverlay()
        }
        
        if run.locations.count == 1 {
            let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            mapView.setUserTrackingMode(.followWithHeading, animated: true)
        }
    }
    
    private func removeRunBoundsOverlay() {
        if let runBoundingPolygon {
            mapView.removeOverlay(runBoundingPolygon)
        }
    }

    private func updateRunBoundsOverlay() {
       removeRunBoundsOverlay()
        
        if showRunBounds {
            let pathBounds = run.pathBounds
            let boundingPoints = [
                MKMapPoint(x: pathBounds.minX, y: pathBounds.minY),
                MKMapPoint(x: pathBounds.minX, y: pathBounds.maxY),
                MKMapPoint(x: pathBounds.maxX, y: pathBounds.maxY),
                MKMapPoint(x: pathBounds.maxX, y: pathBounds.minY)
            ]
            runBoundingPolygon = MKPolygon(points: boundingPoints, count: boundingPoints.count)
            mapView.addOverlay(runBoundingPolygon!, level: .aboveRoads)
        }
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? RunPath {
            if runPathRenderer == nil {
                runPathRenderer = RunPathRenderer(runPath: overlay)
            }
            return runPathRenderer!
        } else if overlay is MKPolygon {
            // The rectangle showing the `pathBounds` of the `breadcrumbs` overlay.
            let pathBoundsRenderer = MKPolygonRenderer(overlay: overlay)
            pathBoundsRenderer.fillColor = .systemBlue.withAlphaComponent(0.25)
            return pathBoundsRenderer
        } else {
            fatalError("Unknown overlay \(overlay) added to the map")
        }
    }
}

