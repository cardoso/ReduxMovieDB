//
//  Movie.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let posterPath: String?
    let genreIds: [Int]?
    let overview: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case overview
    }
}
