//
//  Track.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

public struct Track {
    public let initialDate: Date?
    public let positions: [Position]
    
    public init(positions: [Position]) {
        self.positions = positions
        initialDate = positions.first?.date
    }
}
