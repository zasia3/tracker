//
//  JourneysListViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit

final class JourneysListViewController: UITableViewController {
    
    private var dataSource: JourneysDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }
    
    /* initialize data source and assign it to the tableview */
    private func setupDataSource() {
        dataSource = JourneysDataSource()
        tableView.dataSource = dataSource
        reloadData()
    }
    
    /* reload data in the data source, and after that - reload tableview */
    private func reloadData() {
        dataSource.load()
        tableView.reloadData()
    }
    
    /* when user selects a journey from the list - show the details of that journey */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.item(for: indexPath.row)
        let journeyViewController = ViewControllerFactory.viewControllerFromStoryboard(.journeyDetails) as! JourneyDetailsViewController
        journeyViewController.title = ControllerType.journeyDetails.description
        journeyViewController.journey = item
        navigationController?.pushViewController(journeyViewController, animated: true)
    }
}
