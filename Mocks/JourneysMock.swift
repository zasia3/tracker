//
//  JourneysMock.swift
//  Tracker
//
//  Created by MacBook Pro on 26.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Model

public final class JourneysMock {
    
    
    public static func journeys() -> [Journey] {
        let track1Mock = track1()
        let track2Mock = track2()
        
        return [
            Journey(startDate: track1Mock.first!.date, endDate: track1Mock.last!.date, track: track1Mock),
            Journey(startDate: track2Mock.first!.date, endDate: track2Mock.last!.date, track: track2Mock)
        ]
    }
    
    public static func track1() -> [Position] {
        return [
            Position(date: Date(), latitude: 50.2820702, longitude: 18.6308127),
            Position(date: Date(timeIntervalSinceNow: 5), latitude: 50.2820702, longitude: 18.6308127),
            Position(date: Date(timeIntervalSinceNow: 11), latitude: 50.2820335, longitude: 18.6307483),
            Position(date: Date(timeIntervalSinceNow: 16), latitude: 50.2819241, longitude: 18.6306037),
            Position(date: Date(timeIntervalSinceNow: 22), latitude: 50.2818346, longitude: 18.6305034)
        ]
    }
    
    public static func track2() -> [Position] {
        return [
            Position(date: Date(timeIntervalSinceNow: 35), latitude: 50.2820702, longitude: 18.6308127),
            Position(date: Date(timeIntervalSinceNow: 40), latitude: 50.2820702, longitude: 18.6308127),
            Position(date: Date(timeIntervalSinceNow: 45), latitude: 50.2820335, longitude: 18.6307483),
            Position(date: Date(timeIntervalSinceNow: 50), latitude: 50.2819241, longitude: 18.6306037),
            Position(date: Date(timeIntervalSinceNow: 55), latitude: 50.2818346, longitude: 18.6305034)
        ]
    }
}
