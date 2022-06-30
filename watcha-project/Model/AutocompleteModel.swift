//
//  AutocompleteModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import Foundation

// MARK: - AutocompleteModel
struct AutocompleteModel: Codable {
    let data: [AutocompleteDatum]
}

// MARK: - Datum
struct AutocompleteDatum: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}

