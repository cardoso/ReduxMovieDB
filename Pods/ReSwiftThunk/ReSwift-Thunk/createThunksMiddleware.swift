//
//  createThunksMiddleware.swift
//  ReSwift-Thunk
//
//  Created by Daniel Martín Prieto on 02/11/2018.
//  Copyright © 2018 ReSwift. All rights reserved.
//

import Foundation
import ReSwift

public func createThunksMiddleware<State>() -> Middleware<State> {
    return { dispatch, getState in
        return { next in
            return { action in
                switch action {
                case let thunk as Thunk<State>:
                    thunk.body(dispatch, getState)
                default:
                    next(action)
                }
            }
        }
    }
}

// swiftlint:disable identifier_name
@available(*, deprecated, renamed: "createThunksMiddleware")
func ThunkMiddleware<State: StateType>() -> Middleware<State> {
    return createThunksMiddleware()
}
// swiftlint:enable identifier_name
