//
//  Session.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 27.05.22.
//

import Foundation

final class Session {
    
    private init() {}
    static let shared = Session()
    var token: String = ""
    var userId: String = ""
    var expiresIn: String = ""
    var showLoginScreen: Bool = true
}
