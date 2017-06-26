//
//  DataStorage.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

/* this class manages all store related actions */
public final class DataStorage {
    public static let shared = DataStorage() //singleton
    
    private let coreDataStack: CoreDataStack
    public let journeys: JourneyStorage
    let positions: PositionStorage
    
    init() {
        coreDataStack = CoreDataStack()
        journeys = JourneyStorage(managedObjectContext: coreDataStack.managedObjectContext)
        positions = PositionStorage(managedObjectContext: coreDataStack.managedObjectContext)
        
        journeys.delegate = self
        positions.delegate = self
    }
    
    public func save() {
        coreDataStack.saveContext()
    }
}
