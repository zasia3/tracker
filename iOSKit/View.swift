//
//  View.swift
//  Tracker
//
//  Created by MacBook Pro on 25.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation

/* this is kind of template/shortcut class for UIViews - so we don't need to repeat the inits */
open class View: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        onInit()
    }
    
    /* this is place for any kind of initialisation
     * we need to do in the implementation classes
     */
    open func onInit() {}
}
