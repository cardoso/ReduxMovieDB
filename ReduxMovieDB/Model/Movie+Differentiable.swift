//
//  Movie+Differentiable.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 10/23/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import DifferenceKit

extension Movie: Differentiable {
    typealias DifferenceIdentifier = Int?

    var differenceIdentifier: Int? {
        return id
    }
}
