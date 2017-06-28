//
//  JourneyStatus.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

/* available journey statuses - helper for tracking */
public enum JourneyStatus {
    case journeyOff   // journey and tracking are off
    case trackingOn   // journey and tracking are on
    case trackingOff  // journey is on, tracking is off
}
