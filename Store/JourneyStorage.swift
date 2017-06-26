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

final public class JourneyStorage: StorageDataServiceProtocol {
    
    public var delegate: DataStorage?
    
    private let managedObjectContext: NSManagedObjectContext
    
    public init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    public func saveJourney(from journey: Journey) {
        let _ = StoredJourney.create(from: journey, moc: managedObjectContext)
        delegate?.save()
    }
    
    public func allJourneys() -> [Journey] {
        let storedJourneys = journeysFromStore()
        
        return storedJourneys.map({ $0.toJourneyData() })
    }
    
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
