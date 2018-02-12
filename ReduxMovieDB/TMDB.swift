//
//  TMDB.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation

protocol TMDBFetcher {
    func fetchUpcomingMovies(page: Int, completion: @escaping (TMDBListResult<Movie>?) -> Void) -> Void
}

struct TMDBListResult<T: Codable>: Codable {
    let results: [T]
    let page: Int
    let totalPages: Int
    let totalResults: Int

    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init?(data: Data) {
        guard let obj = try? JSONDecoder().decode(type(of: self), from: data) else {
            return nil
        }

        self = obj
    }
}

class TMDB: TMDBFetcher {
    let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    let baseUrl = "https://api.themoviedb.org/3"

    func fetchUpcomingMovies(page: Int, completion: @escaping (TMDBListResult<Movie>?) -> Void) -> Void {
        guard let url = URL(string: "\(baseUrl)/movie/upcoming?api_key=\(apiKey)&page=\(page)") else {
            return completion(nil)
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return completion(nil)
            }

            completion(TMDBListResult<Movie>(data: data))
        }.resume()
    }
}
