//
//  MovieDetailViewController.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import UIKit
import Bond

class MovieDetailViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    private let viewModel: MovieViewModel
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    func bindViewModel() {
        // Figure out how to extend self.view to be Dynamical or whatever
        viewModel.title ->> { [unowned self] (title: String) in self.title = title }
        // Definitely the easiest way to do this.
        posterImageView.setImageWithURL(viewModel.thumbnailURL.value)
        posterImageView.setImageWithURL(viewModel.imageURL.value)
    }
    
}
