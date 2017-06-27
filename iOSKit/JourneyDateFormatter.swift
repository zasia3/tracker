//
//  JourneyDateFormatter.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

/* common dates formatter - lets have consistent datetime format in the app */
public final class JourneyDateFormatter {
    
    private static let dateFormat = "yyyy.MM.dd - HH:mm:ss"
    
    /* return formatted date string based on the Date */
    public static func getDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
    
    /* return Date based on the formatted string - currently this method is necessary for testing */
    public static func getDate(from dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.date(from: dateString)
    }
}
