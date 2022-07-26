//
//  FriendsEndpoint.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 22.07.22.
//
import Foundation

enum FriendsEndpoint: Endpoint {
    //Все запросы модуля Friends
    case fetchFriends(offset: Int)
    case searchFriends(searchString: String)
    
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
        case .fetchFriends:
            return "/method/friends.get"
        case .searchFriends:
            return "/method/friends.search"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchFriends(offset: let offset):
            return  [URLQueryItem(name: "user_id", value: "\(Session.shared.userId ?? 0)"),
                     URLQueryItem(name: "order", value: "random"),
                     URLQueryItem(name: "count", value: "20"),
                     URLQueryItem(name: "fields", value: "online, city, photo_100, country, contacts, bdate"),
                     URLQueryItem(name: "offset", value: "\(offset)"),
                     URLQueryItem(name: "access_token", value: Session.shared.token),
                     URLQueryItem(name: "v", value: "5.131")]
        case .searchFriends(searchString: let searchString):
            return  [
                URLQueryItem(name: "user_id", value: "\(Session.shared.userId ?? 0)"),
                URLQueryItem(name: "count", value: "1"),
                URLQueryItem(name: "q", value: "\(searchString)"),
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
        }
    }
    
    var method: String {
        switch self {
        case .fetchFriends:
            return "GET"
        case .searchFriends:
            return "GET"
        }
    }
}
