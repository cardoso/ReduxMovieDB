//
//  ActionCreators.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/12/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift

func fetchMovieGenres(state: MainState, store: Store<MainState>) -> Action? {
    TMDB().fetchMovieGenres { result in
        guard let result = result else { return }

        DispatchQueue.main.async {
            mainStore.dispatch(
                MainStateAction.addGenres(result.genres)
            )
        }
    }

    return nil
}


fileprivate func fetchNextUpcomingMoviesPage(state: MainState, store: Store<MainState>) -> Action? {
    guard !state.moviePages.isComplete else { return nil }

    TMDB().fetchUpcomingMovies(page: mainStore.state.moviePages.currentPage + 1) { result in
        guard let result = result else { return }

        DispatchQueue.main.async {
            mainStore.dispatch(
                MainStateAction.fetchNextMoviesPage(
                    totalPages: result.totalPages,
                    movies: result.results
                )
            )
        }
    }

    return nil
}

fileprivate func fetchSearchMoviesPage(state: MainState, store: Store<MainState>) -> Action? {
    guard
        !state.moviePages.isComplete,
        case let .searching(query) = state.search,
        !query.isEmpty
    else {
        return nil
    }

    let page = mainStore.state.moviePages.currentPage + 1

    TMDB().searchMovies(query: query, page: page) { result in
        guard let result = result else { return }

        DispatchQueue.main.async {
            mainStore.dispatch(
                MainStateAction.fetchNextMoviesPage(
                    totalPages: result.totalPages,
                    movies: result.results
                )
            )
        }
    }

    return nil
}

func fetchMoviesPage(state: MainState, store: Store<MainState>) -> Action? {
    if case .searching = mainStore.state.search {
        return fetchSearchMoviesPage(state: state, store: store)
    } else {
        return fetchNextUpcomingMoviesPage(state: state, store: store)
    }
}
