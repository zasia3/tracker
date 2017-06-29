//
//  AlertProtocol.swift
//  Tracker
//
//  Created by MacBook Pro on 29.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit

public protocol AlertProtocol  {
    func showAlert(_ message: String)
}

public extension AlertProtocol where Self: UIViewController {
    public func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    public func showAlert(_ message: String, with action: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: action))
        
        present(alert, animated: true, completion: nil)
    }
}
