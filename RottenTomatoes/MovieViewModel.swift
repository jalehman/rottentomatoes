//
//  MovieCellViewModel.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation
import Bond

class MovieViewModel: NSObject {
    
    // MARK: Properties
    
    let title: Dynamic<String>
    let year: Int
    let criticScore: Int
    let audienceScore: Int
    let imageURL: Dynamic<NSURL>
    let thumbnailURL: Dynamic<NSURL>
    let synopsis: Dynamic<String>
    let rating: Dynamic<String>
    
    private let services: ViewModelServices
    
    // MARK: API
    
    init(services: ViewModelServices, movie: Movie) {
        self.services = services
        self.title = Dynamic(movie.title)
        self.year = movie.year
        self.criticScore = movie.criticScore
        self.audienceScore = movie.audienceScore
        self.thumbnailURL = Dynamic(movie.lowResImageURL)
        self.imageURL = Dynamic(movie.imageURL)
        self.synopsis = Dynamic(movie.synopsis)
        self.rating = Dynamic(movie.mpaaRating)
    }
}