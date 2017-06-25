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
    func trackChanged()
}

public final class TrackingHandler: NSObject {
    
    public static let shared = TrackingHandler() // this is singleton
    
    public weak var delegate: TrackingHandlerDelegate?
    
    /* manager responsible for collecting user current position */
    private let locationManager = CLLocationManager()
    
    /* this is a handler for tracks/journeys, for getting and storing them */
    let journeyHandler = JourneyHandler()
    
    /* status of the journey */
    public var journeyStatus: JourneyStatus = .journeyOff
    
    /* we need to ask for user permission for location tracking */
    public func initialize() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    public func journeys() -> [Journey] {
        return journeyHandler.getJourneys()
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
    
    /* start or stop journey - depending if it has already started or not */
    public func toggleJourney() {
        if journeyHandler.journeyHasStarted {
            finishJourney()
        } else {
            startJourney()
        }
    }
    
    /* let the journey begin */
    private func startJourney() {
        journeyStatus = .journeyOn
        journeyHandler.startJourney()
    }
    
    /* finalize current journey and stop tracking */
    private func finishJourney() {
        journeyHandler.stopJourney()
        stopTracking()
        journeyStatus = .journeyOff
    }
    
    public func toggleTracking() {
        if journeyStatus == .trackingOn {
            stopTracking()
        } else {
            startTracking()
        }
    }
    
    private func startTracking() {
        journeyStatus = .trackingOn
        locationManager.startUpdatingLocation()
    }
    
    private func stopTracking() {
        journeyStatus = .trackingOff
        locationManager.stopUpdatingLocation()
    }
    
    public func currentTrack() -> [Position] {
        return journeyHandler.currentTrack()
    }
}
