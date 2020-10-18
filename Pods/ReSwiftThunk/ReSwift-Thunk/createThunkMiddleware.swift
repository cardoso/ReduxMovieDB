//
//  createThunkMiddleware.swift
//  ReSwift-Thunk
//
//  Created by Daniel Martín Prieto on 02/11/2018.
//  Copyright © 2018 ReSwift. All rights reserved.
//

import Foundation
import ReSwift

public func createThunkMiddleware<State>() -> Middleware<State> {
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
@available(*, deprecated, renamed: "createThunkMiddleware")
func ThunkMiddleware<State: StateType>() -> Middleware<State> {
    return createThunkMiddleware()
}
// swiftlint:enable identifier_name

@available(*, deprecated, renamed: "createThunkMiddleware")
func createThunksMiddleware<State: StateType>() -> Middleware<State> {
    return createThunkMiddleware()
}
