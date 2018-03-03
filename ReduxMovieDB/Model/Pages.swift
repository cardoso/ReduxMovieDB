//
//  Pages.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/12/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation

struct Pages<T> {
    var values: [T] = []
    var currentPage: Int = 0
    var totalPages: Int = 1

    var isComplete: Bool {
        return currentPage >= totalPages
    }

    func addingPage(totalPages: Int, values: [T]) -> Pages<T> {
        let currentPage = self.currentPage < totalPages ? self.currentPage + 1 : self.currentPage
        let values = self.currentPage < totalPages ? self.values + values : self.values
        return Pages<T>.init(values: values, currentPage: currentPage, totalPages: totalPages)
    }
}
