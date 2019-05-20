//
//  ViewController.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/13/19.
//  Copyright © 2019 iti. All rights reserved.
//

import UIKit
import SDWebImage
class MovieDetailsViewController: UIViewController, MovieDetailsViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    lazy var presenter : MovieDetailsPresenterDelegate = MovieDetailsPreseneter(view: self)
    var movie:Movie?
    var reviewArray=[Review]()
    var trailerArray=[Trailer]()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var trailersTable: UITableView!
    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var addFavBtnOutlet: UIButton!
    @IBAction func addFavBtn(_ sender: UIButton) {
        if(isMovieExists!){
            presenter.unfavoriteMovie(movie: movie!, appDelegate: UIApplication.shared.delegate as! AppDelegate)
            isMovieExists=false
            let alert = UIAlertController(title: "Alert", message: "Movie was removed from favorite", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
             addFavBtnOutlet.setTitle("Add to favorite", for: UIControlState.normal)
            
            
        }else{
            presenter.insertMovie(movie: movie!, appDelegate: UIApplication.shared.delegate as! AppDelegate)
            isMovieExists=true
            let alert = UIAlertController(title: "Alert", message: "Movie Added to Favorite", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
             addFavBtnOutlet.setTitle("Remove from favorite", for: UIControlState.normal)
           
            
        }
       
    }
    var titleString:String?
    var yearString:String?
    var durationString:String?
    var overViewString:String?
    var rateFloat:Float?
    var imgString:String?
    var isMovieExists:Bool?
    func initUI(movie:Movie){
        self.movie=movie
        titleString=movie.original_title;
        yearString=movie.release_date
        overViewString=movie.overview
        rateFloat=movie.vote_average
        imgString="https://image.tmdb.org/t/p/w185" + movie.poster_path
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(presenter.isMovieExist(movie: movie!, appDelegate: UIApplication.shared.delegate as! AppDelegate)){
            isMovieExists=true
            addFavBtnOutlet.setTitle("Remove from favorite", for: UIControlState.normal)
        }else{
            isMovieExists=false
            addFavBtnOutlet.setTitle("Add to favorite", for: UIControlState.normal)
        }
        trailersTable.delegate = self
        trailersTable.dataSource = self
        
        reviewTable.delegate = self
        reviewTable.dataSource = self
        
        titleLabel.text=titleString
        yearLabel.text=yearString
        overviewLabel.text=overViewString
        overviewLabel.sizeToFit()
        rateLabel.text=rateFloat?.description
        imgView.sd_setImage(with: URL(string: imgString!), placeholderImage: UIImage(named: "placeholder.png"))
        
        presenter.fetchReviews(url: "https://api.themoviedb.org/3/movie/"+String(movie!.id)+"/reviews?api_key=19fdc0914a0bbb14387a1ae8b29d4430")
        presenter.fetchTrailers(url: "https://api.themoviedb.org/3/movie/"+String(movie!.id)+"/videos?api_key=19fdc0914a0bbb14387a1ae8b29d4430")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        switch tableView {
        case trailersTable:
            numberOfRow = trailerArray.count
        case reviewTable:
            numberOfRow = reviewArray.count
        default:
            print("Error")
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case trailersTable:
            let trailersCell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath) as! TrailerTableViewCell
            trailersCell.trailerNameLabel.text = trailerArray[indexPath.row].name
            trailersCell.youtubeImgView.sd_setImage(with: URL(string: "http://img.youtube.com/vi/" + trailerArray[indexPath.row].key + "/maxresdefault.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
            return trailersCell
        case reviewTable:
            let reviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
            reviewCell.usernameLabel.text = reviewArray[indexPath.row].author
            reviewCell.reviewLabel.text = reviewArray[indexPath.row].content
            return reviewCell
        default:
            print("Error")
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == trailersTable) {
            let url = URL(string:"http://www.youtube.com/watch?v=" + trailerArray[indexPath.row].key)!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case trailersTable:
            return 60.0
        case reviewTable :
            return heightForView(text: reviewArray[indexPath.row].content, width: self.view.frame.width-10)
        default:
            return 50.0
        }
    }
    
    func heightForView(text:String, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateReviewsArray(data: [Review]) {
        self.reviewArray = data
        self.reviewTable.reloadData()
//        print(reviewArray.description)
    }
    
    func updateTrailerArray(data: [Trailer]) {
        self.trailerArray = data
         self.trailersTable.reloadData()
//        print(trailerArray.description)
    }


}

