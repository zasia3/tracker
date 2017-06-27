//
//  Double+rounding.swift
//  Tracker
//
//  Created by MacBook Pro on 27.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

extension Double {
    
    public func roundTo(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
