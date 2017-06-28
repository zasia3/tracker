//
//  ProfileViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Auth

final class ProfileViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            Auth.shared.logout()
            showLogoutAlert()
        }
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(title: "", message: "You have been logged out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
