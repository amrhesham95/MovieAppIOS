//
//  FavoritePresenter.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/13/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation

class FavoritePresenter: FavoritePresenterDelegate {
    
    let movieEntityCoreData:MovieEntityCoreDataDelegate = MovieEntityCoreData()
    
    func fetchMovie(appDelegate:AppDelegate) -> [Movie] {
        return movieEntityCoreData.fetchMovies(appDelegate: appDelegate)
    }
    
}
