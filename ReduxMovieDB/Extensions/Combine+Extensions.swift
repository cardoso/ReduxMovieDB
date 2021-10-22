//
//  Combine+Extensions.swift
//  ReduxMovieDB
//
//  Created by Levente Vig on 2021. 10. 22..
//  Copyright © 2021. Matheus Cardoso. All rights reserved.
//

import Combine

public typealias Cancellables = Set<AnyCancellable>

extension Publisher {
    public func sink() -> AnyCancellable {
        sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}

extension Publisher {
    public func unwrap<T>() -> Publishers.CompactMap<Self, T> where Output == T? {
        compactMap { $0 }
    }

    public func unwrap<T>(orThrow error: @escaping @autoclosure () -> Failure) -> Publishers.TryMap<Self, T>
    where Output == T? {
        tryMap { output in
            switch output {
            case .some(let value):
                return value
            case nil:
                throw error()
            }
        }
    }
}

extension Publisher {
    public func toVoid() -> AnyPublisher<(), Failure> {
        map { _ in }.eraseToAnyPublisher()
    }
}

extension Publisher where Output == Bool {
    public func toggle() -> AnyPublisher<Output, Failure> {
        map { !$0 }.eraseToAnyPublisher()
    }
}
