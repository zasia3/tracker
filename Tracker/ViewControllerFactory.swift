//
//  ViewControllerFactory.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit


/* configuration for view controllers used in this application */
enum ControllerType: CustomStringConvertible {
    case track
    case journeys
    case journeyDetails
    case login
    case register
    case profile
    case changePassword
    
    var storyboardIdentifier: String {
        switch self {
        case .track:
            return "TrackingMapViewController"
        case .journeys:
            return "JourneysListViewController"
        case .journeyDetails:
            return "JourneyDetailsViewController"
        case .login:
            return "LoginViewController"
        case .register:
            return "RegistrationViewController"
        case .profile:
            return "ProfileViewController"
        case .changePassword:
            return "ChangePasswordViewController"
        }
    }
    
    
    /* this is just title/short description of the view controller 
     * can be used as a controller title or tab bar item title
     */
    var description: String {
        switch self {
        case .track:
            return "Track"
        case .journeys:
            return "Journeys"
        case .journeyDetails:
            return "Journey details"
        case .login:
            return "Login"
        case .register:
            return "Register"
        case .profile:
            return "Profile"
        case .changePassword:
            return "Change password"
        }
    }
    
    /* not all view controllers will be reprezented on the tab bar, 
     * so I just set image for those which will be
     */
    var tabBarImage: UIImage? {
        switch self {
        case .track:
            return UIImage(named: "map_icon")
        case .journeys:
            return UIImage(named: "list_icon")
        case .profile:
            return UIImage(named: "profile_icon")
        default:
            return nil
        }
    }
}

/* factory for loading view controllers based on the type */
final class ViewControllerFactory {
    
    /* get view controller according to the type */
    static func viewControllerFromStoryboard(_ type: ControllerType) -> UIViewController {
        
        /* as the app is quite simple - I just use one storyboard
         * but if there is more storyboards - I could also add a storyboard name variable to the
         * ControllerType enum
         */
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: type.storyboardIdentifier)
    }
}
