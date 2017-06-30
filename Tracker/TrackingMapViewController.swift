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


/* view controller for tracking user position */
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* if we are not tracking and user returns from another screen - start getting his position to show it on the map */
        TrackingHandler.shared.resumeUserUpdate()
        
        /* clear the map if not tracking, and user returns from the other views,
         * without it, the map will still display the previous track
         */
        if TrackingHandler.shared.journeyStatus == .journeyOff {
            mapView.removeTrack()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* if we are not tracking and user goes to another screen - stop getting his position */
        TrackingHandler.shared.pauseUserUpdate()
    }
    
    

    /* set the position tracker delegate and ask for user location */
    private func setupTracker() {
        TrackingHandler.shared.delegate = self
        TrackingHandler.shared.getUserLocation()
    }
    
    /* configure the state of the journey button,
     * based on the current tracking status 
     * in this case - only the button title must be set
     */
    private func setupJourneyToggle() {
        if TrackingHandler.shared.journeyStatus == .journeyOff {
            journeyButton.setTitle("Start journey", for: .normal)
        } else {
            journeyButton.setTitle("Stop journey", for: .normal)
        }
    }
    
    /* configure the state of the tracking switch,
     * based on the current tracking status
     * the config relates to the user interactions enabling, setting on/off, changing label color
     */
    private func setupTrackingSwitch() {
        switch TrackingHandler.shared.journeyStatus {
        case .journeyOff:
            enableTrackingControls(false)
            trackingSwitch.isOn = false
        case .trackingOn:
            enableTrackingControls(true)
            trackingSwitch.isOn = true
        case .trackingOff:
            trackingSwitch.isOn = false
        }
    }
    
    /* change text of the label next to the switch - depending on the tracking status */
    private func setupTrackingLabel() {
        switch TrackingHandler.shared.journeyStatus {
        case .journeyOff, .trackingOff:
            toggleLabel.text = "Start tracking"
        case .trackingOn:
            toggleLabel.text = "Stop tracking"
        }
    }
    /* enable/disable switch and change color of the label
     * if the switch is disabled - label should be gray, otherwise - black
     */
    private func enableTrackingControls(_ enable: Bool) {
        trackingSwitch.isEnabled = enable
        toggleLabel.textColor = enable ? UIColor.black : UIColor.lightGray
    }
    
    /* react on user change of the switch */
    @IBAction func didToggleTracking(_ sender: Any) {
        
        /* depending on the current tracking status - turn on/off tracking */
        TrackingHandler.shared.toggleTracking()
        
        /* and update UI */
        setupTrackingSwitch()
        setupTrackingLabel()
    }
    /* react on user tap on the journey button */
    @IBAction func toggleJourney(_ sender: Any) {
        
        /* depending on the current tracking status - turn on/off journey */
        TrackingHandler.shared.toggleJourney()
        
        /* and update UI */
        setupJourneyToggle()
        setupTrackingSwitch()
        setupTrackingLabel()
        clearMap()
    }
    
    /* remove track from the map - we need a clear map for a new journey */
    fileprivate func clearMap() {
        if TrackingHandler.shared.journeyStatus == .trackingOff {
            mapView.removeTrack()
        }
    }
}

extension TrackingMapViewController: TrackingHandlerDelegate {
    
    /* when we receive the user position - we show it on the map */
    func didReceiveUserPosition(_ position: Position) {
        
        print(position)
        mapView.showUserLocation(with: position)
    }
    
    /* if track has changed - display it on the map */
    func trackChanged() {
        
        let positions = TrackingHandler.shared.currentTrack()
        mapView.showCurrentTrack(with: positions)
    }
}


