//
//  ServiceError.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

enum ServiceError: Error {
    case URLError
    case fetchError
    case dataError
    case responseError
    case jsonDecodeError
}
