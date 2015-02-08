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

        super.init(nibName: "MasterViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Impl

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        
        self.setViewControllers(tabViewControllers, animated: false)
        println(UIImage(named: "iconmonstr-video-icon-64"))
        
        tabViewControllers[0].tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "iconmonstr-video-icon-64"), tag: 0)
        tabViewControllers[1].tabBarItem = UITabBarItem(title: "DVDs", image: UIImage(named: "iconmonstr-disc-3-icon-64"), tag: 1)
        
        self.title = "Rotten Tomatoes"
        
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = newBackButton

    }    
}

