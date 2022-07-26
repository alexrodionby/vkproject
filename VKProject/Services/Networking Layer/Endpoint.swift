//
//  Endpoint.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 22.07.22.
//

import Foundation

protocol Endpoint {
    
    // https
    var scheme: String { get }
    
    // api.vk.com
    var baseUrl: String { get }
    
    // /method/friends.get
    var path: String { get }
    
    // parameters
    var parameters: [URLQueryItem] { get }
    
    //GET
    var method: String { get }
}
