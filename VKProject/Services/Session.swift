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

    lazy var tokenDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter
    }()
    
    var expiresIn: String { //86400
        get {
            return UserDefaults.standard.string(forKey: "expiresIn") ?? ""
        }
        set {
            //Объект даты -> Строковую дату
            let tokenDate = Date(timeIntervalSinceNow: Double(newValue) ?? 0)
            let tokenDateString = tokenDateFormatter.string(from: tokenDate)
            UserDefaults.standard.set(tokenDateString, forKey: "expiresIn")
        }
    }
    
    var isValid: Bool {

        //Строковая дата -> объект даты
        guard let tokenDate = tokenDateFormatter.date(from: expiresIn) else { return false }
        let currentDate = Date()
        print("tokenDate = ",tokenDate)
        print("currentDate = ", currentDate)
        return currentDate < tokenDate && !token!.isEmpty
    }
}
