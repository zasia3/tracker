//
//  JourneyStatus.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

public enum JourneyStatus {
    case journeyOff   // journey and tracking are off
    case journeyOn    // journey is on, no tracking has started yet
    case trackingOn   // journey and tracking are on
    case trackingOff  // journey is on, tracking is off
}
