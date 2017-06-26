//
//  StoredJourney+CoreDataProperties.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreData


extension StoredJourney {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredJourney> {
        return NSFetchRequest<StoredJourney>(entityName: "StoredJourney")
    }

    @NSManaged public var endDate: NSDate
    @NSManaged public var startDate: NSDate
    @NSManaged public var track: Set<StoredPosition>

}

// MARK: Generated accessors for track
extension StoredJourney {

    @objc(addTrackObject:)
    @NSManaged public func addToTrack(_ value: StoredPosition)

    @objc(removeTrackObject:)
    @NSManaged public func removeFromTrack(_ value: StoredPosition)

    @objc(addTrack:)
    @NSManaged public func addToTrack(_ values: NSSet)

    @objc(removeTrack:)
    @NSManaged public func removeFromTrack(_ values: NSSet)

}
