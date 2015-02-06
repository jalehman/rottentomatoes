//
//  MoviesListViewController.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import UIKit
import Bond
import JGProgressHUD

class MoviesListViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var moviesListTableView: UITableView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    
    var hairlineImageView: UIImageView?
    
    private let viewModel: MoviesListViewModel
    private var lastQuery: String?
    
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
        
        // Register the nib file with the tableview under a reuse identifier
        moviesListTableView.registerNib(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "com.jl.movieCell")
        
        moviesSearchBar.delegate = self
        moviesListTableView.delegate = self
                        
        tapGestureRecognizer.enabled = false
        
        bindViewModel()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hairlineImageView = findHairlineImageViewUnder(navigationController!.navigationBar)
        hairlineImageView?.hidden = true
        if lastQuery == nil || lastQuery != moviesSearchBar.text {
            searchMovies()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hairlineImageView?.hidden = false
        lastQuery = moviesSearchBar.text
    }
    
    // MARK: Actions
    
    @IBAction func tapGestureReceieved(sender: AnyObject) {
        moviesSearchBar.resignFirstResponder()
    }
    
    // MARK: UISearchBarDelegate Impl
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        tapGestureRecognizer.enabled = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        tapGestureRecognizer.enabled = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {        
        moviesSearchBar.resignFirstResponder()
        searchMovies()
    }    
    
    // MARK: UITableViewDelegate Impl
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.showMovieDetailView(indexPath.row)
    }
    
    // MARK: Private
    
    private func searchMovies() {
        let hud = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        hud.textLabel.text = "Loading"
        hud.showInView(view)
        viewModel.fetchMovies(moviesSearchBar.text) {
            hud.dismiss()
        }
    }
    
    private func bindViewModel() {
        // From Bond example here: https://github.com/SwiftBond/Bond/blob/master/README.md#what-can-it-do
        viewModel.movies.map {
            [unowned self] (viewModel: MovieViewModel) -> MovieTableViewCell in
            let cell = self.moviesListTableView.dequeueReusableCellWithIdentifier("com.jl.movieCell") as MovieTableViewCell
            cell.bindViewModel(viewModel)
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
