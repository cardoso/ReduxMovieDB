//
//  UserDefaultsFavoritesStorageTests.swift
//  ReduxMovieDBTests
//
//  Created by Aleksei Cherepanov on 05.10.2019.
//  Copyright © 2019 Matheus Cardoso. All rights reserved.
//

import XCTest
@testable import ReduxMovieDB

class UserDefaultsFavoritesStorageTests: XCTestCase {
    
    var storage: UserDefaultsFavoritesStorage!
    let defaults = MockDefaults()

    override func setUp() {
        storage = .init(defaults: defaults, key: "favorites")
    }

    override func tearDown() {
        defaults.drop()
    }

    func testLoad() {
        let json = "[{\"id\":1,\"title\":\"title_1\",\"release_date\":\"releaseDate_1\",\"poster_path\":\"posterPath_1\",\"genre_ids\":[],\"overview\":\"overview_1\"}]"
        defaults.set(json.data(using: .utf8), forKey: "favorites")
        XCTAssertTrue(storage.favorites.isEmpty)
        storage.load()
        XCTAssertEqual(storage.storage[1], makeMovie(1))
    }
    
    func testSave() {
        let empty = defaults.data(forKey: "favorites")
        XCTAssertNil(empty)
        storage.storage = [1: makeMovie(1)]
        let saved = defaults.data(forKey: "favorites")
        let result = String(data: saved!, encoding: .utf8)
        let json = "[{\"id\":1,\"title\":\"title_1\",\"release_date\":\"releaseDate_1\",\"poster_path\":\"posterPath_1\",\"genre_ids\":[],\"overview\":\"overview_1\"}]"
        XCTAssertEqual(result, json)
    }
    
    func testDrop() {
        defaults.set([1, 2, 3], forKey: "favorites")
        storage.drop()
        let empty = defaults.array(forKey: "favorites") as? [Int] ?? []
        XCTAssertTrue(empty.isEmpty)
    }
    
    class MockDefaults: UserDefaults {
        init() {
            super.init(suiteName: "MockDefaults")!
        }
        
        func drop() {
            removePersistentDomain(forName: "MockDefaults")
        }
    }
}
