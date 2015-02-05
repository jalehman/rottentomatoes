//
//  RottenTomatoesService.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation

protocol RottenTomatoesService {
    var apiKey: String { get }
    
    func fetchMovies(q: String, limit: Int, page: Int, successHandler: ([AnyObject]) -> (), errorHandler: (NSError) -> ())
}