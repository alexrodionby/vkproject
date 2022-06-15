//
//  GroupsModel.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 3.06.22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let groupsResponse = try? newJSONDecoder().decode(GroupsResponse.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - GroupsResponse
struct GroupsResponse: Codable {
    let response: GroupsItem?
}

// MARK: - Response
struct GroupsItem: Codable {
    let count: Int?
    let items: [GroupDAO]?
}

// MARK: - Item
@objcMembers
//DAO - Data access object
class GroupDAO: Object, Codable {
    
    dynamic var groupId: Int?
    dynamic var itemDescription: String?
    dynamic var name: String?
    dynamic var photo200: String?
    
  

    let membersCount: Int?
    let site: String?
    let screenName: String?
    let isClosed: Int?
    let type: TypeEnum?
    let photo50, photo100: String?
    let country, city: City3?

    enum CodingKeys: String, CodingKey {
        case groupId = "id"
        case itemDescription = "description"
        case membersCount = "members_count"
        case site, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
        case country, city
    }
}

// MARK: - City
struct City3: Codable {
    let id: Int?
    let title: String?
}

enum TypeEnum: String, Codable {
    case page = "page"
}
