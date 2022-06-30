//
//  MostPopularModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation




// MARK: - GIFModel

struct GIFModel: Decodable {
    let data: [Datum]
    let pagination: Pagination
}

// MARK: - Datum

struct Datum: Decodable {
    let id: String
    let url: String
    let username: String
    let images: Images
    let user: User?
    enum CodingKeys: String, CodingKey {
        case id, url
        case username
        case images, user
     
    }
}

// MARK: - Images

struct Images: Decodable {
    let fixedWidthStill: The480_WStill
    enum CodingKeys: String, CodingKey {
        case fixedWidthStill = "fixed_width_still"
    }
}

// MARK: - The480_WStill

struct The480_WStill: Codable {
    let height, width, size: String
    let url: String
}

// MARK: - User

struct User: Decodable {
    let avatarURL, bannerImage, bannerURL: String
    let profileURL: String
    let username, displayName, userDescription: String
    let instagramURL: String
    let websiteURL: String
    let isVerified: Bool

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerImage = "banner_image"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
        case userDescription = "description"
        case instagramURL = "instagram_url"
        case websiteURL = "website_url"
        case isVerified = "is_verified"
    }
}

// MARK: - Pagination

struct Pagination: Decodable {
    let totalCount, count, offset: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}
