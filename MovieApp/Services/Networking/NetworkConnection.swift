//
//  NetworkConnection.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/13/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
class NetworkConnection {
    var moviesCollectionViewController:MoviesCollectionViewController
    init(moviesCollectionViewController:MoviesCollectionViewController) {
        self.moviesCollectionViewController=moviesCollectionViewController
    }
    var movieArray=[Movie]()
    func fetchMovies(from url:String){
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                    let json=JSON(value)
                    json["results"].array?.forEach({ (movieResponse) in
                        let movie=Movie(original_title: movieResponse["original_title"].stringValue, poster_path: movieResponse["poster_path"].stringValue, overview: movieResponse["overview"].stringValue, vote_average: movieResponse["vote_average"].floatValue, release_date: movieResponse["release_date"].stringValue)
                        self.movieArray.append(movie)
                    })
                print(self.movieArray.description)
                    self.moviesCollectionViewController.setMovie(fromArray: self.movieArray)
            case .failure(let ex):
                print(ex.localizedDescription)
            }
        }
    }

}

