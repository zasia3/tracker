//
//  JourneysMock.swift
//  Tracker
//
//  Created by MacBook Pro on 26.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Model
import iOSKit


public final class JourneysMock {
    
    /* mock for testing journeys */
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
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.17 - 06:05:10")!, latitude: 50.2820702, longitude: 18.6308127),
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.17 - 06:05:15")!, latitude: 50.2820702, longitude: 18.6308127),
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.17 - 06:05:20")!, latitude: 50.2820335, longitude: 18.6307483),
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.17 - 06:05:26")!, latitude: 50.2819241, longitude: 18.6306037),
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.17 - 06:05:32")!, latitude: 50.2818346, longitude: 18.6305034)
        ]
    }
    
    public static func track2() -> [Position] {
        return [
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.18 - 06:05:10")!, latitude: 50.2820702, longitude: 18.6308127),
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.18 - 06:05:15")!, latitude: 50.2820702, longitude: 18.6308127),
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.18 - 06:05:20")!, latitude: 50.2820335, longitude: 18.6307483),
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.18 - 06:05:26")!, latitude: 50.2819241, longitude: 18.6306037),
            Position(date: JourneyDateFormatter.getDate(from: "2017.05.18 - 06:05:32")!, latitude: 50.2818346, longitude: 18.6305034)
        ]
    }
}
