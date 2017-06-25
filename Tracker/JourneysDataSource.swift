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

final class JourneysDataSource: NSObject, UITableViewDataSource {
    
    private var items: [Journey]!
    
    //load  data for the table
    func load() {
        items = TrackingHandler.shared.journeys()
    }
    
    func item(for index: Int) -> Journey {
        return items[index]
    }
    
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
        cell?.textLabel?.text = JourneyDateFormatter.getDateTime(item.startDate)
        
        return cell!
    }
}
