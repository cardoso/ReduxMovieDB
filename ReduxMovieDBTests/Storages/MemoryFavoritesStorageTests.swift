//
//  MemoryFavoritesStorageTests.swift
//  ReduxMovieDBTests
//
//  Created by Aleksei Cherepanov on 05.10.2019.
//  Copyright © 2019 Matheus Cardoso. All rights reserved.
//

import XCTest
@testable import ReduxMovieDB

class MemoryFavoritesStorageTests: XCTestCase {
    
    var storage: MemoryFavoritesStorage!

    override func setUp() {
        super.setUp()
        storage = MemoryFavoritesStorage()
    }

    func testIsFavorite() {
        XCTAssertFalse(storage.isFavorite(id: 3))
        storage.storage = [3: makeMovie(3)]
        XCTAssertTrue(storage.isFavorite(id: 3))
    }
    
    func testToggleItem() {
        XCTAssertTrue(storage.toggle(movie: makeMovie(2)))
        XCTAssertEqual(storage.favorites, [makeMovie(2)])
        XCTAssertFalse(storage.toggle(movie: makeMovie(2)))
        XCTAssertTrue(storage.favorites.isEmpty)
    }
    
    func testDrop() {
        XCTAssertTrue(storage.favorites.isEmpty)
        storage.storage = [1: makeMovie(1), 2: makeMovie(2), 3: makeMovie(3)]
        storage.drop()
        XCTAssertTrue(storage.favorites.isEmpty)
    }
}

func makeMovie(_ id: Int) -> Movie {
    return Movie(
        id: id,
        title: "title_\(id)",
        releaseDate: "releaseDate_\(id)",
        posterPath: "posterPath_\(id)",
        genreIds: [],
        overview: "overview_\(id)"
    )
}
