//
//  TrackingHandler.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreLocation
import Model
import JourneyHandler

public protocol TrackingHandlerDelegate: class {
    func didReceiveUserPosition(_ position: Position)
}

public final class TrackingHandler: NSObject {
    
    public static let shared = TrackingHandler()
    
    public weak var delegate: TrackingHandlerDelegate?
    
    /* manager responsible for collecting user current position */
    private let locationManager = CLLocationManager()
    
    /* this is a handler for tracks/journeys, for getting and storing them */
    let journeyHandler = JourneyHandler()
    
    var isTrackingUser = false
    
    /* we need to ask for user permission for location tracking */
    public func initialize() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    /* method which invokes getting user position */
    public func getUserLocation() {
        
        //we must check if the user accepted location tracking
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus != CLAuthorizationStatus.restricted &&
            authorizationStatus != CLAuthorizationStatus.denied {
            
            /* if user accepted - we can track him */
            locationManager.startUpdatingLocation()
        }
    }
    
    
    public func startTracking() {
        isTrackingUser = true
        journeyHandler.startTrack()
        locationManager.startUpdatingLocation()
    }
    
    public func stopTracking() {
        isTrackingUser = false
        locationManager.stopUpdatingLocation()
    }
    
    public func currentTrack() -> [Position] {
        return journeyHandler.currentTrack()
    }
}
