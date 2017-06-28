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
    
    var title: String {
        switch self {
        case .login:
            if Auth.shared.isLoggedIn() {
                return "Logout"
            }
            return "Login"
        }
    }
}

final class ProfileDataSource: NSObject, UITableViewDataSource {
    
    private let items: [ProfileCellType] = [.login]
    
    
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
        
        return cell!
    }
}
