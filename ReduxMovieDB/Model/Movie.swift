//
//  Movie.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let releaseDate: String

    private enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
    }
}
