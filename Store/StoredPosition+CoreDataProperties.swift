//
//  StoredPosition+CoreDataProperties.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreData


extension StoredPosition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredPosition> {
        return NSFetchRequest<StoredPosition>(entityName: "StoredPosition")
    }

    @NSManaged public var date: NSDate
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var journey: StoredJourney

}
