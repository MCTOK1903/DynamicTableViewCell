//
//  MovieListViewModel.swift
//  DynamicTableViewCell
//
//  Created by MCT on 20.12.2021.
//

import Foundation

protocol MovieListViewModelType {
    func getMovies() -> [MovieDetail]?
}

final class MovieListViewModel: MovieListViewModelType {

    var movies: Movie?

    init() {
        guard let path = Bundle.main.path(
            forResource: "movies",
            ofType: "json"
        ) else { return }

        if let jsonData = try? String(contentsOfFile: path).data(using: .utf8) {
            let movies = try? JSONDecoder().decode(
                Movie.self,
                from: jsonData
            )
            self.movies = movies
        }
    }

    func getMovies() -> [MovieDetail]? {
        return movies?.results
    }
}
