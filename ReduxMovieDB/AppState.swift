//
//  AppState.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift

enum AppStateAction: Action {
    case addMovies([Movie])
}

struct AppState: StateType {
    var movies: [Movie] = []
}

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    guard let action = action as? AppStateAction else {
        return state
    }

    switch action {
    case .addMovies(let movies):
        state.movies.append(contentsOf: movies)
    }

    return state
}

let store = Store(
    reducer: appReducer,
    state: AppState(),
    middleware: []
)
