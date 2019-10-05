//
//  MovieDetailViewState.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation

struct MovieDetailViewState: Equatable {
    let movie: Movie?

    let title: String
    let date: String
    let genres: String
    let overview: String

    init(_ state: MainState) {
        movie = state.movieDetail.movie
        date = movie?.releaseDate ?? NSLocalizedString("NO_RELEASE_DATE", comment: "Release date empty message")
        title = movie?.title ?? NSLocalizedString("NO_TITLE", comment: "Title empty message")
        overview = movie?.overview ?? NSLocalizedString("NO_OVERVIEW", comment: "Overview date empty message")
        genres = localizedGenres(movie?.genreIds ?? [], state.genres)
    }
}

func localizedGenres(_ genreIds: [Int], _ genres: [Genre]) -> String {
    let result = genreIds.reduce("") { total, id in
        let genreName = genres.first { $0.id == id }?.name ?? "\(id)"
        return total.isEmpty ? "\(genreName)" : "\(total), \(genreName)"
    }

    return result.isEmpty ? NSLocalizedString("NO_GENRE", comment: "Genre empty message") : result
}
