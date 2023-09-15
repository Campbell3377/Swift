//
//  RunPath.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/10/23.
//

import Foundation
import MapKit
import os

class RunPath: NSObject, MKOverlay {
    private struct RunData {
        var locations: [CLLocation]
        var bounds: MKMapRect

        init(locations: [CLLocation] = [CLLocation](), pathBounds: MKMapRect = MKMapRect.world){
            self.locations = locations
            self.bounds = pathBounds
        }
    }

    let boundingMapRect = MKMapRect.world

    private(set) var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    private let protectedRunData = OSAllocatedUnfairLock(initialState: RunData())

    var pathBounds: MKMapRect {
        return protectedRunData.withLock { runData in
            return runData.bounds
        }
    }

    var locations: [CLLocation] {
        return protectedRunData.withLock { runData in
            return runData.locations
        }
    }

    func addLocation(_ newLocation: CLLocation) -> (locationAdded: Bool, boundingRectChanged: Bool) {

        let result = protectedRunData.withLock { runData in
            guard isNewLocationUsable(newLocation, runData: runData) else {
                let locationChanged = false
                let boundsChanged = false
                return (locationChanged, boundsChanged)
            }

            var previousLocation = runData.locations.last
            if runData.locations.isEmpty {
                coordinate = newLocation.coordinate

                let origin = MKMapPoint(coordinate)

                let oneKilometerInMapPoints = 1000 * MKMapPointsPerMeterAtLatitude(coordinate.latitude)
                let oneSquareKilometer = MKMapSize(width: oneKilometerInMapPoints, height: oneKilometerInMapPoints)
                runData.bounds = MKMapRect(origin: origin, size: oneSquareKilometer)

                runData.bounds = runData.bounds.intersection(.world)

                previousLocation = newLocation
            }

            runData.locations.append(newLocation)

            // Compute the `MKMapRect` bounding the most recent location, and the new location.
            let pointSize = MKMapSize(width: 0, height: 0)
            let newPointRect = MKMapRect(origin: MKMapPoint(newLocation.coordinate), size: pointSize)
            let prevPointRect = MKMapRect(origin: MKMapPoint(previousLocation!.coordinate), size: pointSize)
            let pointRect = newPointRect.union(prevPointRect)

            // Update the `pathBounds` to hold the new location, if needed.
            var boundsChanged = false
            let locationChanged = true
            if !runData.bounds.contains(pointRect) {
                var grownBounds = runData.bounds.union(pointRect)

                let paddingAmountInMapPoints = 1000 * MKMapPointsPerMeterAtLatitude(pointRect.origin.coordinate.latitude)

                if pointRect.minY < runData.bounds.minY {
                    grownBounds.origin.y -= paddingAmountInMapPoints
                    grownBounds.size.height += paddingAmountInMapPoints
                }

                if pointRect.maxY > runData.bounds.maxY {
                    grownBounds.size.height += paddingAmountInMapPoints
                }

                if pointRect.minX < runData.bounds.minX {
                    grownBounds.origin.x -= paddingAmountInMapPoints
                    grownBounds.size.width += paddingAmountInMapPoints
                }

                if pointRect.maxX > runData.bounds.maxX {
                    grownBounds.size.width += paddingAmountInMapPoints
                }

                runData.bounds = grownBounds.intersection(.world)
                boundsChanged = true
            }

            return (locationChanged, boundsChanged)
        }

        return result

    }

    private func isNewLocationUsable(_ newLocation: CLLocation, runData: RunData) -> Bool {
        let now = Date()
        let locationAge = now.timeIntervalSince(newLocation.timestamp)
        guard locationAge < 60 else { return false }

        guard runData.locations.count > 10 else { return true }

        let minimumDistanceBetweenLocationsInMeters = 10.0
        let previousLocation = runData.locations.last!
        let metersApart = newLocation.distance(from: previousLocation)
        return metersApart > minimumDistanceBetweenLocationsInMeters
    }
}
