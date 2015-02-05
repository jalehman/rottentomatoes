//
//  MasterViewModel.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation

class MasterViewModel: NSObject {
    
    // MARK: Properties
    
    let moviesListViewModel: MoviesListViewModel
    let dvdListViewModel: DVDListViewModel
    
    private let services: ViewModelServices
    
    // MARK: API
    
    init(services: ViewModelServices) {
        self.services = services
        self.moviesListViewModel = MoviesListViewModel(services: services)
        self.dvdListViewModel = DVDListViewModel(services: services)
    }
}