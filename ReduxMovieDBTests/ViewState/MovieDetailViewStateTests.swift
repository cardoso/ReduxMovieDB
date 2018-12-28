//
//  MovieDetailViewStateTests.swift
//  ReduxMovieDBTests
//
//  Created by Matheus Cardoso on 12/28/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift

import XCTest
@testable import ReduxMovieDB

class MovieDetailViewStateTests: XCTestCase {
    func testInitWithMovieDetailWillHide() {
        var state = MainState()

        let movie = Movie(
            id: 0,
            title: "title",
            releaseDate: "releaseDate",
            posterPath: "posterPath",
            genreIds: [],
            overview: "overview"
        )

        state.movieDetail = .willHide(movie)
        let viewState = MovieDetailViewState(state)

        XCTAssertEqual(viewState.movie, movie)
    }

    func testInitWithMovieDetailHide() {
        var state = MainState()

        state.movieDetail = .hide
        let viewState = MovieDetailViewState(state)

        XCTAssertNil(viewState.movie)
    }

    func testInitWithMovieDetailShow() {
        var state = MainState()

        let movie = Movie(
            id: 0,
            title: "title",
            releaseDate: "releaseDate",
            posterPath: "posterPath",
            genreIds: [],
            overview: "overview"
        )

        state.movieDetail = .show(movie)
        let viewState = MovieDetailViewState(state)

        XCTAssertEqual(viewState.movie, movie)
    }

    func testLocalizedGenres() {
        // test no genres

        let result0 = localizedGenres([], [])

        XCTAssertEqual(result0, "No genres")

        // test single genre

        let result1 = localizedGenres([0], [Genre(id: 0, name: "Action")])

        XCTAssertEqual(result1, "Action")

        // test genre with nil name

        let result2 = localizedGenres([1], [Genre(id: 1, name: nil)])

        XCTAssertEqual(result2, "1")

        // test multiple genres

        let result3 = localizedGenres([0, 1], [
            Genre(id: 0, name: "Action"),
            Genre(id: 1, name: "Romance")
        ])

        XCTAssertEqual(result3, "Action, Romance")
    }
}
