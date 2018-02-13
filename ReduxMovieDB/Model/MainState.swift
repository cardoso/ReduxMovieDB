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

    case fetchNextUpcomingMoviesPage(totalPages: Int, movies: [Movie])
    case fetchNextSearchedMoviesPage(totalPages: Int, movies: [Movie])

    case selectMovieIndex(Int)
    case deselectMovie

    case showMovieDetail
    case hideMovieDetail

    case setSearchQuery(String)
}

struct MainState: StateType {
    var genres: [Genre] = []
    var moviePages: Pages<Movie> = Pages<Movie>()
    var searchedMoviePages: Pages<Movie> = Pages<Movie>()

    var selectedMovieIndex: Int?
    var showMovieDetail: Bool = false

    var searchQuery: String = ""

    var movies: [Movie] {
        return moviePages.values
    }

    var searchedMovies: [Movie] {
        return searchedMoviePages.values
    }

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

func appReducer(action: Action, state: MainState?) -> MainState {
    var state = state ?? MainState()

    guard let action = action as? MainStateAction else {
        return state
    }

    switch action {
    case .addGenres(let genres):
        state.genres.append(contentsOf: genres)

    case .fetchNextUpcomingMoviesPage(let totalPages, let movies):
        // TMDB API is returning duplicates...
        let values = movies.filter({ movie in !state.movies.contains(where: { $0.id == movie.id }) })
        state.moviePages.addPage(totalPages: totalPages, values: values)

    case .fetchNextSearchedMoviesPage(let totalPages, let movies):
        state.searchedMoviePages.addPage(totalPages: totalPages, values: movies)

    case .selectMovieIndex(let index):
        guard index < state.movies.count else { break }
        state.selectedMovieIndex = index
    case .deselectMovie:
        state.selectedMovieIndex = nil

    case .showMovieDetail:
        state.showMovieDetail = true
    case .hideMovieDetail:
        state.showMovieDetail = false

    case .setSearchQuery(let query):
        state.searchedMoviePages = Pages<Movie>()
        state.searchQuery = query
    }

    return state
}

let mainStore = Store(
    reducer: appReducer,
    state: MainState(),
    middleware: []
)
