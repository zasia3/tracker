//
//  ProfileViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Auth
import iOSKit

final class ProfileViewController: UITableViewController, AlertProtocol, AuthProtectedViewController {
    
    private var dataSource: ProfileDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = ProfileDataSource()
        tableView.dataSource = dataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reload()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.item(for: indexPath.row)
        
        switch item {
        case .login:
            if Auth.shared.isLoggedIn() {
                Auth.shared.logout()
                showAlert("You have been logged out")
                reload()
            } else {
                showLogin(with: self)
            }
        case .changePassword:
            if Auth.shared.isLoggedIn() {
                let changePassViewController = ViewControllerFactory.viewControllerFromStoryboard(.changePassword) as! ChangePasswordViewController
                navigationController?.pushViewController(changePassViewController, animated: true)
            }
        }
    }
    
    fileprivate func reload() {
        if let name = Auth.shared.userName(),
            Auth.shared.isLoggedIn() {
            title = name
        } else {
            title = ControllerType.profile.description
        }
        tableView.reloadData()
    }
}

extension ProfileViewController: LoginViewControllerDelegate {
    func didLogin() {
        reload()
    }
}
