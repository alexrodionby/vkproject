//
//  Friends.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 27.05.22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let friends = try? newJSONDecoder().decode(Friends.self, from: jsonData)

import Foundation

// MARK: - Friends
struct FriendsResponse: Codable {
    let response: FriendsItems?
}

// MARK: - Response
struct FriendsItems: Codable {
    let count: Int?
    let items: [FriendModel]?
}

// MARK: - Item
struct FriendModel: Codable {
    let id: Int?
    let city: City?
    let trackCode: String?
    let photo100: String?
    let online: Int?
    let firstName, lastName: String?
    let canAccessClosed, isClosed: Bool?
    let lists: [Int]?
    let onlineMobile, onlineApp: Int?

    enum CodingKeys: String, CodingKey {
        case id, city
        case trackCode = "track_code"
        case photo100 = "photo_100"
        case online
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case lists
        case onlineMobile = "online_mobile"
        case onlineApp = "online_app"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let title: String?
}
