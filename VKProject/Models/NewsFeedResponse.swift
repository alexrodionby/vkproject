//
//  NewsFeedResponse.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 8.07.22.
//

import Foundation

// MARK: - NewsFeedJSON
struct NewsFeedJSON: Codable {
    let response: NewsFeedResponse
}

// MARK: - Response
struct NewsFeedResponse: Codable {
    let items: [Post]
    let groups: [Group]
    let profiles: [Profile]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

// MARK: - ResponseItem
struct Post: Codable {
    let donut: Donut?
    let isFavorite, canSetCategory: Bool?
    let comments: Comments?
    let shortTextRate: Double?
    let likes: PostLikes?
    let reposts: Reposts?
    let type: String
    let postType: String?
    let date, sourceID: Int
    let text: String?
    let canDoubtCategory: Bool?
    let attachments: [Attachment]?
    let markedAsAds: Int?
    let postID: Int?
    let postSource: PostSource?
    let views: Views?
    let photos: Photos?
    let carouselOffset: Int?

    enum CodingKeys: String, CodingKey {
        case donut
        case isFavorite = "is_favorite"
        case canSetCategory = "can_set_category"
        case comments
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case postSource = "post_source"
        case views, photos
        case carouselOffset = "carousel_offset"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: Photo?
    let event: Event?
}

// MARK: - Event
struct Event: Codable {
    let time, id: Int
    let isFavorite: Bool
    let buttonText: String
    let friends: [Int]
    let text: String
    let memberStatus: Int

    enum CodingKeys: String, CodingKey {
        case time, id
        case isFavorite = "is_favorite"
        case buttonText = "button_text"
        case friends, text
        case memberStatus = "member_status"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let albumID: Int
    let postID: Int?
    let id, date: Int
    let text: String
    let userID: Int?
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let accessKey: String

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - PurpleLikes
struct PostLikes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
    let items: [PhotosItem]
}

// MARK: - PhotosItem
struct PhotosItem: Codable {
    let id: Int
    let comments: Views
    let likes: FluffyLikes?
    let accessKey: String
    let userID: Int?
    let reposts: Reposts
    let date, ownerID: Int
    let postID: Int?
    let text: String
    let canRepost: Int
    let sizes: [Size2]
    let hasTags: Bool
    let albumID, canComment: Int

    enum CodingKeys: String, CodingKey {
        case id, comments, likes
        case accessKey = "access_key"
        case userID = "user_id"
        case reposts, date
        case ownerID = "owner_id"
        case postID = "post_id"
        case text
        case canRepost = "can_repost"
        case sizes
        case hasTags = "has_tags"
        case albumID = "album_id"
        case canComment = "can_comment"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - FluffyLikes
struct FluffyLikes: Codable {
    let count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Profile
struct Profile: Codable {
    let online: Int
    let canAccessClosed, isClosed: Bool?
    let id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo?
    let sex: Int
    let screenName, firstName: String?

    enum CodingKeys: String, CodingKey {
        case online
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let appID: Int?
    let isMobile: Bool?
    let lastSeen: Int?
    let isOnline, visible: Bool?

    enum CodingKeys: String, CodingKey {
        case appID = "app_id"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case visible
    }
}
