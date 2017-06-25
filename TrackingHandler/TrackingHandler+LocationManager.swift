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
        
        /* inform delegate about location change */
        let position = Position(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        delegate?.didReceiveUserPosition(position)
        
        /* if we are currently tracking the user, we must add the position to the current track and inform delegate */
        if journeyStatus == .trackingOn {
            journeyHandler.updateTrack(with: position)
            delegate?.trackChanged()
        }
    }
}
