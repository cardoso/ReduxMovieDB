//
//  MainState.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift

enum MainStateAction: Action {
    case addGenres([Genre])

    case fetchNextMoviesPage(totalPages: Int, movies: [Movie])

    case showMovieDetail(Movie)
    case willHideMovieDetail(Movie)
    case hideMovieDetail

    case readySearch
    case search(String)
    case cancelSearch
}

enum SearchState {
    case canceled
    case ready
    case searching(String)
}

enum MovieDetailState {
    case willHide(Movie)
    case hide
    case show(Movie)
}

struct MainState: StateType, Spreadable {
    let genres: [Genre]
    let moviePages: Pages<Movie>
    let movieDetail: MovieDetailState
    let search: SearchState

    static var emptyState: MainState {
        return MainState(
            genres: [],
            moviePages: Pages<Movie>(),
            movieDetail: .hide,
            search: .canceled
        )
    }
}

func mainReducer(action: Action, state: MainState?) -> MainState {
    let state = state ?? .emptyState

    guard let action = action as? MainStateAction else {
        return state
    }

    switch action {
    case .addGenres(let genres):
        return MainState(
            ...state,
            genres: state.genres + genres
        )

    case .fetchNextMoviesPage(let totalPages, let movies):
        let values = movies.filter { movie in
            !state.moviePages.values.contains {
                $0.id == movie.id
            }
        }

        let pages = state.moviePages.addingPage(totalPages: totalPages, values: values)

        return MainState(
            ...state,
            moviePages: pages
        )


    case .willHideMovieDetail(let movie):
        return MainState(
            ...state,
            movieDetail: .willHide(movie)
        )
    case .hideMovieDetail:
        return MainState(
            ...state,
            movieDetail: .hide
        )
    case .showMovieDetail(let movie):
        return MainState(
            ...state,
            movieDetail: .show(movie)
        )

    case .cancelSearch:
        return MainState(
            ...state,
            moviePages: Pages<Movie>(),
            search: .canceled
        )
    case .readySearch:
        return MainState(
            ...state,
            moviePages: Pages<Movie>(),
            search: .ready
        )
    case .search(let query):
        return MainState(
            ...state,
            moviePages: Pages<Movie>(),
            search: .searching(query)
        )
    }
}

let mainStore = Store(
    reducer: mainReducer,
    state: .emptyState,
    middleware: []
)
