//
//  NSManagedObjectExt.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    /* useful shortcut for inserting new objects into db */
    static func create(in context: NSManagedObjectContext) -> Self {
        return createObject(in: context)
    }
    
    private static func createObject<T>(in context: NSManagedObjectContext) -> T {
        let object = NSEntityDescription.insertNewObject(forEntityName: entityname, into: context) as! T
        
        return object
    }
    
    /* get the entity name. normally in coredata, entity name contains also name of the module, so we need to remove it */
    static var entityname: String {
        let classname = NSStringFromClass(self)
        let components = classname.components(separatedBy: ".")
        
        return components.last ?? classname
    }
    
    /* delete all instances of this entity in db - currently for tests */
    static func deleteAll(_ context:NSManagedObjectContext) {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityname)
            var objects: [NSManagedObject]
            try objects = context.fetch(fetchRequest) as! [NSManagedObject]
            for object in objects {
                context.delete(object)
            }
        } catch {
            let nserror = error as NSError
            fatalError(nserror.localizedDescription)
        }
    }
}
