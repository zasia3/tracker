//
//  Position.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation


/* model for a single position observation */

public struct Position {
    
    public let date: Date
    public let latitude: Double
    public let longitude: Double
    
    public init(date: Date, latitude: Double, longitude: Double) {
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
    }
}
