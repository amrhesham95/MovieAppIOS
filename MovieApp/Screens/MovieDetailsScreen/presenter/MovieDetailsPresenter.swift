//
//  MovieDetailsPresenter.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/13/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation

class MovieDetailsPreseneter: MovieDetailsPresenterDelegate {
    
    let movieEntityCoreData:MovieEntityCoreDataDelegate = MovieEntityCoreData()
    let view : MovieDetailsViewDelegate
    lazy var networkConnection : NetworkConnectionDelegate = NetworkConnection(presenter: self)
    
    init(view : MovieDetailsViewDelegate) {
        self.view = view
    }
    
    func insertMovie(movie: Movie, appDelegate: AppDelegate) {
        movieEntityCoreData.insertMovie(movie: movie, appDelegate: appDelegate)
    }
    func isMovieExist(movie: Movie, appDelegate: AppDelegate) -> Bool {
       return movieEntityCoreData.isMovieExist(movie: movie, appDelegate: appDelegate)
    }
    
    func fetchReviews(url: String) {
        networkConnection.fetchReviews(url: url)
    }
    
    func fetchTrailers(url: String) {
        networkConnection.fetchTrailers(url: url)
    }
    
    func setReviewsArray(data: [Review]) {
        view.updateReviewsArray(data: data)
    }
    
    func setTrailerArray(data: [Trailer]) {
        view.updateTrailerArray(data: data)
    }
    
    func unfavoriteMovie(movie:Movie,appDelegate:AppDelegate){
        movieEntityCoreData.unfavoriteMovie(movie: movie, appDelegate: appDelegate)
    }

    
    
}
