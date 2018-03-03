// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension MainState {
    init(
        _ spread: Spread<MainState>,
        genres: [Genre]? = nil,
        moviePages: Pages<Movie>? = nil,
        movieDetail: MovieDetailState? = nil,
        search: SearchState? = nil
    ) {
        self = MainState(
            genres: genres ?? spread.object.genres,
            moviePages: moviePages ?? spread.object.moviePages,
            movieDetail: movieDetail ?? spread.object.movieDetail,
            search: search ?? spread.object.search
        )
    }
}
extension Movie {
    init(
        _ spread: Spread<Movie>,
        id: Int?? = nil,
        title: String?? = nil,
        releaseDate: String?? = nil,
        posterPath: String?? = nil,
        genreIds: [Int]?? = nil,
        overview: String?? = nil
    ) {
        self = Movie(
            id: id ?? spread.object.id,
            title: title ?? spread.object.title,
            releaseDate: releaseDate ?? spread.object.releaseDate,
            posterPath: posterPath ?? spread.object.posterPath,
            genreIds: genreIds ?? spread.object.genreIds,
            overview: overview ?? spread.object.overview
        )
    }
}
