//
//  VideoModel.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 19.07.22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let videoGet = try? newJSONDecoder().decode(VideoGet.self, from: jsonData)

import Foundation

// MARK: - VideoGet
struct VideoResponse: Codable {
    let response: VideoItem?
}

// MARK: - Response
struct VideoItem: Codable {
    let count: Int?
    let items: [VideoModel]?
}

// MARK: - Item
struct VideoModel: Codable {
    let addingDate, canComment, canLike, canRepost: Int?
    let canSubscribe, canAddToFaves, canAdd, comments: Int?
    let date: Int?
    let itemDescription: String?
    let duration: Int?
    let image, firstFrame: [FirstFrame]?
    let width, height, id, ownerID: Int?
    let ovID, titleVideo: String?
    let isFavorite: Bool?
    let player: String?
    let added, itemRepeat: Int?
    let type: String?
    let views: Int?
    let likes: Likes?
    let reposts: Reposts1?

    enum CodingKeys: String, CodingKey {
        case addingDate = "adding_date"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case itemDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case ovID = "ov_id"
        case titleVideo = "title"
        case isFavorite = "is_favorite"
        case player, added
        case itemRepeat = "repeat"
        case type, views, likes, reposts
    }
}

// MARK: - FirstFrame
struct FirstFrame: Codable {
    let url: String?
    let width, height, withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case url, width, height
        case withPadding = "with_padding"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts1: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}
