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
    
    //var movieThumbnailURL: Dynamic<String>
    
    func bindViewModel(viewModel: AnyObject) {
        let movieCellViewModel = viewModel as MovieCellViewModel
        
        movieCellViewModel.title ->> movieTitleLabel
        movieCellViewModel.imageURL ->> {
            [unowned self] (imageURL: String) in
            self.movieThumbnailImage.setImageWithURL(NSURL(string: imageURL))
        }
        
    }
}
