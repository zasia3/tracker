//
//  JourneyStorage.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreData
import Model


/* this class manages interactions with the journey related db operations */
final public class JourneyStorage: StorageDataServiceProtocol {
    
    public var delegate: DataStorage?
    
    private let managedObjectContext: NSManagedObjectContext
    
    public init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    /* save the user journey to the store */
    public func saveJourney(from journey: Journey) {
        let _ = StoredJourney.create(from: journey, moc: managedObjectContext)
        delegate?.save()
    }
    
    /* get all user journeys from the store */
    public func allJourneys() -> [Journey] {
        
        /* first get all managed objects */
        let storedJourneys = journeysFromStore()
        
        /* convert them to the value types and return to the outside world */
        return storedJourneys.map({ $0.toJourneyData() })
    }
    
    /* just get all journeys from core data */
    private func journeysFromStore() -> [StoredJourney] {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: StoredJourney.entityname)
            var objects: [StoredJourney]
            try objects = managedObjectContext.fetch(fetchRequest) as! [StoredJourney]
            
            return objects
        } catch {
            let nserror = error as NSError
            fatalError(nserror.localizedDescription)
        }
    }
}
