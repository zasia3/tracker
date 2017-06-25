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

    /* this variable is collecting user positions during current track */
    private var positions = [Position]()
    
    // just for the sake of init from other modules(targets)
    public init() {}
    
    
    public func startTrack() {
        positions.removeAll()
    }
    
    public func updateTrack(with position: Position) {
        positions.append(position)
    }
    
    public func currentTrack() -> [Position] {
        return positions
    }
}
