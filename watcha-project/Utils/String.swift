//
//  String.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
