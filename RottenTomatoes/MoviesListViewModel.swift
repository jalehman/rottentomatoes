//
//  MoviesListViewModel.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation

class MoviesListViewModel: NSObject {
    
    // MARK: Properties
    
    private let services: ViewModelServices
    
    // MARK: API
    
    init(services: ViewModelServices) {
        self.services = services
    }
    
    func fetchMovies() {
        services.rottenTomatoesService.fetchMovies("toy story", limit: 30, page: 1, successHandler: {
            movieNames in
            println(movieNames)
            }, errorHandler: {
                error in
                println(error)
        })
    }
}