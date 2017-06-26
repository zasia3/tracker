//
//  StoredJourney+CoreDataClass.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreData
import Model

public class StoredJourney: NSManagedObject {
    
    static func create(from data: Journey, moc: NSManagedObjectContext) -> StoredJourney {
        let journey = StoredJourney.create(in: moc)
        
        journey.startDate = data.startDate as NSDate
        journey.endDate = data.endDate as NSDate
        
        journey.track = Set(data.track.map() { position in
            let storedPosition = StoredPosition.create(from: position, moc: moc)
            return storedPosition
        })
        
        return journey
    }
}
