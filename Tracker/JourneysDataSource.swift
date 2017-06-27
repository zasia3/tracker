//
//  JourneysDataSource.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Model
import TrackingHandler
import iOSKit

final class JourneysDataSource: NSObject {
    
    /* journeys data - displayed in the table view */
    fileprivate var items: [Journey]! {
        
        /* once the items are loaded - we need to sort them according to our needs
         * in this case - sort descending, so the newest journey is on top
         */
        didSet {
            items = items.sorted(by: { $0.startDate > $1.startDate } )
        }
    }
    
    /* load  data for the table and sort them descending - the newest on top */
    func load() {
        items = TrackingHandler.shared.journeys()
    }
    
    /* get particular item */
    func item(for index: Int) -> Journey {
        return items[index]
    }
    
    /* this function allows direct inserting data items - needed for inserting mock data during tests*/
    func setItems(_ items: [Journey]) {
        self.items = items
    }
    
}

extension JourneysDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "journeyCell")
        
        //just show the start date of the journey
        cell?.textLabel?.text = JourneyDateFormatter.getDateString(from: item.startDate)
        
        return cell!
    }
}
