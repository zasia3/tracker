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
    
    /* convert managed object to value type */
    func toJourneyData() -> Journey {

        /* we need to convert also the related objects */
        let positions = self.track.map({ $0.toPositionData() })
        
        return Journey(startDate: self.startDate as Date, endDate: self.endDate as Date, track: positions)
    }
}
