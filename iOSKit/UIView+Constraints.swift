//
//  UIView+Constraints.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import UIKit

extension UIView {
    
    /* helper function to pin subview anchors to the superview anchors */
    public func fillSuperview() {
        
        /* checking if we are running this method on a subview */
        guard let superView = superview else {
            fatalError("View doesn't have superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
}
