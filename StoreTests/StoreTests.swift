//
//  StoreTests.swift
//  StoreTests
//
//  Created by MacBook Pro on 27.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import XCTest
@testable import Store
import Mocks
import Model

class StoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        DataStorage.shared.deleteAllData()
        let journeys = JourneysMock.journeys()
        DataStorage.shared.journeys.saveJourney(from: journeys[0])
        DataStorage.shared.journeys.saveJourney(from: journeys[1])
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    /* check if all journeys added in the preparations were saved to the db */
    func testNumberOfAllStoredJourneys() {
        let journeys = DataStorage.shared.journeys.allJourneys()
        
        XCTAssert(journeys.count == 2, "Number of journeys in db: \(journeys.count)")
    }
}
