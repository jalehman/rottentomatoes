//
//  MasterViewController.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/2/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import UIKit

class MasterViewController: UITabBarController {
    
    // MARK: Properties
    
    private let viewModel: MasterViewModel
    private let tabViewControllers: [UIViewController] = []
    
    // MARK: API
    
    init(viewModel: MasterViewModel) {
        self.viewModel = viewModel
        
        // Configure the initial view controllers for the master VC.
        let moviesListViewController = MoviesListViewController(viewModel: viewModel.moviesListViewModel)
        let dvdListViewController = DVDListViewController(viewModel: viewModel.dvdListViewModel)
        
        tabViewControllers.append(moviesListViewController)
        tabViewControllers.append(dvdListViewController)

        super.init(nibName: nil, bundle: nil)
        //super.init(nibName: "", bundle: nil)
    }
    
    override func loadView() {
        var contentView: UIView = UIView(frame: CGRectZero)
        contentView.backgroundColor = UIColor.blueColor()
        self.view = contentView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Impl

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.setViewControllers(tabViewControllers, animated: true)
    }

}

