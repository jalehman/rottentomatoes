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
    
    let title: String
    let year: Int
    let criticScore: Int
    let audienceScore: Int
    let imageURL: NSURL
    let thumbnailURL: NSURL
    let synopsis: String
    let rating: String
    
    private let services: ViewModelServices
    
    // MARK: API
    
    init(services: ViewModelServices, movie: Movie) {
        self.services = services
        self.title = movie.title
        self.year = movie.year
        self.criticScore = movie.criticScore
        self.audienceScore = movie.audienceScore
        self.thumbnailURL = movie.lowResImageURL
        self.imageURL = movie.imageURL
        self.synopsis = movie.synopsis
        self.rating = movie.mpaaRating
    }
}