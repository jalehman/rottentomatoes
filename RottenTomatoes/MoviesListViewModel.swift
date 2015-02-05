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
    
    var movies: DynamicArray<MovieCellViewModel>
    
    private let services: ViewModelServices
    
    // MARK: API
    
    init(services: ViewModelServices) {
        self.services = services
        self.movies = DynamicArray([])
    }
    
    func fetchMovies(query: String, completion: () -> Void = { }) {
        services.rottenTomatoesService.fetchMovies(query, limit: 30, page: 1, successHandler: {
            [unowned self] (results: [Movie]) in
            self.movies.removeAll(true)
            
            for movie in results {
                println(movie.title)
                self.movies.append(MovieCellViewModel(services: self.services, movie: movie))
            }
            
            completion()
            
            }, errorHandler: {
                error in
                println(error)
                completion()
        })
    }
}