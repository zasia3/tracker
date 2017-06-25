//
//  Journey.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

public struct Journey {
    public let tracks: [Track]
    
    public init(tracks: [Track]) {
        self.tracks = tracks
    }
}
