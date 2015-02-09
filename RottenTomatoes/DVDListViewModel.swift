//
//  DVDListViewModel.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation
import Bond

class DVDListViewModel: NSObject {
    
    // MARK: Properties

    var dvds: DynamicArray<MovieViewModel>
    
    private let services: ViewModelServices
    
    // MARK: API
    
    init(services: ViewModelServices) {
        self.services = services
        self.dvds = DynamicArray([])
    }
    
    func showDVDDetailView(dvdIndex: Int) {
        self.services.pushViewModel(dvds[dvdIndex])
    }
    
    func fetchDVDs(type: DVDListType, completion: () -> Void = { }, error: (NSError) -> Void = { _ in }) {
        services.rottenTomatoesService.fetchDVDs(type, successHandler: {
            [unowned self] (results: [Movie]) in
            self.dvds.removeAll(true)
            
            for dvd in results {
                self.dvds.append(MovieViewModel(services: self.services, movie: dvd))
            }
            
            completion()
            
            }, errorHandler: {
                (networkError: NSError) in
                error(networkError)
        })
    }
}