//
//  MainStateAction.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 4/21/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift

enum MainStateAction: Action {
    case addGenres([Genre])

    case fetchNextMoviesPage(totalPages: Int, movies: [Movie])

    case showMovieDetail(Movie)
    case willHideMovieDetail(Movie)
    case hideMovieDetail

    case readySearch
    case search(String)
    case cancelSearch
    
    case toggleShowFavorites
    case toggleFavoriteMovie

    case collapseSplitDetail
    case separateSplitDetail
}
