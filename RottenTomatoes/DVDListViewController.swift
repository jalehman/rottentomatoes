//
//  DVDListViewController.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import UIKit

class DVDListViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel: DVDListViewModel
    
    // MARK: API
    
    init(viewModel: DVDListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DVDListViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
