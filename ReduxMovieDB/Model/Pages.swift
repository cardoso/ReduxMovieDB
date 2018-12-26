//
//  Pages.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/12/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation

struct Pages<T: Equatable>: Equatable {
    var values: [T] = []
    var currentPage: Int = 0
    var totalPages: Int = 1

    var isComplete: Bool {
        return currentPage >= totalPages
    }

    mutating func addPage(totalPages: Int, values: [T]) {
        self.totalPages = totalPages
        guard currentPage < totalPages else { return }
        self.currentPage += 1
        self.values.append(contentsOf: values)
    }
}
