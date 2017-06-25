//
//  RootViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit

final class RootViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var trackingViewController: NavigationController!
    private var journeysViewController: NavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let trackingType = ControllerType.track
        let trackingController = ViewControllerFactory.viewControllerFromStoryboard(trackingType) as! TrackingMapViewController
        trackingController.title = trackingType.description
        trackingViewController = NavigationController(rootViewController: trackingController)
        trackingViewController.tabBarItem = UITabBarItem(title: trackingType.description, image: trackingType.tabBarImage, selectedImage: trackingType.tabBarImage)
        
        let journeyType = ControllerType.journeys
        let journeysController = ViewControllerFactory.viewControllerFromStoryboard(journeyType) as! JourneysListViewController
        journeysController.title = journeyType.description
        journeysViewController = NavigationController(rootViewController: journeysController)
        journeysViewController.tabBarItem = UITabBarItem(title: journeyType.description, image: journeyType.tabBarImage, selectedImage: journeyType.tabBarImage)
        
        viewControllers = [trackingViewController, journeysViewController]
        selectedIndex = 0
    }
}
