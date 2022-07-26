//
//  GroupsEndpoint.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 23.07.22.
//

import Foundation

enum GroupsEndpoint: Endpoint {
    
    //Все запросы модуля Groups
    case fetchGroups(offset: Int)
    case searchGroups(searchString: String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseUrl: String {
        switch self {
        default:
            return "api.vk.com"
        }
    }
    
    var path: String {
        switch self {
            
        case .fetchGroups:
            return "/method/groups.get"
        case .searchGroups:
            return "/method/groups.search"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchGroups(offset: let offset):
            return  [
                URLQueryItem(name: "user_ids", value: "\(Session.shared.userId!)"),
                URLQueryItem(name: "extended", value: "10"),
                URLQueryItem(name: "fields", value: "city,country,description,members_count,site"),
                URLQueryItem(name: "count", value: "10"),
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
        case .searchGroups(searchString: let searchString):
            return  [
                URLQueryItem(name: "user_ids", value: "\(Session.shared.userId!)"),
                URLQueryItem(name: "count", value: "1"),
                URLQueryItem(name: "q", value: "\(searchString)"),
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
        }
    }
    
    var method: String {
        switch self {
        case .fetchGroups:
            return "GET"
        case .searchGroups:
            return "GET"
        }
    }
}
