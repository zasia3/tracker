//
//  StoredJourney+Journey.swift
//  Tracker
//
//  Created by MacBook Pro on 26.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Model

extension StoredJourney {
    
    func toJourneyData() -> Journey {

        let positions = self.track.map({ $0.toPositionData() })
        
        return Journey(startDate: self.startDate as Date, endDate: self.endDate as Date, track: positions)
    }
}
