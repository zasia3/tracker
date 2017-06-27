//
//  TimeIntervalExt.swift
//  Tracker
//
//  Created by MacBook Pro on 27.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
extension TimeInterval {
    
    func format() -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 3
        return formatter.string(from: self)
    }
}
