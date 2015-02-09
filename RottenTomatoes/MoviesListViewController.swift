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
    
    var refreshControl: UIRefreshControl!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var moviesListTableView: UITableView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var networkErrorView: UIView!
    
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
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "searchMovies", forControlEvents: .ValueChanged)
        moviesListTableView.insertSubview(refreshControl, atIndex: 0)
        
        networkErrorView.hidden = true
        
        moviesListTableView.separatorColor = UIColor.lightGrayColor()
        
        bindViewModel()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.alpha = 1
        if lastQuery == nil || lastQuery != moviesSearchBar.text {
            searchMovies()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        lastQuery = moviesSearchBar.text
    }
    
    // MARK: Actions
    
    @IBAction func tapGestureReceieved(sender: AnyObject) {
        moviesSearchBar.resignFirstResponder()
        if moviesSearchBar.text == "" && lastQuery != moviesSearchBar.text {
            searchMovies()
        }
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
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func searchMovies() {
        let hud = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        hud.textLabel.text = "Loading"
        hud.showInView(view)
        lastQuery = moviesSearchBar.text
        viewModel.fetchMovies(moviesSearchBar.text, completion: {
            hud.dismiss()
            self.refreshControl.endRefreshing()
            self.networkErrorView.hidden = true
            }, error: { (error: NSError) in
                hud.dismiss()
                self.refreshControl.endRefreshing()
                self.networkErrorView.hidden = false
        })
    }
    
    // MARK: Private
    
    private func bindViewModel() {
        // From Bond example here: https://github.com/SwiftBond/Bond/blob/master/README.md#what-can-it-do
        viewModel.movies.map {
            [unowned self] (viewModel: MovieViewModel) -> MovieTableViewCell in
            let cell = self.moviesListTableView.dequeueReusableCellWithIdentifier("com.jl.movieCell") as MovieTableViewCell
            cell.bindViewModel(viewModel)
            return cell
        } ->> self.moviesListTableView
    }
}
