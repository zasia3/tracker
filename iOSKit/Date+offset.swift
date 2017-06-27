//
//  Date+offset.swift
//  Tracker
//
//  Created by MacBook Pro on 27.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

extension Date {
    
    public func dateOffset(from date: Date) -> String? {
        let interval = timeIntervalSince(date)
        return interval.format()
    }
}
