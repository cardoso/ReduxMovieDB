//
//  ReduxMovieDBUITests.swift
//  ReduxMovieDBUITests
//
//  Created by Thays on 07/10/19.
//  Copyright © 2019 Matheus Cardoso. All rights reserved.
//

import XCTest

class ReduxMovieDBUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testListViewToDetailsView() {
        let myTable = app.tables.matching(identifier: "moviesTable")
        let cell = myTable.cells.element(matching: .cell, identifier: "movie_0")
        cell.tap()
    }
    
    func testToBackListView() {
        let myTable = app.tables.matching(identifier: "moviesTable")
        let cell = myTable.cells.element(matching: .cell, identifier: "movie_0")
        cell.tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }

}
