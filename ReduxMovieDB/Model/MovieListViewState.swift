//
//  MovieListViewState.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

struct MovieListViewState {
    let movies: [Movie]
    let selectedMovieIndex: Int?

    init(_ state: AppState) {
        movies = state.movies
        selectedMovieIndex = state.selectedMovieIndex
    }
}
