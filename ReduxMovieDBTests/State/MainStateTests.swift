//
//  ReduxMovieDBTests.swift
//  ReduxMovieDBTests
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift

import XCTest
@testable import ReduxMovieDB

struct EmptyAction: Action { }

class ReduxMovieDBTests: XCTestCase {

    func lint(_ action: MainStateAction) -> () -> Void {
        switch action {
        case .addGenres(_): return testAddGenres
        case .fetchNextMoviesPage(_, _): return testFetchNextMoviesPage
        case .willHideMovieDetail(_): return testWillHideMovieDetail
        case .hideMovieDetail: return testHideMovieDetail
        case .showMovieDetail(_): return testShowMovieDetail
        case .readySearch: return testReadySearch
        case .search(_): return testSearch
        case .cancelSearch: return testCancelSearch
        case .addContributors(_): return testAddContributors
        }
    }

    func makeStore() -> Store<MainState> {
        return Store(
            reducer: mainReducer,
            state: MainState(),
            middleware: []
        )
    }

    func testInitialState() {
        let state = mainReducer(action: EmptyAction(), state: nil)
        XCTAssertEqual(state, MainState())
    }
    
    func testAddGenres() {
        let action = MainStateAction.addGenres([
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Drama")
        ])


        let state = mainReducer(action: action, state: nil)

        XCTAssert(state.genres.count == 2)
        XCTAssert(state.genres[0].name == "Action")
        XCTAssert(state.genres[1].name == "Drama")
    }

    func testFetchNextMoviesPage() {
        let action = MainStateAction.fetchNextMoviesPage(
            totalPages: 12,
            movies: [
                Movie(id: 0, title: "title1", releaseDate: "date", posterPath: "path", genreIds: [], overview: ""),
                Movie(id: 1, title: "title2", releaseDate: "date", posterPath: "path", genreIds: [], overview: "")
            ]
        )

        let action2 = MainStateAction.fetchNextMoviesPage(
            totalPages: 13,
            movies: [
                Movie(id: 2, title: "title3", releaseDate: "date", posterPath: "path", genreIds: [], overview: ""),
                Movie(id: 3, title: "title4", releaseDate: "date", posterPath: "path", genreIds: [], overview: "")
            ]
        )

        let state = mainReducer(action: action, state: nil)
        let state2 = mainReducer(action: action2, state: state)

        XCTAssert(state2.moviePages.totalPages == 13)
        XCTAssert(state2.moviePages.currentPage == 2)
        XCTAssert(state2.moviePages.values.count == 4)
        XCTAssert(state2.moviePages.values[0].title == "title1")
        XCTAssert(state2.moviePages.values[1].title == "title2")
        XCTAssert(state2.moviePages.values[2].title == "title3")
        XCTAssert(state2.moviePages.values[3].title == "title4")
    }
    
    func testWillHideMovieDetail() {
        let action = MainStateAction.willHideMovieDetail(
            Movie(id: 0, title: "title", releaseDate: "date", posterPath: "path", genreIds: [], overview: "")
        )

        let state = mainReducer(action: action, state: nil)

        guard case let .willHide(movie) = state.movieDetail else {
            return XCTFail()
        }

        XCTAssert(movie.title == "title")
    }

    func testHideMovieDetail() {
        let action = MainStateAction.hideMovieDetail

        let state = mainReducer(action: action, state: nil)

        guard case .hide = state.movieDetail else {
            return XCTFail()
        }
    }

    func testShowMovieDetail() {
        let action = MainStateAction.showMovieDetail(
            Movie(id: 0, title: "title", releaseDate: "date", posterPath: "path", genreIds: [], overview: "")
        )

        let state = mainReducer(action: action, state: nil)

        guard case let .show(movie) = state.movieDetail else {
            return XCTFail()
        }

        XCTAssert(movie.title == "title")
    }

    func testReadySearch() {
        let action = MainStateAction.readySearch

        let state = mainReducer(action: action, state: nil)

        guard case .ready = state.search else {
            return XCTFail()
        }
    }

    func testSearch() {
        let action = MainStateAction.search("search")

        let state = mainReducer(action: action, state: nil)

        guard case let .searching(search) = state.search else {
            return XCTFail()
        }

        XCTAssert(search == "search")
    }

    func testCancelSearch() {
        let action = MainStateAction.cancelSearch

        let state = mainReducer(action: action, state: nil)

        guard case .canceled = state.search else {
            return XCTFail()
        }
    }

    func testAddContributors() {
        let contributor1 = Contributor(login: "contributor1", id: 1, avatarUrl: "avatarUrl1", url: "url1", html_url: "htmlUrl1", name: "Contributor One")
        let contributor2 = Contributor(login: "contributor2", id: 2, avatarUrl: "avatarUrl2", url: "url2", html_url: "htmlUrl1", name: "Contributor Two")
        let action = MainStateAction.addContributors([contributor1, contributor2])

        let state = mainReducer(action: action, state: nil)

        XCTAssert(state.contributors.contains(contributor1))
        XCTAssert(state.contributors.contains(contributor2))
    }
    
}
