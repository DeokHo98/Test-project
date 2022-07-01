//
//  APIKey.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

private let APIKey = "api_key=MjCPlYY5U7JKYjuCuWac3SSmrropRpI1"

enum APIURL {

    var url: String {
        switch self {
        case .mostPopular:
            return "https://api.giphy.com/v1/gifs/trending?\(APIKey)&limit=20&rating=g"
        case .trendKeyword:
            return "https://api.giphy.com/v1/trending/searches?\(APIKey)"
        case .autocompleteKeword:
            return "https://api.giphy.com/v1/gifs/search/tags?\(APIKey)&limit=10"
        case .search:
            return "https://api.giphy.com/v1/gifs/search?\(APIKey)&limit=20&rating=g&q="
        }
    }
    case mostPopular
    case trendKeyword
    case autocompleteKeword
    case search
}
