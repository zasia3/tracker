//
//  StoredPosition+CoreDataClass.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreData
import Model

public class StoredPosition: NSManagedObject {

    /* create a new managed object according to the related value type */
    static func create(from data: Position, moc: NSManagedObjectContext) -> StoredPosition {
        let position = StoredPosition.create(in: moc)
        position.date = data.date as NSDate
        position.longitude = data.longitude
        position.latitude = data.latitude
        return position
    }

}
