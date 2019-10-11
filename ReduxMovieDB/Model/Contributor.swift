//
//  Contributor.swift
//  ReduxMovieDB
//
//  Created by Christopher Fredregill on 10/10/19.
//  Copyright © 2019 Matheus Cardoso. All rights reserved.
//

import UIKit

struct Contributor: Codable, Equatable {
    let login: String
    let id: Int
    let avatar_url: String
    let url: String
    let html_url: String
    let name: String
    let company: String?
    let blog: String?
    let email: String?
}
