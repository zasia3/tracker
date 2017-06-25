//
//  MapView.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Model
import iOSKit
import MapKit

final class MapView: View {
    
    private let mapView = MKMapView()
    private let regionRadius: CLLocationDistance = 50
    private let annotation = MKPointAnnotation()
    
    
    override public func onInit() {
        configureMapView()
    }
    
    /* show a pin with user location on a map and center map on this location */
    public func showUserLocation(position: Position) {
        let mapLocation = CLLocation(latitude: position.latitude, longitude: position.longitude)
        centerMap(on: mapLocation)
        showUserPin(on: mapLocation)
    }
    
    public func showCurrentTrack(with positions: [Position]) {
        
        // create polyline from provided user locations and add it to the mapview
        let locations = positions.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.add(polyline)
    }
    
    private func centerMap(on location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func showUserPin(on location: CLLocation) {
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    
    /* adding map as a subview and setting delegate */
    private func configureMapView() {
        addSubview(mapView)
        mapView.fillSuperview()
        mapView.delegate = self
    }
}

extension MapView: MKMapViewDelegate {
    
    /* we need to tell the map how to display the track */
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        //check if we are dealing with polyline, otherwise just return default renderer
        guard overlay is MKPolyline else { return MKOverlayRenderer() }
        
        //drawing a nice line :)
        let lineView = MKPolylineRenderer(overlay: overlay)
        lineView.strokeColor = UIColor.blue
        lineView.lineWidth = 1
        return lineView
    }
}
