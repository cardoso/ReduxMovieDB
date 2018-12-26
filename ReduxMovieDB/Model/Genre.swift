//
//  Genre.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/12/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation

struct Genre: Codable, Equatable {
    let id: Int?
    let name: String?
}

struct GenreList: Codable {
    let genres: [Genre]
}
