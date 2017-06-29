//
//  ProfileDataSource.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Auth

enum ProfileCellType {
    case login
    case changePassword
    
    var title: String {
        switch self {
        case .login:
            if Auth.shared.isLoggedIn() {
                return "Logout"
            }
            return "Login"
        case .changePassword:
            return "Change password"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .changePassword:
            if !Auth.shared.isLoggedIn() {
                return UIColor.lightGray
            }
            fallthrough
        default:
            return UIColor.black
        }
    }
}

final class ProfileDataSource: NSObject, UITableViewDataSource {
    
    private let items: [ProfileCellType] = [.login, .changePassword]
    
    
    /* get particular item */
    func item(for index: Int) -> ProfileCellType {
        return items[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileSimpleCell")
        
        //just show the start date of the journey
        cell?.textLabel?.text = item.title
        cell?.textLabel?.textColor = item.textColor
        return cell!
    }
}
