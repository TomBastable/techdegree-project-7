//
//  MovieViewController.swift
//  Movie Night
//
//  Created by Tom Bastable on 14/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class MovieViewController: UIViewController{
    
    //MARK:- Properties
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    //MARK:- VDL
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movie = globalProperties.selectedMovie
        
        self.movieTitle.text = movie?.title
        self.reviewLabel.text = "Average Review Score: \(movie?.voteAverage ?? 0.0)"
        self.overviewLabel.text = movie?.overview
        self.overviewLabel.numberOfLines = 0
        self.overviewLabel.sizeToFit()
        
        // Check for valid image paths
        if let posterPath = movie?.posterPath, let backgroundPath = movie?.backdropPath{
            //If present then dispatch a request to retrieve those larger images if they're not present in the larger image cache. If they're in the cache, set the image and don't bother re-requesting.
            if let cachedPoster = globalProperties.largerImageCache.object(forKey: NSString(string: posterPath)), let cachedBackground = globalProperties.largerImageCache.object(forKey: NSString(string: backgroundPath)) {
                
                self.posterImageView.image = cachedPoster
                self.backgroundImageView.image = cachedBackground
                
            }else{
            
            DispatchQueue.global(qos: .background).async {
                let posterUrl = URL(string:"https://image.tmdb.org/t/p/w500\(posterPath)")
                let posterData = try? Data(contentsOf: posterUrl!)
                let posterImage: UIImage = UIImage(data: posterData!)!
                
                let backgroundUrl = URL(string:"https://image.tmdb.org/t/p/w500\(backgroundPath)")
                let backgroundData = try? Data(contentsOf: backgroundUrl!)
                let backgroundImage: UIImage = UIImage(data: backgroundData!)!
                
                DispatchQueue.main.async {
                    // Set the images
                    self.posterImageView.image = posterImage
                    self.backgroundImageView.image = backgroundImage
                  
                }
            }
            
        }
            
        }
        
        
        
    }
    
}
