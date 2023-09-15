//
//  RunPathRenderer.swift
//  FitnessPal
//
//  Created by Sean Campbell on 4/10/23.
//

import Foundation
import MapKit

class RunPathRenderer: MKOverlayRenderer {
    private let run: RunPath
    
    init(runPath: RunPath) {
        run = runPath
        super.init(overlay: runPath)
    }
    
    override func canDraw(_ mapRect: MKMapRect, zoomScale: MKZoomScale) -> Bool {
        return run.pathBounds.intersects(mapRect)
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        //Scale line width to road
        let lineWidth = MKRoadWidthAtZoomScale(zoomScale)
        
        //Negative inset to ensure points are visible
        let clipRect = mapRect.insetBy(dx: -lineWidth, dy: -lineWidth)
        
        
        let points = run.locations.map { MKMapPoint($0.coordinate) }
        if let path = pathForPoints(points, mapRect: clipRect, zoomScale: zoomScale) {
            context.addPath(path)
            context.setStrokeColor(UIColor.systemBlue.withAlphaComponent(0.5).cgColor)
            context.setLineJoin(.round)
            context.setLineCap(.round)
            context.setLineWidth(lineWidth)
            context.strokePath()
        }
    }
    
    //Test if two points intersect -> return true
    private func lineBetween(points: (p0: MKMapPoint, p1: MKMapPoint), intersects rect: MKMapRect) -> Bool {
        let minX = Double.minimum(points.p0.x, points.p1.x)
        let minY = Double.minimum(points.p0.y, points.p1.y)
        let maxX = Double.maximum(points.p0.x, points.p1.x)
        let maxY = Double.maximum(points.p0.y, points.p1.y)
        
        let testRect = MKMapRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
        return rect.intersects(testRect)
    }
    
    //Using Mutuable CG Path to add lines
    private func addLine(to path: CGMutablePath, with points: (p0: MKMapPoint, p1: MKMapPoint), liftingPen: Bool) {
        if liftingPen {
            let lastDrawingPoint = self.point(for: points.p1)
            path.move(to: lastDrawingPoint)
        }
        let drawingPoint = self.point(for: points.p0)
        path.addLine(to: drawingPoint)
    }
    
    //Construct CG Path
    private func pathForPoints(_ points: [MKMapPoint], mapRect: MKMapRect, zoomScale: MKZoomScale) -> CGPath? {
        guard points.count > 1 else { return nil }
        
        // Simplify the geometry for the screen by eliding points that are too close together,
        // and to omit any line segments that don't intersect the clipping rectangle.
        let path = CGMutablePath()
        
        var needsToLiftPen = true
        
        // Calculate the minimum distance between any two points by applying the Pythagorean theorem to figure out
        // how many map points correspond to `minimumScreenPoints` at the current `zoomScale`.
        let minimumScreenPoints = 5.0
        let minPointDelta = minimumScreenPoints / zoomScale
        let cSquared = pow(minPointDelta, 2)
        
        var lastMapPoint = points.first!
        for (index, mapPoint) in points.enumerated() {
            if index == 0 { continue }
            
            let aSquaredBSquared = pow(mapPoint.x - lastMapPoint.x, 2) + pow(mapPoint.y - lastMapPoint.y, 2)
            if aSquaredBSquared >= cSquared {
                if lineBetween(points: (mapPoint, lastMapPoint), intersects: mapRect) {
                    addLine(to: path, with: (mapPoint, lastMapPoint), liftingPen: needsToLiftPen)
                    needsToLiftPen = false
                } else {
                    // Discontinuity, lift the pen.
                    needsToLiftPen = true
                }
                lastMapPoint = mapPoint
            }
        }
        
        // If the last line segment intersects the `mapRect` at all, add it unconditionally.
        let mapPoint = points.last!
        if lineBetween(points: (mapPoint, lastMapPoint), intersects: mapRect) {
            addLine(to: path, with: (mapPoint, lastMapPoint), liftingPen: needsToLiftPen)
        }
        
        return path
    }
}
