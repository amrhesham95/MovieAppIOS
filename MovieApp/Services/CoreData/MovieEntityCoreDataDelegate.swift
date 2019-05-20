//
//  MovieEntityCoreDataDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab - 5 on 5/14/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
protocol MovieEntityCoreDataDelegate {
    func fetchMovies(appDelegate:AppDelegate) -> [Movie]
    func insertMovie(movie:Movie, appDelegate:AppDelegate)
    func isMovieExist(movie:Movie, appDelegate:AppDelegate) -> Bool
    func unfavoriteMovie(movie:Movie,appDelegate:AppDelegate)
}
