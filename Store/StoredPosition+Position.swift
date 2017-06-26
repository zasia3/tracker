//
//  StoredPosition+Position.swift
//  Tracker
//
//  Created by MacBook Pro on 26.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Model

extension StoredPosition {
    
    /* simply convert managed object to value type */
    func toPositionData() -> Position {
        
        return Position(date: self.date as Date, latitude: self.latitude, longitude: self.longitude)
    }
}
