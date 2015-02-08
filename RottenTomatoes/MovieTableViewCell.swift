//
//  MovieTableViewCell.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import UIKit
import Bond

class MovieTableViewCell: UITableViewCell, ReactiveView {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieThumbnailImage: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    func bindViewModel(viewModel: AnyObject) {
        let movieCellViewModel = viewModel as MovieViewModel
        
        movieCellViewModel.title ->> movieTitleLabel
        // attributedText isn't designated bondable by Bond framework, so need to do it this way.
        movieDescriptionLabel.attributedText = formattedDescription(movieCellViewModel.rating.value, synopsis: movieCellViewModel.synopsis.value)
        movieThumbnailImage.setImageWithURLRequest(NSURLRequest(URL: movieCellViewModel.thumbnailURL.value), placeholderImage: UIImage(), success: { (_, _, image: UIImage!) in
            self.movieThumbnailImage.image = image
            self.movieThumbnailImage.setImageWithURL(movieCellViewModel.imageURL.value)
            }, failure: { (_, _, _) in
                println("TODO: Handle error.")
        })
    }
    
    private func formattedDescription(rating: NSString, synopsis: NSString) -> NSMutableAttributedString {
        let boldFont = UIFont.boldSystemFontOfSize(14)
        let boldDictionary = NSDictionary(object: boldFont, forKey: NSFontAttributeName)
        var boldAttrString = NSMutableAttributedString(string: "\(rating) ", attributes: boldDictionary)
        
        let normalFont = UIFont.systemFontOfSize(13)
        let normalDictionary = NSDictionary(object: normalFont, forKey: NSFontAttributeName)
        var normalAttrString = NSMutableAttributedString(string: synopsis, attributes: normalDictionary)
        
        boldAttrString.appendAttributedString(normalAttrString)
        
        return boldAttrString
    }
}
