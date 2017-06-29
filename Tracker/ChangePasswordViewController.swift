//
//  ChangePasswordViewController.swift
//  Tracker
//
//  Created by MacBook Pro on 29.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Auth
import iOSKit

final class ChangePasswordViewController: UIViewController, AlertProtocol {
    
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func didTapChangePassword(_ sender: Any) {
        guard let password = confirmPasswordField.text,
            !password.isEmpty,
            let passwordConfirmation = confirmPasswordField.text,
            !passwordConfirmation.isEmpty else {
                showAlert("All fields must be filled in")
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
        
        Auth.shared.changePassword(password)
        showAlert("Password changed", with: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
    }
    
    @objc private func didTap() {
        view.endEditing(true)
    }
}
