//
//  MoviesCollectionViewController.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/13/19.
//  Copyright © 2019 iti. All rights reserved.
//

import UIKit
import SDWebImage
private let reuseIdentifier = "cell"

class MoviesCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout, MoviesViewDelegate{
    @IBOutlet weak var segmentcontroll: UISegmentedControl!
    @IBAction func toggleBtn(_ sender: UISegmentedControl) {
        if(segmentcontroll.selectedSegmentIndex==0)
        {
            
            sort_by = "popularity.desc"
            segmentcontroll.selectedSegmentIndex=sender.selectedSegmentIndex
            presenter.fetchMovies(url: url)

        }
        else if(segmentcontroll.selectedSegmentIndex==1)
        {
            segmentcontroll.selectedSegmentIndex=sender.selectedSegmentIndex
            presenter.fetchMovies(url: "https://api.themoviedb.org/3/discover/movie?api_key=19fdc0914a0bbb14387a1ae8b29d4430&sort_by=top_rated.desc")

        }
        
    }
    var movieDetailsController:MovieDetailsViewController?
    lazy var presenter : MoviesPresenterDelegate = MoviesPresenter(view: self)
    var movieArray=[Movie]()
    var sort_by = "popularity.desc"
    lazy var url = "https://api.themoviedb.org/3/discover/movie?api_key=19fdc0914a0bbb14387a1ae8b29d4430&sort_by=" + sort_by
    
    func updateUi(data moviesArray: [Movie]) {
        self.movieArray.removeAll()
        
        for movie in moviesArray{
            self.movieArray.append(movie)
        }
        self.collectionView?.reloadData()
    }
    
    func setAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.fetchMovies(url: url)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        movieDetailsController=segue.destination as! MovieDetailsViewController
       
       
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movieArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)as! MyCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185" + movieArray[indexPath.row].poster_path), placeholderImage: UIImage(named: "placeholder.png"))
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 2 * 2 ) / 2
        let height = width * 275 / 185
        return CGSize(width: width , height: height)
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        movieDetailsController!.initUI(movie: movieArray[indexPath.row])
        //self.navigationController?.pushViewController(movieDetailsController!, animated: true)
    }

}
