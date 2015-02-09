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
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var criticScoreLabel: UILabel!
    @IBOutlet weak var audienceScoreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!
    
    private var showFullDetails: Bool = false
    private let viewModel: MovieViewModel
    private let BOTTOM_CONSTRAINT_OFFSET: CGFloat = -300.0
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsViewBottomConstraint.constant = BOTTOM_CONSTRAINT_OFFSET
        
        bindViewModel()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.alpha = 0.95
    }
    
    @IBAction func detailsSwipeUp(sender: AnyObject) {
        if !showFullDetails {
            detailsViewBottomConstraint.constant = 0
            UIView.animateWithDuration(0.5, animations: {
                self.view.layoutIfNeeded()
            })
            showFullDetails = true
        }
    }
    
    @IBAction func detailsSwipeDown(sender: AnyObject) {
        if showFullDetails {
            detailsViewBottomConstraint.constant = BOTTOM_CONSTRAINT_OFFSET
            UIView.animateWithDuration(0.5, animations: {
                self.view.layoutIfNeeded()
            })
            showFullDetails = false
        }
    }
    
    func bindViewModel() {
        self.title = viewModel.title
        self.titleLabel.text = "\(viewModel.title) (\(viewModel.year))"
        self.criticScoreLabel.text = "Critics Score: \(viewModel.criticScore)"
        self.audienceScoreLabel.text = "Audience Score: \(viewModel.audienceScore)"
        synopsisTextView.text = viewModel.synopsis
        ratingLabel.text = viewModel.rating
        
        
        // Definitely the easiest way to do this.
        posterImageView.setImageWithURL(viewModel.thumbnailURL)
        posterImageView.setImageWithURL(viewModel.imageURL)
    }
    
}
