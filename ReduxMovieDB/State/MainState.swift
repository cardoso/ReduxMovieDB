//
//  MainState.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift
import ReSwiftThunk

enum SearchState: Equatable {
    case canceled
    case ready
    case searching(String)
}

enum MovieDetailState: Equatable {
    case willHide(Movie)
    case hide
    case show(Movie)

    var movie: Movie? {
        switch self {
        case .willHide(let movie):
            return movie
        case .hide:
            return nil
        case .show(let movie):
            return movie
        }
    }
}

struct MainState: StateType, Equatable {
    var genres: [Genre] = []
    var moviePages: Pages<Movie> = Pages<Movie>()

    var movieDetail: MovieDetailState = .hide

    var search: SearchState = .canceled

    var movies: [Movie] {
        return moviePages.values
    }
}

func mainReducer(action: Action, state: MainState?) -> MainState {
    var state = state ?? MainState()

    guard let action = action as? MainStateAction else {
        return state
    }

    switch action {
    case .addGenres(let genres):
        state.genres.append(contentsOf: genres)

    case .fetchNextMoviesPage(let totalPages, let movies):
        // TMDB API is returning duplicates...
        let values = movies.filter({ movie in !state.movies.contains(where: { $0.id == movie.id }) })
        state.moviePages.addPage(totalPages: totalPages, values: values)


    case .willHideMovieDetail(let movie):
        state.movieDetail = .willHide(movie)
    case .hideMovieDetail:
        state.movieDetail = .hide
    case .showMovieDetail(let movie):
        state.movieDetail = .show(movie)

    case .cancelSearch:
        state.moviePages = Pages<Movie>()
        state.search = .canceled
    case .readySearch:
        state.moviePages = Pages<Movie>()
        state.search = .ready
    case .search(let query):
        state.moviePages = Pages<Movie>()
        state.search = .searching(query)
    }

    return state
}

let thunksMiddleware: Middleware<MainState> = createThunksMiddleware()

let mainStore = Store(
    reducer: mainReducer,
    state: MainState(),
    middleware: [thunksMiddleware]
)
