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
    
    /* this variable is collecting user positions during current journey */
    private var positions = [Position]()
    
    // just for the sake of init from other modules(targets)
    public init() {}
    
    public var journeyHasStarted: Bool {
        return startDate == nil ? false : true
    }
    
    public func getJourneys() -> [Journey] {
        return DataStorage.shared.journeys.allJourneys()
    }
    
    public func startJourney() {
        /* set the current date as a start date */
        startDate = Date()
    }
    
    public func stopJourney() {
        guard let startDate = startDate else { return }
        
        /* set end date to the current time and store the journey*/
        let journey = Journey(startDate: startDate, endDate: Date(), track: positions)
        
        /* save the journey to the store */
        DataStorage.shared.journeys.saveJourney(from: journey)
        
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
