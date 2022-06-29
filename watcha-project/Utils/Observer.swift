//
//  Observable.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

final class Observer<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    func bind(completion: @escaping (T) -> Void) {
        self.listener = completion
    }
    init(value: T) {
        self.value = value
    }
}
