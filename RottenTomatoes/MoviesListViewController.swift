//
//  MoviesListViewController.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import UIKit
import Bond

class MoviesListViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var moviesListTableView: UITableView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    
    var hairlineImageView: UIImageView?
    
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
        
        edgesForExtendedLayout = .None
        
        //viewModel.fetchMovies()
        
        // Register the nib file with the tableview under a reuse identifier
        moviesListTableView.registerNib(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "com.jl.movieCell")
        
        moviesSearchBar.delegate = self
        
        bindViewModel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hairlineImageView = findHairlineImageViewUnder(navigationController!.navigationBar)
        hairlineImageView?.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hairlineImageView?.hidden = false
    }
    
    // MARK: UISearchBarDelegate Impl
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        viewModel.fetchMovies(searchBar.text) {
            self.view.endEditing(true); return
        }
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
    
    private func findHairlineImageViewUnder(view: UIView) -> UIImageView? {
        if (view.isKindOfClass(UIImageView) && view.bounds.size.height <= 1.0) {
            return view as? UIImageView
        }
        
        for subview in view.subviews {
            let imageView = self.findHairlineImageViewUnder(subview as UIView)
            if imageView != nil {
                return imageView
            }
        }
        return nil
    }


}
