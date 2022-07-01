//
//  PropertyWrapper.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 1.07.22.
//

import UIKit
import SwiftKeychainWrapper

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    
    var wrappedValue: T? {
        get {
            UserDefaults.standard.value(forKey: self.key) as? T
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: self.key)
        }
    }
    
    init(key: String) {
        self.key = key
    }
}

@propertyWrapper
struct KeychainWrapperMod<T> {
    private let key: String
    
    var wrappedValue: T? {
        get {
            KeychainWrapper.standard.string(forKey: self.key) as? T
        }
        set {
            KeychainWrapper.standard.set("\(newValue!)", forKey: self.key)
        }
    }
    
    init(key: String) {
        self.key = key
    }
}
