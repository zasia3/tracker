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
            showAlert("You have been successfully logged in", with: { [weak self] _ in
                self?.dismissLoginView()
            })
        } else {
            showAlert("Could not log in. Please check your credentials")
        }
        
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        let registrationViewController = ViewControllerFactory.viewControllerFromStoryboard(.register) as! RegistrationViewController
        registrationViewController.delegate = self
        registrationViewController.modalPresentationStyle = .overCurrentContext
        present(registrationViewController, animated: true, completion: nil)
    }
    
    @objc private func didTap() {
        view.endEditing(true)
    }

    private func loginWithTouchId(){
        guard context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return
        }
        
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
            if success {
                print("Auth was OK")
                Auth.shared.setLoggedIn()
                self?.dismissLoginView()
            } else {
                print("Error received: \(String(describing: error))")
            }
        }
    }
    
    fileprivate func dismissLoginView() {
        dismiss(animated: true, completion: nil)
        delegate?.didLogin()
    }
    
}

extension LoginViewController: RegistrationViewControllerDelegate {
    func didRegister() {
        dismissLoginView()
    }
}
