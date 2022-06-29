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
    let fixedWidth: FixedHeight


    enum CodingKeys: String, CodingKey {
        case fixedWidth = "fixed_width"
    }
}


// MARK: - FixedHeight

struct FixedHeight: Decodable {
    let height, width, size: String
    let url: String
    let mp4Size: String?
    let mp4: String?
    let webpSize: String
    let webp: String
    let frames, hash: String?

    enum CodingKeys: String, CodingKey {
        case height, width, size, url
        case mp4Size = "mp4_size"
        case mp4
        case webpSize = "webp_size"
        case webp, frames, hash
    }
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
