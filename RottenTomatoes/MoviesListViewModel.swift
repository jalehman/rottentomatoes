//
//  MoviesListViewModel.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation
import Bond

class MoviesListViewModel: NSObject {
    
    // MARK: Properties
    
    var movies: DynamicArray<MovieViewModel>
    
    private let services: ViewModelServices
    
    // MARK: API
    
    init(services: ViewModelServices) {
        self.services = services
        self.movies = DynamicArray([])
    }
    
    func showMovieDetailView(movieIndex: Int) {
        self.services.pushViewModel(movies[movieIndex])
    }
    
    func fetchMovies(query: String, completion: () -> Void = { }, error: (NSError) -> Void = { _ in }) {
        services.rottenTomatoesService.fetchMovies(query, limit: 30, page: 1, successHandler: {
            [unowned self] (results: [Movie]) in
            self.movies.removeAll(true)
            
            for movie in results {
                self.movies.append(MovieViewModel(services: self.services, movie: movie))
            }
            
            completion()
            
            }, errorHandler: {
                (networkError: NSError) in
                error(networkError)
        })
    }
}