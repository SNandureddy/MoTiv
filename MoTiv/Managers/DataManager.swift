//
//  DataManager.swift
//  KidzWatch
//
//  Created by ios28 on 17/04/18.
//  Copyright © 2018 ios28. All rights reserved.
//

import Foundation

class DataManager {
    
    static var accessToken: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kAccessToken)
            UserDefaults.standard.synchronize()
        }

        get {
            return UserDefaults.standard.string(forKey: APIKeys.kAccessToken)
        }
    }
    
    static var role: Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kRole)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: APIKeys.kRole)
        }
    }
    
    static var userId: Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kId)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: APIKeys.kId)
        }
    }
    
    static var isLoggedIn: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kIsLoggedIn)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: APIKeys.kIsLoggedIn)
        }
    }
    
    static var isFirstTime: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kIsFirstTime)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: APIKeys.kIsFirstTime)
        }
    }
    
    static var userMusicInterests: [String] {
        set {
            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kMusicInterest)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: APIKeys.kMusicInterest) as? [String] ?? [String]()
        }
    }
    
    static var userPublicInterests: [String] {
        set {
            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kPublicInterest)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: APIKeys.kPublicInterest) as? [String] ?? [String]()
        }
    }
}
