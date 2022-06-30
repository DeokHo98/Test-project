//
//  TrendingModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

// MARK: - TrendingModel
struct KeywordModel: Decodable {
    var data: [String]
}

extension KeywordModel {
    static let EMPTY = KeywordModel(data: [])
}
