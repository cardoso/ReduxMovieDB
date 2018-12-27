//
//  MovieListViewStateTests.swift
//  ReduxMovieDBTests
//
//  Created by Matheus Cardoso on 12/27/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift

import XCTest
@testable import ReduxMovieDB

class MovieListViewStateTests: XCTestCase {
    func testInitWithSearchStateCanceled() {
        var state = MainState()
        state.search = .canceled
        let viewState = MovieListViewState(state)

        XCTAssertEqual(viewState.searchBarText, "")
        XCTAssertEqual(viewState.searchBarShowsCancel, false)
        XCTAssertEqual(viewState.searchBarFirstResponder, false)
    }

    func testInitWithSearchStateReady() {
        var state = MainState()
        state.search = .ready
        let viewState = MovieListViewState(state)

        XCTAssertEqual(viewState.searchBarText, "")
        XCTAssertEqual(viewState.searchBarShowsCancel, true)
        XCTAssertEqual(viewState.searchBarFirstResponder, true)
    }

    func testInitWithSearchStateSearching() {
        var state = MainState()
        state.search = .searching("test")
        let viewState = MovieListViewState(state)

        XCTAssertEqual(viewState.searchBarText, "test")
        XCTAssertEqual(viewState.searchBarShowsCancel, true)
        XCTAssertEqual(viewState.searchBarFirstResponder, true)
    }
}
