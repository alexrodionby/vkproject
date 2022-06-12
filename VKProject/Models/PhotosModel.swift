//
//  PhotosModel.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 28.05.22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photos = try? newJSONDecoder().decode(Photos.self, from: jsonData)

import Foundation

// MARK: - Photos
struct PhotosResponse: Codable {
    let response: PhotosItem?
}

// MARK: - Response
struct PhotosItem: Codable {
    let count: Int?
    let items: [PhotosModel]?
    let more: Int?
}

// MARK: - Item
struct PhotosModel: Codable {
    let albumID, date, id, ownerID: Int?
    let sizes: [Size]?
    let text: String?
    let hasTags: Bool?
    let realOffset: Int?
    var averagePhoto: String {
        if let count = self.sizes?.count, count >= 1 {
            if count == 1 {
                return self.sizes?[0].url ?? ""
            }
            let averageIndex = Int((Double(count) / 2).rounded(.up))
            let sizeObject = self.sizes?[averageIndex]
            
            return sizeObject?.url ?? ""
        }
        return ""
    }
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case hasTags = "has_tags"
        case realOffset = "real_offset"
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}

