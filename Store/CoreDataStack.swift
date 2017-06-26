//
//  CoreDataStack.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreData

/* this class configures the core data items */
final public class CoreDataStack {
    
    /* lazy loading of the data model */
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelUrl = Bundle(for: CoreDataStack.self).url(forResource: "Journeys", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOf: modelUrl)!
    }()
    
    
    /* configure persistent store, save data to sqlite db, set automatic migrations */
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsUrl.appendingPathComponent("Journeys.sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        } catch {
            let nserror = error as NSError
            fatalError("Problem with creating persistent store: \(nserror.userInfo)")
        }
        
        return coordinator
    }()
    
    /* setup managed object context and set the persistent store coordinator */
    lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    /* call when you want to save something in the db */
    func saveContext() {
        /* saving operation is costly - so just save it is necessary */
        guard managedObjectContext.hasChanges else { return }
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Problem with saving data to the store: \(nserror.userInfo)")
        }
    }
}
