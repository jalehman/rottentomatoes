//
//  RottenTomatoesServiceImpl.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation
import SwiftyJSON
import AFNetworking

typealias JSONParameters = [String: AnyObject]

class RottenTomatoesServiceImpl: NSObject, RottenTomatoesService {
    
    // MARK: RottenTomatoesService Impl
    
    let apiKey: String = "f6k8gx6p8q7chq573n4hw6e3"
    
    internal var currentRequest: NSURLRequest!
    
    func fetchMovies(q: String, limit: Int, page: Int, successHandler: ([Movie]) -> (), errorHandler: (NSError) -> ()) {
        
        let encodedQuery = q.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlString: String
        if q == "" {
            urlString = buildURL("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json", parameters: [:])
        } else {
            let parameters = ["q": q, "page_limit": "\(limit)", "page": "\(page)"]
            urlString = buildURL("http://api.rottentomatoes.com/api/public/v1.0/movies.json", parameters: parameters)
        }
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET(urlString, parameters: nil, success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) in
            let json = JSON(response)
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
            }, failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) in
                errorHandler(error)
        })
    }
    
    // MARK: Private

    private func buildURL(baseURL: String, parameters: [String: String]) -> String {
        var url = "\(baseURL)?apikey=\(self.apiKey)"
        
        for (key: String, value: String) in parameters {
            url += "&\(key)=\(value.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)"
        }
        
        return url
    }
}