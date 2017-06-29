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
        
        guard let email = emailField.text,
            !email.isEmpty,
            let password = passwordField.text,
            !password.isEmpty,
            let passwordConfirmation = passwordConfirmationField.text,
            !passwordConfirmation.isEmpty else {
                showAlert("All fields must be filled in")
                return
        }
        
        guard email.isValidEmail() else {
            showAlert("Invalid password format!")
            return
        }
        
        guard password.characters.count >= 8 else {
            showAlert("Password must have at least 8 characters")
            return
        }
        
        guard password == passwordConfirmation else {
            showAlert("Password and confirmation do not match")
            return
        }
        
        if Auth.shared.register(email: email, password: password) {
            showAlert("You have been successfully registered and logged in", with: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
                self?.delegate?.didRegister()
            })
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTap() {
        view.endEditing(true)
    }
}
