//
//  LoginViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Auth
import LocalAuthentication

final class LoginViewController: UIViewController {

    private let context: LAContext = LAContext()
    private let reason = "Please authenticate using TouchID"
    private var error: NSError?
    
    private var success:Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginWithTouchId()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !success {
            dismiss(animated: true, completion: nil)
        }
    }

    public func loginWithTouchId(){
        guard context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return
        }
        
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
            if success {
                print("Auth was OK")
                Auth.shared.setLoggedIn()
                self?.dismiss(animated: true, completion: nil)
            } else {
                print("Error received: %d", error!)
            }
        }
    }
}
