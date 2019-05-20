//
//  MovieDetailsPresenterDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab - 5 on 5/14/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation

protocol MovieDetailsPresenterDelegate {
    func insertMovie(movie:Movie, appDelegate:AppDelegate)
    func isMovieExist(movie:Movie, appDelegate:AppDelegate) -> Bool
    func fetchReviews(url:String)
    func fetchTrailers(url:String)
    func setReviewsArray(data: [Review])
    func setTrailerArray(data: [Trailer])
    func unfavoriteMovie(movie:Movie,appDelegate:AppDelegate)

    
}
