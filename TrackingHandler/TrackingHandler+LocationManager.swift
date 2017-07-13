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
    
    /* use the location manager delegate method to retrieve current user position and pass it where needed */
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        /* inform delegate about location change and pass it a current user location 
         * this is independent from saving user tracks. User may only see his position without starting a journey
         */
        let position = Position(date: location.timestamp, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        delegate?.didReceiveUserPosition(position)
        geoRegion = CLCircularRegion(center: location.coordinate, radius: 10, identifier: "RegionTracker")
        
        /* if we are currently tracking the user, we must add the position to the current track and inform delegate */
        if journeyStatus == .trackingOn {
            journeyHandler.updateTrack(with: position)
            delegate?.trackChanged()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        startJourney()
        delegate?.didExitRegion()
    }
}
