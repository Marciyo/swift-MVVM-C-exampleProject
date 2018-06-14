//
//  Result.swift
//  confapp
//
//  Created by Majid Jabrayilov on 1/26/18.
//  Copyright © 2018 SNOWDOG. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {
    var value: T? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }

    var error: Error? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}

extension Result {
    func map<V>(_ transform: (T) -> V) -> Result<V> {
        return flatMap { .success(transform($0)) }
    }

    func flatMap<V>(_ transform: (T) -> Result<V>) -> Result<V> {
        switch self {
        case let .success(value): return transform(value)
        case let .failure(error): return .failure(error)
        }
    }
}
