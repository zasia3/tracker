//
//  Auth.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Keychain

final public class Auth {
    
    private struct Keys {
        static let Authorized = "JourneysAuthorized"
    }
    
    public static let shared = Auth()

    
    public func setLoggedIn() {
        KeychainWrapper.standard.set(1, forKey: Keys.Authorized)
    }
    
    public func logout() {
        KeychainWrapper.standard.removeObject(forKey: Keys.Authorized)
    }
    
    public func isLoggedIn() -> Bool {
        return KeychainWrapper.standard.bool(forKey: Keys.Authorized) ?? false
    }
}
