//
//  MovieEntityCoreData.swift
//  MovieApp
//
//  Created by JETS Mobile Lab - 5 on 5/14/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import CoreData

class MovieEntityCoreData :MovieEntityCoreDataDelegate{
    
    func insertMovie(movie:Movie, appDelegate:AppDelegate) {
        let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: manageContext)
        let movieEntity = NSManagedObject(entity: entity!, insertInto: manageContext)
        movieEntity.setValue(movie.id, forKey: "id")
        movieEntity.setValue(movie.original_title, forKey: "original_title")
        movieEntity.setValue(movie.overview, forKey: "overview")
        movieEntity.setValue(movie.poster_path, forKey: "poster_path")
        movieEntity.setValue(movie.release_date, forKey: "release_date")
        movieEntity.setValue(movie.vote_average, forKey: "vote_average")
        
        do{
            try manageContext.save()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    
    func fetchMovies(appDelegate:AppDelegate) -> [Movie] {
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        let moviesManagedObject:[NSManagedObject]
        var moviesArray=[Movie]()
        
        do{
            moviesManagedObject = try manageContext.fetch(fetchRequest)
            moviesManagedObject.forEach { (movieObject) in
                let movie = Movie(id: movieObject.value(forKey: "id") as! Int, original_title: movieObject.value(forKey: "original_title") as! String, poster_path: movieObject.value(forKey: "poster_path") as! String, overview: movieObject.value(forKey: "overview") as! String, vote_average: (movieObject.value(forKey: "vote_average") as! NSNumber).floatValue, release_date: movieObject.value(forKey: "release_date") as! String)
                moviesArray.append(movie)
            }
        }catch let error{
            print(error.localizedDescription)
        }
        return moviesArray
    }
    
    func isMovieExist(movie: Movie, appDelegate: AppDelegate) -> Bool {
        let manageContext = appDelegate.persistentContainer.viewContext
        let checkMovieExistPredicate=NSPredicate(format: "id==%d", movie.id)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        fetchRequest.predicate=checkMovieExistPredicate
        let moviesManagedObject:[NSManagedObject]
        var moviesArray=[Movie]()
        
        do{
            moviesManagedObject = try manageContext.fetch(fetchRequest)
            moviesManagedObject.forEach { (movieObject) in
                let movie = Movie(id: movieObject.value(forKey: "id") as! Int, original_title: movieObject.value(forKey: "original_title") as! String, poster_path: movieObject.value(forKey: "poster_path") as! String, overview: movieObject.value(forKey: "overview") as! String, vote_average: (movieObject.value(forKey: "vote_average") as! NSNumber).floatValue, release_date: movieObject.value(forKey: "release_date") as! String)
                moviesArray.append(movie)
            }
        }catch let error{
            print(error.localizedDescription)
        }
        if(moviesArray.count==0){
            return false
        }else{
            return true
        }
    }
    
    func unfavoriteMovie(movie: Movie, appDelegate: AppDelegate) {
        let manageContext = appDelegate.persistentContainer.viewContext
        let checkMovieExistPredicate=NSPredicate(format: "id==%d", movie.id)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        fetchRequest.predicate=checkMovieExistPredicate
        let moviesManagedObject:[NSManagedObject]
        
        do{
            moviesManagedObject = try manageContext.fetch(fetchRequest)
            manageContext.delete(moviesManagedObject[0])
           try manageContext.save()
        }catch let error{
            print(error.localizedDescription)
        }
    }
}

