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
}

public final class TrackingHandler: NSObject {
    
    public static let shared = TrackingHandler()
    
    public weak var delegate: TrackingHandlerDelegate?
    
    /* manager responsible for collecting user current position */
    private let locationManager = CLLocationManager()
    
    
    /* we need to ask for user permission for location tracking */
    public func initialize() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    /* method which invokes getting user position */
    public func getUserLocation() {
        let authorizationStatus = CLLocationManager.authorizationStatus() //we must check if user accepted location tracking
        
        
        if authorizationStatus != CLAuthorizationStatus.restricted &&
            authorizationStatus != CLAuthorizationStatus.denied {
            
            /* if user accepted - we can track him */
            locationManager.startUpdatingLocation()
        }
    }
}
