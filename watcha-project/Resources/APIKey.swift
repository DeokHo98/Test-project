//
//  APIKey.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

struct APIKey {
    static let key = "api_key=MjCPlYY5U7JKYjuCuWac3SSmrropRpI1"
}

enum APIURL {
    var url: String {
        switch self {
        case .mostPopular:
            return "https://api.giphy.com/v1/gifs/trending?\(APIKey.key)&limit=20&rating=g"
        case .trendKeyword:
            return "https://api.giphy.com/v1/trending/searches?\(APIKey.key)"
        case .autocompleteKeword:
            return "https://api.giphy.com/v1/gifs/search/tags?\(APIKey.key)&limit=10"
        case .search:
            return "https://api.giphy.com/v1/gifs/search?\(APIKey.key)&limit=20&rating=g&q="
        }
    }
    case mostPopular
    case trendKeyword
    case autocompleteKeword
    case search
}
