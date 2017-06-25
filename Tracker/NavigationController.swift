//
//  NavigationController.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        guard topViewController != nil else { return .default }
        
        return topViewController!.preferredStatusBarStyle
    }
}
