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
    public static let shared = DataStorage() // singleton
    
    /* we need all the db related stuff (model, persistent storage, etc.) 
     * it is hidden from the outside world, 
     * because I want to controll all the operations on the db
     */
    private let coreDataStack: CoreDataStack
    
    /* this one will manage all journey storage operations
     * it is visible for the outside world and is the only way to interact (by outside classes)
     * with the journeys related db operations
     * If needed - I can create more storages for particular managed objects,
     * however in this simple app, this is not necessary
     */
    public let journeys: JourneyStorage
    
    init() {
        
        /* initialize the stack and database storage */
        coreDataStack = CoreDataStack()
        journeys = JourneyStorage(managedObjectContext: coreDataStack.managedObjectContext)
        
        journeys.delegate = self
    }
    
    /* this is the only place where saving occurs - used internally by the storages */
    func save() {
        coreDataStack.saveContext()
    }
    
    /* delete everything from db - currently for tests */
    public func deleteAllData() {
        StoredJourney.deleteAll(coreDataStack.managedObjectContext)
        save()
    }
}
