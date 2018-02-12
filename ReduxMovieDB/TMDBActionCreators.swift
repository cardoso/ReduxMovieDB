//
//  TMDBActionCreators.swift
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


func fetchNextUpcomingMoviesPage(state: MainState, store: Store<MainState>) -> Action? {
    if state.moviePages.isComplete { return nil }

    TMDB().fetchUpcomingMovies(page: mainStore.state.moviePages.currentPage + 1) { result in
        guard let result = result else { return }

        print(result)

        DispatchQueue.main.async {
            mainStore.dispatch(
                MainStateAction.fetchNextUpcomingMoviesPage(
                    totalPages: result.totalPages,
                    movies: result.results
                )
            )
        }
    }

    return nil
}
