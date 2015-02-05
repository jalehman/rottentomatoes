//
//  MoviesListViewController.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import UIKit
import Bond

class MoviesListViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var moviesListTableView: UITableView!
    
    private let viewModel: MoviesListViewModel
    
    // MARK: API
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MoviesListViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Impl

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchMovies()
        
        // Register the nib file with the tableview under a reuse identifier
        moviesListTableView.registerNib(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "com.jl.movieCell")
        
        bindViewModel()
    }
    
    // MARK: Private
    
    private func bindViewModel() {
        // From Bond example here: https://github.com/SwiftBond/Bond/blob/master/README.md#what-can-it-do
        viewModel.movies.map {
            [unowned self] (viewModel: MovieCellViewModel) -> MovieTableViewCell in
            let cell = self.moviesListTableView.dequeueReusableCellWithIdentifier("com.jl.movieCell") as MovieTableViewCell
            viewModel.title ->> cell.movieTitleLabel
            return cell
        } ->> self.moviesListTableView
    }

}
