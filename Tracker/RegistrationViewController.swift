//
//  RegistrationViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailConfirmationField: UITextField!
    
    
    @IBAction func didTapRegister(_ sender: Any) {
        
        guard let email = emailField.text,
            !email.isEmpty,
            let password = passwordField.text,
            !password.isEmpty,
            let emailConfirmation = emailConfirmationField.text,
            !emailConfirmation.isEmpty else {
                showAlert("All fields must be filled in")
                return
        }
        
        guard email.isValidEmail() else {
            showAlert("Invalid password format!")
            return
        }
        
        guard password.characters.count > 8 else {
            showAlert("Password must have at least 8 characters")
            return
        }
        
        guard password == emailConfirmation else {
            showAlert("Password and confirmation do not match")
            return
        }
        
        
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
