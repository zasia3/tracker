//
//  AuthProtectedViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Auth

protocol AuthProtectedViewController: class {
    
    func showLogin()
}

extension AuthProtectedViewController where Self: UIViewController {
    func showLogin() {
        guard  !Auth.shared.isLoggedIn() else { return }
        let loginViewController = ViewControllerFactory.viewControllerFromStoryboard(.login) as! LoginViewController
        loginViewController.modalPresentationStyle = .overCurrentContext
        present(loginViewController, animated: false, completion: nil)
    }
}
