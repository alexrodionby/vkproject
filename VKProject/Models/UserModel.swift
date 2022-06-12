//
//  UserModel.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 28.05.22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userModel = try? newJSONDecoder().decode(UserModel.self, from: jsonData)

import Foundation

// MARK: - UserModel
struct UserResponse: Codable {
    let response: [UserModel]?
}

// MARK: - Response
struct UserModel: Codable {
    let id: Int?
    let bdate: String?
    let city, country: City2?
    let photo200: String?
    let photoID, about: String?
    let online: Int?
    let firstName, lastName: String?
    let canAccessClosed, isClosed: Bool?

    enum CodingKeys: String, CodingKey {
        case id, bdate, city, country
        case photo200 = "photo_200"
        case photoID = "photo_id"
        case about, online
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

// MARK: - City
struct City2: Codable {
    let id: Int?
    let title: String?
}
