//
//  RottenTomatoesServiceImpl.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias JSONParameters = [String: AnyObject]

class RottenTomatoesServiceImpl: RottenTomatoesService {
    
    // MARK: RottenTomatoesService Impl
    
    let apiKey: String = "f6k8gx6p8q7chq573n4hw6e3"
    
    func fetchMovies(q: String, limit: Int, page: Int, successHandler: ([Movie]) -> (), errorHandler: (NSError) -> ()) {
        
        let encodedQuery = q.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let urlString = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=\(self.apiKey)&q=\(encodedQuery!)&page_limit=\(limit)&page=\(page)"
        println(urlString)
        let request = NSURLRequest(URL: NSURL(string: urlString)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            (response: NSURLResponse!, data: NSData!, error: NSError!) in
            //var errorValue: NSError? = nil
            //let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            let json = JSON(data: data)
            if error != nil {
                errorHandler(error)
            } else {
                let moviesJson = json["movies"].arrayValue
                let movies = moviesJson.map { (movie: JSON) -> Movie in
                    let id = movie["id"].stringValue
                    let title = movie["title"].stringValue
                    let year = movie["year"].intValue
                    let mpaaRating = movie["mpaa_rating"].stringValue
                    let criticScore = movie["ratings"]["critics_score"].intValue
                    let audienceScore = movie["ratings"]["audience_score"].intValue
                    let synopsis = movie["synopsis"].stringValue
                    let imageURL = movie["posters"]["original"].stringValue
                    
                    return Movie(id: id, title: title, year: year, mpaaRating: mpaaRating, criticScore: criticScore, audienceScore: audienceScore, synopsis: synopsis, imageURL: imageURL)
                }
                successHandler(movies)
            }
        })
    }

    
}