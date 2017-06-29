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
import iOSKit

protocol LoginViewControllerDelegate: class {
    func didLogin()
}

/* simple login form, with very basic auth functionality
 * user can login using email and password 
 * or he can use touch id - if he forgets the credentials, or just want to be quick
 */
final class LoginViewController: UIViewController, AlertProtocol {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    private let context: LAContext = LAContext()
    private let reason = "Please authenticate using TouchID"
    private var error: NSError?
    
    private var success:Bool = false
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
    }
    
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
    
    /* when user taps login - it is necessary to validate the fields
     * check if both are filled in and present message with the validation errors
     */
    
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
        
        
        if Auth.shared.login(email: email, password: password) {
            
            /* when user is logged in - I show the confirmation 
             * and when user taps ok on the alert the view controller is dismissed
             */
            showAlert("You have been successfully logged in", with: { [weak self] _ in
                self?.dismissLoginView()
            })
        } else {
            /* if something went wrong - show error alert */
            showAlert("Could not log in. Please check your credentials")
        }
        
    }
    
    /* open registration field */
    @IBAction func didTapRegister(_ sender: Any) {
        let registrationViewController = ViewControllerFactory.viewControllerFromStoryboard(.register) as! RegistrationViewController
        registrationViewController.delegate = self
        
        /* I am changing the presentation style, because the modal should not cover the tab bar */
        registrationViewController.modalPresentationStyle = .overCurrentContext
        present(registrationViewController, animated: true, completion: nil)
    }
    
    /* hide the keyboard whe user taps the screen */
    @objc private func didTap() {
        view.endEditing(true)
    }

    /* this is a standard login using touch id */
    private func loginWithTouchId(){
        
        /* allow for the touch id login only if there is already a user registered */
        guard Auth.shared.userName() != nil else { return }
        
        guard context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return
        }
        
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
            if success {
                Auth.shared.setLoggedIn()
                self?.dismissLoginView()
            } else {
                print("Error received: \(String(describing: error))")
            }
        }
    }
    
    fileprivate func dismissLoginView() {
        dismiss(animated: true, completion: nil)
        
        /* after log in I need to notify the delegate - I dispatch it on the main thread */
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didLogin()
        }
    }
    
}

extension LoginViewController: RegistrationViewControllerDelegate {
    func didRegister() {
        dismissLoginView()
    }
}
