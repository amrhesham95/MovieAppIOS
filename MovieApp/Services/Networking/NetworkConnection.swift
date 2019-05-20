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

class NetworkConnection : NetworkConnectionDelegate {
    var presenterMovies : MoviesPresenterDelegate?
    var presenterMovieDetails : MovieDetailsPresenterDelegate?
    
    init(presenter : MoviesPresenterDelegate) {
        self.presenterMovies = presenter
    }
    
    init(presenter : MovieDetailsPresenterDelegate) {
        self.presenterMovieDetails = presenter
    }
    
    func fetchMovies(url:String) {
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                var movieArray=[Movie]()
                let json=JSON(value)
                json["results"].array?.forEach({ (movieResponse) in
                    let movie=Movie(id: movieResponse["id"].intValue, original_title: movieResponse["original_title"].stringValue, poster_path: movieResponse["poster_path"].stringValue, overview: movieResponse["overview"].stringValue, vote_average: movieResponse["vote_average"].floatValue, release_date: movieResponse["release_date"].stringValue)
                    movieArray.append(movie)
                })
//                print(movieArray.description)
                self.presenterMovies!.setMoviesArray(data: movieArray)
            case .failure(let ex):
                print(ex.localizedDescription)
                self.presenterMovies!.setAlert(message: ex.localizedDescription)
            }
        }
    }
    
    func fetchReviews(url: String) {
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                var reviewArray=[Review]()
                json["results"].array?.forEach({ (reviewResponse) in
                    let review=Review(author: reviewResponse["author"].stringValue, content: reviewResponse["content"].stringValue)
                    reviewArray.append(review)
                })
//                print(reviewArray.description)
                self.presenterMovieDetails!.setReviewsArray(data: reviewArray)
            case .failure(let ex):
                print(ex.localizedDescription)
            }
        }
    }
    
    func fetchTrailers(url: String) {
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                var trailerArray=[Trailer]()
                json["results"].array?.forEach({ (trailerResponse) in
                    let trailer=Trailer(key: trailerResponse["key"].stringValue, name: trailerResponse["name"].stringValue)
                    trailerArray.append(trailer)
                })
//                print(trailerArray.description)
                self.presenterMovieDetails!.setTrailerArray(data: trailerArray)
            case .failure(let ex):
                print(ex.localizedDescription)
            }
        }
    }
    
}

