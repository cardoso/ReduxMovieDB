//
//  MovieListViewState.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

struct MovieListViewState: Equatable {
    let movies: [Movie]
    let searchBarText: String
    let searchBarShowsCancel: Bool
    let searchBarFirstResponder: Bool

    init(_ state: MainState) {
        movies = state.movies

        switch state.search {
        case .canceled:
            searchBarText = ""
            searchBarShowsCancel = false
            searchBarFirstResponder = false
        case .ready:
            searchBarText = ""
            searchBarShowsCancel = true
            searchBarFirstResponder = true
        case .searching(let text):
            searchBarText = text
            searchBarShowsCancel = true
            searchBarFirstResponder = true

        }
    }
}
