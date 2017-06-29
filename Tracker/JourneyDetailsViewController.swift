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

final class JourneyDetailsViewController: UIViewController, AuthProtectedViewController {
    
    var journey: Journey!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var averageSpeedLabel: UILabel!
    
    @IBOutlet weak var mapView: MapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        plotTrack()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLogin(with: self)
    }
    
    /* set the formatted date strings to the labels */
    private func setupLabels() {
        startDate.text = JourneyDateFormatter.getDateString(from: journey.startDate)
        endDate.text = JourneyDateFormatter.getDateString(from: journey.endDate)
        durationLabel.text = journey.totalTime()
        
        let distance = journey.distance() ?? 0
        distanceLabel.text = "\(distance.roundTo(2)) m"
        
        let speed = journey.averageSpeed() ?? 0
        averageSpeedLabel.text = "\(speed.roundTo(2)) km/h"
    }
    
    /* in order to show the track on the map - just send the journey track to the map view */
    private func plotTrack() {
        mapView.showTrack(with: journey.track)
    }
}
extension JourneyDetailsViewController: LoginViewControllerDelegate {
    func didLogin() {}
}
