//
//  NetworkConnectionDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab - 5 on 5/14/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation

protocol NetworkConnectionDelegate {
    func fetchMovies(url:String)
    func fetchReviews(url:String)
    func fetchTrailers(url:String)
}
