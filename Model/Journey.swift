//
//  Journey.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreLocation
import iOSKit

/* model for a journey */

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

extension Journey {
    
    public func totalTime() -> String? {
        return endDate.dateOffset(from: startDate)
    }
    
    /* average speed in km per hour */
    public func averageSpeed() -> Double? {
        
        guard let journeyDistance = distance() else { return nil }
        
        let duration = endDate.timeIntervalSince(startDate)
        
        /* to get speed in km/h I need to first convert distance to kilometers and duration to hours */
        return (journeyDistance / 1000) / (duration / 3600)
    }
    
    /* calculate distance in meters */
    public func distance() -> Double? {
        /* I can calculate distance only if there is > 1 points */
        guard track.count > 1 else { return nil }
        
        var distance: CLLocationDistance = 0
        var points = track.map({ CLLocation(latitude: $0.latitude, longitude: $0.longitude) })
        var currentPoint = points.remove(at: 0)
        
        for point in points {
            distance += currentPoint.distance(from: point)
            currentPoint = point
        }
        
        return distance
    }
}
