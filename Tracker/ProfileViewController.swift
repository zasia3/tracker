//
//  ProfileViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Auth

final class ProfileViewController: UITableViewController, AuthProtectedViewController {
    
    private var dataSource: ProfileDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ProfileDataSource()
        tableView.dataSource = dataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.item(for: indexPath.row)
        switch item {
        case .login:
            if Auth.shared.isLoggedIn() {
                Auth.shared.logout()
                showLogoutAlert()
                tableView.reloadData()
            } else {
                showLogin()
            }
        }
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(title: "", message: "You have been logged out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
