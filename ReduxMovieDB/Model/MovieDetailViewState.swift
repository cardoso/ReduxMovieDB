//
//  MovieDetailViewState.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

struct MovieDetailViewState {
    let movie: Movie?

    let title: String
    let date: String
    let genres: String
    let overview: String

    init(_ state: AppState) {
        movie = state.selectedMovie

        date = movie?.releaseDate ?? ""
        title = movie?.title ?? ""
        genres = movie?.genreIds.reduce("") {
            $0.isEmpty ? "\($1)" : "\($0), \($1)"
        } ?? ""
        overview = movie?.overview ?? ""
    }
}
