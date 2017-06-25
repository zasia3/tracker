//
//  Journey.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

public struct Journey {
    
    public let startDate: Date
    public let endDate: Date
    public let track: [Position]
    
    public init(startDate: Date, endDate: Date, track: [Position]) {
        self.startDate = startDate
        self.endDate = endDate
        self.track = track
    }
}
