//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by MacBook Pro on 27.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import XCTest
@testable import Tracker
import Mocks
import iOSKit

class TrackerTests: XCTestCase {
    
    var journeysVC: JourneysListViewController!
    var dataSource: JourneysDataSource!
    
    override func setUp() {
        super.setUp()
        
        journeysVC = ViewControllerFactory.viewControllerFromStoryboard(.journeys) as! JourneysListViewController
        dataSource = JourneysDataSource()
        dataSource.setItems(JourneysMock.journeys())
        journeysVC.tableView.dataSource = dataSource
        journeysVC.tableView.reloadData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /* this test checks if the data source gets correct number of items from store 
     * and that table view loads them correctly
     */
    func testCorrectNumberOfTableItems() {
        let nrOfRows = journeysVC.tableView.numberOfRows(inSection: 0)
        XCTAssert(nrOfRows == 2, "Number of rows: \(nrOfRows)")
    }
    
    /* checking if the items in the data source are correctly sorted - the newest should be the first one */
    func testItemsSorting() {
        let firstItem = dataSource.item(for: 0)
        let startDateString = JourneyDateFormatter.getDateString(from: firstItem.startDate)
        
        XCTAssert(startDateString == "2017.05.18 - 06:05:10", "Item datetime: \(startDateString)")
    }
}
