//
//  DVDListViewController.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import UIKit
import Bond
import JGProgressHUD

class DVDListViewController: UIViewController, UITableViewDelegate {
    
    // MARK: Properties
    
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var dvdsListTableView: UITableView!
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var dvdListTypeControl: UISegmentedControl!
    
    var dvdListSelectionBond: Bond<Int>!
    
    private let viewModel: DVDListViewModel
    private var lastQuery: String?
    
    // MARK: API
    
    init(viewModel: DVDListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DVDListViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Impl

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        
        // Register the nib file with the tableview under a reuse identifier
        dvdsListTableView.registerNib(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "com.jl.movieCell")
        
        dvdsListTableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "pullToRefreshDVDs", forControlEvents: .ValueChanged)
        dvdsListTableView.insertSubview(refreshControl, atIndex: 0)
        
        networkErrorView.hidden = true
        
        dvdListTypeControl.selectedSegmentIndex = 0
        
        let segmentedControlFont = UIFont.systemFontOfSize(10)
        let textAttributes = [NSFontAttributeName: segmentedControlFont]
        dvdListTypeControl.setTitleTextAttributes(textAttributes, forState: .Normal)
        
        dvdsListTableView.separatorColor = UIColor.lightGrayColor()

        dvdListSelectionBond = Dynamic.asObservableFor(dvdListTypeControl, keyPath: "selectedSegmentIndex") ->> {
            (index: Int) in
            switch index {
            case 0: self.refreshDVDs(.TopRentals)
            case 1: self.refreshDVDs(.CurrentReleases)
            case 2: self.refreshDVDs(.NewReleases)
            case 3: self.refreshDVDs(.Upcoming)
            default: self.refreshDVDs(.TopRentals)
            }
        }
        
        bindViewModel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.alpha = 1
    }
    
    // MARK: UITableViewDelegate Impl
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.showDVDDetailView(indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: Private/Internal
    
    func pullToRefreshDVDs() {
        refreshDVDs(.TopRentals)
    }
    
    private func refreshDVDs(listType: DVDListType) {
        let hud = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        hud.textLabel.text = "Loading"
        hud.showInView(view)
        viewModel.fetchDVDs(listType, completion: {
            hud.dismiss()
            self.refreshControl.endRefreshing()
            self.networkErrorView.hidden = true
            }, error: { (error: NSError) in
                hud.dismiss()
                self.refreshControl.endRefreshing()
                self.networkErrorView.hidden = false
        })
    }
    
    private func bindViewModel() {
        // From Bond example here: https://github.com/SwiftBond/Bond/blob/master/README.md#what-can-it-do
        viewModel.dvds.map {
            [unowned self] (viewModel: MovieViewModel) -> MovieTableViewCell in
            let cell = self.dvdsListTableView.dequeueReusableCellWithIdentifier("com.jl.movieCell") as MovieTableViewCell
            cell.bindViewModel(viewModel)
            return cell
            } ->> self.dvdsListTableView
    }

}
