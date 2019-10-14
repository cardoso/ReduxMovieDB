//
//  Thunks.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 12/2/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift
import ReSwiftThunk

let fetchMovieGenres = Thunk<MainState> { dispatch, getState in
    TMDB().fetchMovieGenres { result in
        guard let result = result else { return }

        DispatchQueue.main.async {
            dispatch(
                MainStateAction.addGenres(result.genres)
            )
        }
    }
}

fileprivate let fetchNextUpcomingMoviesPage = Thunk<MainState> { dispatch, getState in
    guard
        let state = getState(),
        !state.moviePages.isComplete
    else {
        return
    }

    let page = state.moviePages.currentPage + 1

    TMDB().fetchUpcomingMovies(page: page) { result in
        guard let result = result else { return }

        DispatchQueue.main.async {
            dispatch(
                MainStateAction.fetchNextMoviesPage(
                    totalPages: result.totalPages,
                    movies: result.results
                )
            )
        }
    }
}

fileprivate let fetchSearchMoviesPage = Thunk<MainState> { dispatch, getState in
    guard
        let state = getState(),
        !state.moviePages.isComplete,
        case let .searching(query) = state.search,
        !query.isEmpty
    else {
        return
    }

    let page = state.moviePages.currentPage + 1

    TMDB().searchMovies(query: query, page: page) { result in
        guard let result = result else { return }

        DispatchQueue.main.async {
            dispatch(
                MainStateAction.fetchNextMoviesPage(
                    totalPages: result.totalPages,
                    movies: result.results
                )
            )
        }
    }
}

let fetchMoviesPage = Thunk<MainState> { dispatch, getState in
    guard let state = getState() else { return }

    if case .searching = state.search {
        dispatch(fetchSearchMoviesPage)
    } else {
        dispatch(fetchNextUpcomingMoviesPage)
    }
}

let fetchContributors = Thunk<MainState> { dispatch, getState in
    guard let state = getState() else { return }

    DispatchQueue.main.async {
        if let path = Bundle.main.path(forResource: "contributors", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let contributors = try JSONDecoder().decode([Contributor].self, from: data)
                dispatch(MainStateAction.addContributors(contributors))
            } catch _ {
                dispatch(MainStateAction.addContributors([]))
            }
        }
    }
}
