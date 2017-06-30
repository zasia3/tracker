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

public protocol TrackingHandlerDelegate: class {
    func didReceiveUserPosition(_ position: Position)
    func trackChanged()
}

public final class TrackingHandler: NSObject {
    
    public static let shared = TrackingHandler() // this is singleton
    
    /* delegate which will respond on the user position changes */
    public weak var delegate: TrackingHandlerDelegate?
    
    /* manager responsible for collecting user current position */
    private let locationManager = CLLocationManager()
    
    /* this is a handler for tracks/journeys, for getting and storing them */
    let journeyHandler = JourneyHandler()
    
    /* status of the journey */
    public var journeyStatus: JourneyStatus = .journeyOff
    
    /* initialize location manager, ask user for permissions to track the position,
     * optimize location updates when the app is suspended
     * optimize the accuracy - so the battery is not drained so quickly
     */
    public func initialize() {
        locationManager.requestAlwaysAuthorization()
        
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        locationManager.delegate = self
    }
    
    /* get all stored journeys */
    public func journeys() -> [Journey] {
        return journeyHandler.getJourneys()
    }
    
    /* invoke getting and updating user position */
    public func getUserLocation() {
        
        //we must check if the user accepted location tracking
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus != CLAuthorizationStatus.restricted &&
            authorizationStatus != CLAuthorizationStatus.denied {
            
            /* if user accepted - we can track him */
            locationManager.startUpdatingLocation()
        }
    }
    
    /* get current user track */
    public func currentTrack() -> [Position] {
        return journeyHandler.currentTrack()
    }
    
    /* start or stop journey - depending if it has already started or not */
    public func toggleJourney() {
        if journeyHandler.journeyHasStarted {
            finishJourney()
        } else {
            startJourney()
        }
    }
    
    
    /* if we are not tracking yet, pause getting user location */
    public func pauseUserUpdate() {
        if journeyStatus == .journeyOff {
            locationManager.stopUpdatingLocation()
        }
    }
    
    /* if we are not tracking yet, resume getting user location
     * used in case I just want to update user position without saving it
     */
    public func resumeUserUpdate() {
        if journeyStatus == .journeyOff {
            locationManager.startUpdatingLocation()
        }
    }
    
    /* let the journey begin */
    private func startJourney() {

        journeyHandler.startJourney()
        startTracking()
        /* turn on background tracking */
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    /* finalize current journey and stop tracking */
    private func finishJourney() {
        
        journeyHandler.stopJourney()
        stopTracking()
        journeyStatus = .journeyOff
        
        /* turn off background tracking */
        locationManager.allowsBackgroundLocationUpdates = false
        resumeUserUpdate()
    }
    
    /* turn on or off tracking user position during the journey */
    public func toggleTracking() {
        if journeyStatus == .trackingOn {
            stopTracking()
        } else {
            startTracking()
        }
    }
    
    /* start updating user location and set tracking status to on */
    private func startTracking() {
        journeyStatus = .trackingOn
        locationManager.startUpdatingLocation()
    }
    
    /* start updating user location and set tracking status to off */
    private func stopTracking() {
        journeyStatus = .trackingOff
        locationManager.stopUpdatingLocation()
    }
}
