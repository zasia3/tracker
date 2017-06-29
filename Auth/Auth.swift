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
        static let UserName = "JourneysUserName"
        static let UserPassword = "JourneysUserPassword"
    }
    
    public static let shared = Auth()
    
    public func login(email: String, password: String) ->Bool {
        if let storedEmail = KeychainWrapper.standard.string(forKey: Keys.UserName),
            let storedPassword = KeychainWrapper.standard.string(forKey: Keys.UserPassword),
            storedEmail == email,
            storedPassword == password {
                setLoggedIn()
                return true
        }
        return false
    }

    public func register(email: String, password: String) -> Bool {
        KeychainWrapper.standard.set(email, forKey: Keys.UserName)
        KeychainWrapper.standard.set(password, forKey: Keys.UserPassword)
        setLoggedIn()
        return true
    }
    
    public func changePassword(_ password: String) {
        KeychainWrapper.standard.set(password, forKey: Keys.UserPassword)
    }
    
    public func setLoggedIn() {
        KeychainWrapper.standard.set(1, forKey: Keys.Authorized)
    }
    
    public func logout() {
        KeychainWrapper.standard.removeObject(forKey: Keys.Authorized)
    }
    
    public func isLoggedIn() -> Bool {
        return KeychainWrapper.standard.bool(forKey: Keys.Authorized) ?? false
    }
    public func userName() -> String? {
        return KeychainWrapper.standard.string(forKey: Keys.UserName)
    }
}
