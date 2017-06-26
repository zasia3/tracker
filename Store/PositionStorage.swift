//
//  PositionStorage.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import CoreData

final public class PositionStorage: StorageDataServiceProtocol {
    
    public var delegate: DataStorage?
    
    private let managedObjectContext: NSManagedObjectContext
    
    public init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
}
