//
//  Contributor.swift
//  ReduxMovieDB
//
//  Created by Christopher Fredregill on 10/10/19.
//  Copyright © 2019 Matheus Cardoso. All rights reserved.
//

import UIKit
import Nuke

struct Contributor: Codable, Equatable {
    let login: String
    let id: Int
    let avatarUrl: String
    let url: String
    let html_url: String
    let name: String
    let company: String?
    let blog: String?
    let email: String?

    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
        case url
        case html_url
        case name
        case company
        case blog
        case email
    }

    var avatar: UIImage?
}
