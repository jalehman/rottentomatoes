//
//  ViewModelServicesImpl.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation
import UIKit

class ViewModelServicesImpl: ViewModelServices {
    
    // MARK: Properties
    
    let rottenTomatoesService: RottenTomatoesService
    
    private let navigationController: UINavigationController!
    
    // MARK: API
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.rottenTomatoesService = RottenTomatoesServiceImpl()
    }
    
    // MARK: ViewModelServices Implementation
    
    func pushViewModel(viewModel: AnyObject) {
        if let movieViewModel = viewModel as? MovieViewModel {
            let vc = MovieDetailViewController(viewModel: movieViewModel)
            navigationController.pushViewController(vc, animated: true)
        }
    }
}