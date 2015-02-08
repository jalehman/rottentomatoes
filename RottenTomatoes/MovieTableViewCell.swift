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
    
    // MARK: Properties

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieThumbnailImage: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    // MARK: ReactiveView Impl
    
    func bindViewModel(viewModel: AnyObject) {
        let movieCellViewModel = viewModel as MovieViewModel
        
        movieCellViewModel.title ->> movieTitleLabel
        // attributedText isn't designated bondable by Bond framework, so need to do it this way.
        movieDescriptionLabel.attributedText = formattedDescription(movieCellViewModel.rating.value, synopsis: movieCellViewModel.synopsis.value)
        movieThumbnailImage.image = nil
        movieThumbnailImage.setImageWithURLRequest(NSURLRequest(URL: movieCellViewModel.thumbnailURL.value), placeholderImage: UIImage(), success: {
            (request: NSURLRequest!, _, image: UIImage!) in
            if request == nil {
                self.movieThumbnailImage.image = image
            } else {
                self.animateImageAppearance(image)
            }
            
            self.movieThumbnailImage.setImageWithURL(movieCellViewModel.imageURL.value)
            }, failure: { (_, _, _) in
                println("TODO: Handle error.")
        })
    }
    
    // MARK: Private
    
    private func animateImageAppearance(image: UIImage) {
        movieThumbnailImage.alpha = 0
        UIView.animateWithDuration(0.5, animations: {
            self.movieThumbnailImage.image = image
            self.movieThumbnailImage.alpha = 1
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
