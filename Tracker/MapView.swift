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
    private let regionRadius: CLLocationDistance = 1000
    private let annotation = MKPointAnnotation()
    
    override public func onInit() {
        configureMapView()
    }
    
    /* show a pin with user location on a map and center map on this location */
    public func showUserLocation(position: Position) {
        let mapLocation = CLLocation(latitude: position.latitude, longitude: position.longitude)
        centerMap(on: mapLocation)
        showStartPin(on: mapLocation)
    }
    
    private func centerMap(on location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func showStartPin(on location: CLLocation) {
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    
    private func configureMapView() {
        addSubview(mapView)
        mapView.fillSuperview()
    }
}
