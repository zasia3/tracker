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

    @IBOutlet weak var mapView: MapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTracker()
    }

    /* set the position tracker delegate and ask for user location */
    private func setupTracker() {
        TrackingHandler.shared.delegate = self
        TrackingHandler.shared.getUserLocation()
    }
}

extension TrackingMapViewController: TrackingHandlerDelegate {
    
    /* when we receive the user position - we show it on the map */
    func didReceiveUserPosition(_ position: Position) {
        
        mapView.showUserLocation(position: position)
    }
}


