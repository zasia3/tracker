//
//  JourneyDateFormatter.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

public final class JourneyDateFormatter {
    
    public static func getDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd - HH:mm:ss"
        return formatter.string(from: date)
    }
}
