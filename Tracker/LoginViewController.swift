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
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

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
    
    @IBAction func didTapLogin(_ sender: Any) {
        guard let email = emailField.text,
            !email.isEmpty,
            let password = passwordField.text,
            !password.isEmpty else {
                showAlert("Both fields must be filled in")
                return
        }
        
        guard email.isValidEmail() else {
            showAlert("Invalid email format!")
            return
        }
        
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        let registrationViewController = ViewControllerFactory.viewControllerFromStoryboard(.register) as! RegistrationViewController
        registrationViewController.modalPresentationStyle = .overCurrentContext
        present(registrationViewController, animated: true, completion: nil)
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    private func loginWithTouchId(){
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
