//
//  RegistrationViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit
import Auth
import iOSKit

protocol RegistrationViewControllerDelegate: class {
    func didRegister()
}

/* simple registration form */
final class RegistrationViewController: UIViewController, AlertProtocol {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmationField: UITextField!
    
    weak var delegate: RegistrationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
    }
    

    @IBAction func didTapRegister(_ sender: Any) {
        
        /* validate the user input before registering */
        guard let email = emailField.text,
            !email.isEmpty,
            let password = passwordField.text,
            !password.isEmpty,
            let passwordConfirmation = passwordConfirmationField.text,
            !passwordConfirmation.isEmpty else {
                showAlert("All fields must be filled in")
                return
        }
        
        /* email must be in the correct format */
        guard email.isValidEmail() else {
            showAlert("Invalid password format!")
            return
        }
        
        /* password must have at least 8 characters */
        guard password.characters.count >= 8 else {
            showAlert("Password must have at least 8 characters")
            return
        }
        
        /* password and confirmation must match */
        guard password == passwordConfirmation else {
            showAlert("Password and confirmation do not match")
            return
        }
        
        if Auth.shared.register(email: email, password: password) {
            showAlert("You have been successfully registered and logged in", with: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
                self?.didRegister()
            })
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTap() {
        view.endEditing(true)
    }
    
    private func didRegister() {
        
        /* after registering I need to notify the delegate - I dispatch it on the main thread */
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didRegister()
        }
    }
}
