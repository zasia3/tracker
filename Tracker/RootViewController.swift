//
//  RootViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit

/* this class initializes the tab bar and its controllers */
final class RootViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var trackingViewController: UINavigationController!
    private var journeysViewController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        /* each controller is loaded via storyboard */
        let trackingType = ControllerType.track
        let trackingController = ViewControllerFactory.viewControllerFromStoryboard(trackingType) as! TrackingMapViewController
        trackingController.title = trackingType.description
        
        /* setup own navigation controller for each tab bar view controller */
        trackingViewController = UINavigationController(rootViewController: trackingController)
        
        /* setup tab bar element for this particular controller */
        trackingViewController.tabBarItem = UITabBarItem(title: trackingType.description, image: trackingType.tabBarImage, selectedImage: trackingType.tabBarImage)
        
        /* same configuration for the second view controller - just different type */
        let journeyType = ControllerType.journeys
        let journeysController = ViewControllerFactory.viewControllerFromStoryboard(journeyType) as! JourneysListViewController
        journeysController.title = journeyType.description
        journeysViewController = UINavigationController(rootViewController: journeysController)
        journeysViewController.tabBarItem = UITabBarItem(title: journeyType.description, image: journeyType.tabBarImage, selectedImage: journeyType.tabBarImage)
        
        /* add initialized controllers to the tab bar controller */
        viewControllers = [trackingViewController, journeysViewController]
        selectedIndex = 0 // and indicate default open controller to the first one
    }
}
