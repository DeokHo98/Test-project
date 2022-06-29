//
//  TrendingModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

// MARK: - TrendingModel
struct TrendingKeyWordModel: Decodable {
    var data: [String]
}

extension TrendingKeyWordModel {
    static let EMPTY = TrendingKeyWordModel(data: [])
}
