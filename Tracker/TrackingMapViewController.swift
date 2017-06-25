//
//  TrackingMapViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 23.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import TrackingHandler
import Model

final class TrackingMapViewController: UIViewController {

    @IBOutlet weak var toggleLabel: UILabel!
    @IBOutlet weak var trackingSwitch: UISwitch!
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var journeyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupJourneyToggle()
        setupTrackingLabel()
        setupTrackingSwitch()
        setupTracker()
    }

    /* set the position tracker delegate and ask for user location */
    private func setupTracker() {
        TrackingHandler.shared.delegate = self
        TrackingHandler.shared.getUserLocation()
    }
    
    private func setupJourneyToggle() {
        if TrackingHandler.shared.journeyStatus == .journeyOff {
            journeyButton.setTitle("Start journey", for: .normal)
        } else {
            journeyButton.setTitle("Stop journey", for: .normal)
        }
    }
    
    private func setupTrackingSwitch() {
        switch TrackingHandler.shared.journeyStatus {
        case .journeyOff:
            enableTrackingControls(false)
            trackingSwitch.isOn = false
        case .journeyOn:
            enableTrackingControls(true)
            trackingSwitch.isOn = false
        case .trackingOn:
            trackingSwitch.isOn = true
        case .trackingOff:
            trackingSwitch.isOn = false
        }
    }
    
    private func setupTrackingLabel() {
        switch TrackingHandler.shared.journeyStatus {
        case .journeyOff, .trackingOff, .journeyOn:
            toggleLabel.text = "Start tracking"
        case .trackingOn:
            toggleLabel.text = "Stop tracking"
        }
    }
    
    private func enableTrackingControls(_ enable: Bool) {
        trackingSwitch.isEnabled = enable
        toggleLabel.textColor = enable ? UIColor.black : UIColor.lightGray
    }
    
    /* react on user change of the switch */
    @IBAction func didToggleTracking(_ sender: Any) {
        TrackingHandler.shared.toggleTracking()
        setupTrackingSwitch()
        setupTrackingLabel()
    }
    
    @IBAction func toggleJourney(_ sender: Any) {
        TrackingHandler.shared.toggleJourney()
        setupJourneyToggle()
        setupTrackingSwitch()
        setupTrackingLabel()
        clearMap()
    }
    
    fileprivate func clearMap() {
        if TrackingHandler.shared.journeyStatus == .journeyOn {
            mapView.removeTrack()
        }
    }
}

extension TrackingMapViewController: TrackingHandlerDelegate {
    
    /* when we receive the user position - we show it on the map */
    func didReceiveUserPosition(_ position: Position) {
        
        print(position)
        mapView.showUserLocation(position: position)
    }
    
    /* if track changed - display user track on the map */
    func trackChanged() {
        
        let positions = TrackingHandler.shared.currentTrack()
        mapView.showCurrentTrack(with: positions)
    }
}


