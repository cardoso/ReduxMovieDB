//
//  Thunk.swift
//  ReSwift-Thunk
//
//  Created by Daniel Martín Prieto on 01/11/2018.
//  Copyright © 2018 ReSwift. All rights reserved.
//

import Foundation
import ReSwift

public struct Thunk<State>: Action {
    let body: (_ dispatch: @escaping DispatchFunction, _ getState: @escaping () -> State?) -> Void
    public init(body: @escaping (
        _ dispatch: @escaping DispatchFunction,
        _ getState: @escaping () -> State?) -> Void) {
        self.body = body
    }
}

@available(*, deprecated, renamed: "Thunk")
typealias ThunkAction = Thunk
