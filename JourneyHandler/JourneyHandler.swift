//
//  JourneyHandler.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Model
import Store

public final class JourneyHandler {
    
    /* used to record start date of a new journey */
    private var startDate: Date?
    
    /* last position date */
    private var endDate: Date?
    
    /* this variable is collecting user positions during current journey */
    private var positions = [Position]()
    
    // just for the sake of init from other modules(targets)
    public init() {}
    
    public var journeyHasStarted = false
    
    
    /* get all recorded journeys */
    public func getJourneys() -> [Journey] {
        return DataStorage.shared.journeys.allJourneys()
    }
    
    /* start a new journey */
    public func startJourney() {
        journeyHasStarted = true
    }
    
    /* stop current journey and save the recorded data */
    public func stopJourney() {
        guard let startDate = startDate,
            let endDate = endDate else { return }
        
        /* set end date to the current time and store the journey*/
        let journey = Journey(startDate: startDate, endDate: endDate, track: positions)
        
        /* save the journey to the store */
        DataStorage.shared.journeys.saveJourney(from: journey)
        
        /* cleanup */
        positions.removeAll()
        self.startDate = nil
    }
    
    /* save recorded user position in the current track */
    public func updateTrack(with position: Position) {
        
        /*if this is the first recorded position for this journey - set the start date */
        if startDate == nil {
            startDate = position.date
        }
        
        positions.append(position)
        endDate = position.date //update end date each time we get a new user position
    }
    
    /* get the currently recorded track */
    public func currentTrack() -> [Position] {
        return positions
    }
}
