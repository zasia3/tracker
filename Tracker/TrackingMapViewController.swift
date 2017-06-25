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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTrackingSwitch()
        setupTracker()
    }

    /* set the position tracker delegate and ask for user location */
    private func setupTracker() {
        TrackingHandler.shared.delegate = self
        TrackingHandler.shared.getUserLocation()
    }
    
    private func setupTrackingSwitch() {
        trackingSwitch.isOn = false
        toggleLabel.text = "Start tracking"
    }
    
    /* react on user change of the switch */
    @IBAction func didToggleTracking(_ sender: Any) {
        if trackingSwitch.isOn {
            toggleLabel.text = "Stop tracking"
            TrackingHandler.shared.startTracking()
        } else {
            toggleLabel.text = "Start tracking"
            TrackingHandler.shared.stopTracking()
        }
    }
}

extension TrackingMapViewController: TrackingHandlerDelegate {
    
    /* when we receive the user position - we show it on the map */
    func didReceiveUserPosition(_ position: Position) {
        
        print(position)
        
        mapView.showUserLocation(position: position)
        showCurrentTrack()
    }
    
    /* display user track on the map */
    private func showCurrentTrack() {
        let positions = TrackingHandler.shared.currentTrack()
        mapView.showCurrentTrack(with: positions)
    }
}


