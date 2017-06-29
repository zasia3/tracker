//
//  Auth.swift
//  Tracker
//
//  Created by MacBook Pro on 28.06.2017.
//  Copyright © 2017 Joanna Zatorska. All rights reserved.
//

import Foundation
import Keychain


/* very basic login functionality
 * using keychain where I store user data
 */
final public class Auth {
    
    /* these are the keys for properties stored in keychain */
    private struct Keys {
        static let Authorized = "JourneysAuthorized"
        static let UserName = "JourneysUserName"
        static let UserPassword = "JourneysUserPassword"
    }
    
    public static let shared = Auth() //singleton
    
    /* during login I check if the provided credentials match to those stored in the keychain */
    public func login(email: String, password: String) ->Bool {
        if let storedEmail = KeychainWrapper.standard.string(forKey: Keys.UserName),
            let storedPassword = KeychainWrapper.standard.string(forKey: Keys.UserPassword),
            storedEmail == email,
            storedPassword == password {
            
                /* if they match - set the logged in flag in keychain */
                setLoggedIn()
                return true
        }
        return false
    }

    /* during registering I just store user credentials in the keychain */
    public func register(email: String, password: String) -> Bool {
        KeychainWrapper.standard.set(email, forKey: Keys.UserName)
        KeychainWrapper.standard.set(password, forKey: Keys.UserPassword)
        setLoggedIn()
        return true
    }
    
    public func changePassword(_ password: String) {
        KeychainWrapper.standard.set(password, forKey: Keys.UserPassword)
    }
    
    /* set the logged in flag in keychain */
    public func setLoggedIn() {
        KeychainWrapper.standard.set(1, forKey: Keys.Authorized)
    }
    
    /* remove the logged in flag in keychain */
    public func logout() {
        KeychainWrapper.standard.removeObject(forKey: Keys.Authorized)
    }
    /* check the logged in flag in keychain - if it is set, then the user is logged in */
    public func isLoggedIn() -> Bool {
        return KeychainWrapper.standard.bool(forKey: Keys.Authorized) ?? false
    }
    
    public func userName() -> String? {
        return KeychainWrapper.standard.string(forKey: Keys.UserName)
    }
}
