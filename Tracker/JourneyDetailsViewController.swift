//
//  JourneyDetailsViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Model
import iOSKit

final class JourneyDetailsViewController: UIViewController {
    
    var journey: Journey!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        setupLabels()
    }
    
    private func setupLabels() {
        startDate.text = JourneyDateFormatter.getDateTime(journey.startDate)
        endDate.text = JourneyDateFormatter.getDateTime(journey.endDate)
    }
}
