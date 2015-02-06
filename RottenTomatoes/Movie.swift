//
//  Movie.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation

class Movie: NSObject {
    
    // MARK: Properties
    
    let id: String
    let title: String
    let year: Int
    let mpaaRating: String
    let criticScore: Int
    let audienceScore: Int
    let synopsis: String
    let lowResImageURL: NSURL
    let imageURL: NSURL
    
    // MARK: API
    
    init(id: String, title: String, year: Int, mpaaRating: String, criticScore: Int, audienceScore: Int, synopsis: String, imageURL: String) {
        self.id = id
        self.title = title
        self.year = year
        self.mpaaRating = mpaaRating
        self.criticScore = criticScore
        self.audienceScore = audienceScore
        self.synopsis = synopsis
        // TODO: Use a Swift setter?
        self.lowResImageURL = NSURL(string: imageURL)!
        self.imageURL = NSURL(string: imageURL.stringByReplacingOccurrencesOfString("_tmb.", withString: "_ori.", options: nil, range: nil))!
    }
    
   }