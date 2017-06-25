//
//  JourneyHandler.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Model

public final class JourneyHandler {
    
    /* used to record start date of a new journey */
    private var startDate: Date?
    
    /* this variable is collecting user positions during current journey */
    private var positions = [Position]()
    
    /* stores user journeys */
    private var journeys = [Journey]()
    
    // just for the sake of init from other modules(targets)
    public init() {}
    
    public var journeyHasStarted: Bool {
        return startDate == nil ? false : true
    }
    
    public func startJourney() {
        /* set the current date as a start date */
        startDate = Date()
    }
    
    public func stopJourney() {
        guard let startDate = startDate else { return }
        
        /* set end date to the current time and store the journey*/
        let journey = Journey(startDate: startDate, endDate: Date(), track: positions)
        journeys.append(journey)
        
        /* cleanup */
        positions.removeAll()
        self.startDate = nil
    }
    
    public func updateTrack(with position: Position) {
        positions.append(position)
    }
    
    public func currentTrack() -> [Position] {
        return positions
    }
}
