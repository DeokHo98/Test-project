//
//  TrendingModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

// MARK: - TrendingModel
struct TrendingModel: Decodable {
    var data: [String]
}

extension TrendingModel {
    static let EMPTY = TrendingModel(data: [])
}
