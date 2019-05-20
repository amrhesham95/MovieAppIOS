//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/13/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation

class MoviesPresenter: MoviesPresenterDelegate{
   
    let view : MoviesViewDelegate
    lazy var networkConnection : NetworkConnectionDelegate = NetworkConnection(presenter: self)
    
    init(view : MoviesViewDelegate) {
        self.view = view
    }
    
    func fetchMovies(url: String) {
        networkConnection.fetchMovies(url: url)
    }
    
    func setMoviesArray(data moviesArray: [Movie]) {
        view.updateUi(data: moviesArray)
    }
    
    func setAlert(message: String) {
        view.setAlert(message: message)
    }
    
}
