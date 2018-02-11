//
//  MovieDetailViewState.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

struct MovieDetailViewState {
    let title: String

    init(_ state: AppState) {
        guard let selectedMovie = state.selectedMovie else {
            title = "Invalid Movie"
            return
        }

        title = selectedMovie.name
    }
}
