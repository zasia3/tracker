//
//  AuthProtectedViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 29.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Auth

/* common features of view controllers which can present login view controller */
protocol AuthProtectedViewController: class {
    func showLogin(with delegate: LoginViewControllerDelegate)
}

/* for the instances of UIViewController that implement this protocol */
extension AuthProtectedViewController where Self: UIViewController {
    
    /* default implementation of the showLogin function */
    func showLogin(with delegate: LoginViewControllerDelegate) {
        guard  !Auth.shared.isLoggedIn() else { return }
        
        let loginViewController = ViewControllerFactory.viewControllerFromStoryboard(.login) as! LoginViewController
        loginViewController.delegate = delegate
        loginViewController.modalPresentationStyle = .overCurrentContext
        present(loginViewController, animated: false, completion: nil)
    }
}
