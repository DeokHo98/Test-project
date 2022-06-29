//
//  Observable.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

final class Observable<T> {    
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T) {
        self.value = value
    }
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
