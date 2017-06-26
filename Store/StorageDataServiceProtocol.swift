//
//  StorageDataServiceProtocol.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreData

/* common actions/properties for each model storage */
protocol StorageDataServiceProtocol {

    var delegate: DataStorage? { get set }
    
    init(managedObjectContext: NSManagedObjectContext)
}
