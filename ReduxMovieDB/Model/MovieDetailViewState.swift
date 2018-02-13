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

    init(_ state: MainState) {
        switch state.movieDetail {
        case .show(let movie):
            self.movie = movie
        case .hide:
            self.movie = nil
        }

        date = movie?.releaseDate ?? ""
        title = movie?.title ?? ""
        overview = movie?.overview ?? ""

        genres = movie?.genreIds?.reduce("") { total, id in
            let genreName = state.genres.first { $0.id == id }?.name ?? "\(id)"
            guard let total = total else { return genreName}
            return total.isEmpty ? "\(genreName)" : "\(total), \(genreName)"
        } ?? ""
    }
}
