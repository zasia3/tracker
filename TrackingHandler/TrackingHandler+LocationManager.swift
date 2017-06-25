//
//  TrackingHandler+LocationManager.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreLocation
import Model

extension TrackingHandler: CLLocationManagerDelegate {
    
    
    /* this method lets us to use location from system tracking */
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let position = Position(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        delegate?.didReceiveUserPosition(position)
    }
}
