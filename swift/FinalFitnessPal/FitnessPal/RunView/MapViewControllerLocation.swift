//
//  MapViewControllerLocation.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/10/23.
//

import AVFoundation
import CoreLocation
import Foundation
import UIKit

extension MapViewController {
    
    func startRecordingLocation() {
        // Remove the existing path because the app is starting to record a new path.
        if let run {
            mapView.removeOverlay(run)
            runPathRenderer = nil
        }
        
        // Create a fresh path when starting to record the locations.
        run = RunPath()
        mapView.addOverlay(run, level: .aboveRoads)
        
        //setupAudioPlayer()

        locationManager.requestWhenInUseAuthorization()
        
        /// Enable the app to collect location updates while it's in the background.
        locationManager.allowsBackgroundLocationUpdates = true
        
        /**
         By default, kCLLocationAccuracyBest`.
        */
        locationManager.desiredAccuracy = locationAccuracy
        
        /// Provide a hint to Core Location on the type of activity for the location updates.
        locationManager.activityType = activityType
        
        /// Certain activity types may pause location updates if the device doesn't move for a period of time. The nature of this project
        /// to show a map of the update history means that updates don't pause.
        locationManager.pausesLocationUpdatesAutomatically = false
        
        /// Start tracking the user's location.
        locationManager.startUpdatingLocation()
       
        isMonitoringLocation = true
    }
    
    /// Stop receiving location updates from Core Location.
    func stopRecordingLocation() {
        isMonitoringLocation = false
        
        locationManager.stopUpdatingLocation()
        //tearDownAudioPlayer()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    // - Tag: location_manager_delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Play a sound so it's easy to tell when a location update occurs while the app is in the background.
        if chimeOnLocationUpdate && !locations.isEmpty {
            setSessionActiveWithMixing(true) // Ducks the audio of other apps when playing the chime.
            playSound()
        }
        
        // Always process all of the provided locations. Don't assume the array only contains a single location.
        for location in locations {
            displayNewBreadcrumbOnMap(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
            // The app doesn't have access to location data. Inform the user.
            let title = "This device has restricted access to your location."
            let message = "Open Settings to change access."
            let okTitle = "OK"
            let settingsTitle = "Settings"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: okTitle, style: .cancel)
            alert.addAction(okAction)
            
            let settingsAction = UIAlertAction(title: settingsTitle, style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
            alert.addAction(settingsAction)
            
            present(alert, animated: true)
        }
    }
}

extension MapViewController: AVAudioPlayerDelegate {
    
    private func setupAudioPlayer() {
        setSessionActiveWithMixing(false)
        if let sound = Bundle.main.url(forResource: "bells", withExtension: "aif") {
            audioPlayer = try! AVAudioPlayer(contentsOf: sound)
        }
    }
    
    private func tearDownAudioPlayer() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    private func setSessionActiveWithMixing(_ duckIfOtherAudioIsPlaying: Bool) {
        try! AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
        if AVAudioSession.sharedInstance().isOtherAudioPlaying && duckIfOtherAudioIsPlaying {
            try! AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers, .duckOthers])
        }
        
        try! AVAudioSession.sharedInstance().setActive(true)
    }
    
    private func playSound() {
        guard let audioPlayer else { return }
        if audioPlayer.isPlaying == false {
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        try! AVAudioSession.sharedInstance().setActive(false)
    }
}
