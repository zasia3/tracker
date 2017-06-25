//
//  ViewControllerFactory.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit

enum ControllerType: CustomStringConvertible {
    case track
    case journeys
    case journeyDetails
    
    var storyboardIdentifier: String {
        switch self {
        case .track:
            return "TrackingMapViewController"
        case .journeys:
            return "JourneysListViewController"
        case .journeyDetails:
            return "JourneyDetailsViewController"
        }
    }
    
    var description: String {
        switch self {
        case .track:
            return "Track"
        case .journeys:
            return "Journeys"
        case .journeyDetails:
            return "Journey details"
        }
    }
    
    var tabBarImage: UIImage? {
        switch self {
        case .track:
            return UIImage(named: "map_icon")
        case .journeys:
            return UIImage(named: "list_icon")
        default:
            return nil
        }
    }
}

final class ViewControllerFactory {
    static func viewControllerFromStoryboard(_ type: ControllerType) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: type.storyboardIdentifier)
    }
}
