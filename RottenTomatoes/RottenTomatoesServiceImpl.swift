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
    
    func fetchMovies(q: String, limit: Int, page: Int, successHandler: ([AnyObject]) -> (), errorHandler: (NSError) -> ()) {
        
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
                let movies = json["movies"].arrayValue
                let movieNames: [String] = movies.map { (movie: JSON) -> String in
                    return movie["title"].stringValue
                }
                successHandler(movieNames)
            }
        })
    }

    
}