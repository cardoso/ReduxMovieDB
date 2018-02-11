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
    case selectMovieIndex(Int)
}

struct AppState: StateType {
    var movies: [Movie] = []
    var selectedMovieIndex: Int?
}

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    guard let action = action as? AppStateAction else {
        return state
    }

    switch action {
    case .addMovies(let movies):
        state.movies.append(contentsOf: movies)
    case .selectMovieIndex(let index):
        state.selectedMovieIndex = index
    }

    return state
}

let store = Store(
    reducer: appReducer,
    state: AppState(),
    middleware: []
)
