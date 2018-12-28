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
        case .willHide(let movie):
            self.movie = movie
        case .hide:
            self.movie = nil
        case .show(let movie):
            self.movie = movie
        }

        date = movie?.releaseDate ?? "No date"
        title = movie?.title ?? "No title"
        overview = movie?.overview ?? "No overview"
        genres = localizedGenres(movie?.genreIds ?? [], state.genres)
    }
}

func localizedGenres(_ genreIds: [Int], _ genres: [Genre]) -> String {
    let result = genreIds.reduce("") { total, id in
        let genreName = genres.first { $0.id == id }?.name ?? "\(id)"
        return total.isEmpty ? "\(genreName)" : "\(total), \(genreName)"
    }

    return result.isEmpty ? "No genres" : result
}
