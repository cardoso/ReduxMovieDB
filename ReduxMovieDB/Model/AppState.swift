//
//  AppState.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift

enum AppStateAction: Action {
    case addGenres([Genre])
    case addMovies([Movie])
    case selectMovieIndex(Int)
    case deselectMovie
    case showMovieDetail
    case hideMovieDetail
}

struct AppState: StateType {
    var genres: [Genre] = []
    var movies: [Movie] = []
    var selectedMovieIndex: Int?
    var showMovieDetail: Bool = false

    var selectedMovie: Movie? {
        guard
            let selectedMovieIndex = selectedMovieIndex,
            selectedMovieIndex < movies.count
        else {
            return nil
        }

        return movies[selectedMovieIndex]
    }
}

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    guard let action = action as? AppStateAction else {
        return state
    }

    switch action {
    case .addGenres(let genres):
        state.genres.append(contentsOf: genres)
    case .addMovies(let movies):
        state.movies.append(contentsOf: movies)
    case .selectMovieIndex(let index):
        guard index < state.movies.count else { break }
        state.selectedMovieIndex = index
    case .deselectMovie:
        state.selectedMovieIndex = nil
    case .showMovieDetail:
        state.showMovieDetail = true
    case .hideMovieDetail:
        state.showMovieDetail = false
    }

    return state
}

let store = Store(
    reducer: appReducer,
    state: AppState(),
    middleware: []
)
