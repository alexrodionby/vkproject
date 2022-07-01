//
//  Session.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 27.05.22.
//

import Foundation
import SwiftKeychainWrapper

final class Session {
    
    private init() {}
    static let shared = Session()
    
    @KeychainWrapperMod(key: "token") var token: String?
    
//    var token: String {
//        get {
//            return KeychainWrapper.standard.string(forKey: "token") ?? ""
//        }
//        set {
//            KeychainWrapper.standard.set(newValue, forKey: "token")
//        }
//    }
    
    @UserDefault(key: "userId") var userId: Int?
    
    
//    var userId: Int {
//        get {
//            return UserDefaults.standard.integer(forKey: "userId")
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "userId")
//        }
//    }
    
    @UserDefault(key: "expiresIn") var expiresIn: Int?
    
//    var expiresIn: Int {
//        get {
//            return UserDefaults.standard.integer(forKey: "expiresIn")
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "expiresIn")
//        }
//    }
    
    static var isValid: Bool {
        
        var expiresIn = UserDefaults.standard.integer(forKey: "expiresIn")
        
        print(expiresIn)
        
        guard expiresIn > 0 else { return false }
            
        //UTC
        var tokenDate = Date(timeIntervalSinceNow: Double(expiresIn))
        var currentDate = Date()
        print("tokenDate",tokenDate)
        print("currentDate", currentDate)
        
        return (currentDate < tokenDate)
    }
    var showLoginScreen: Bool = true
}
