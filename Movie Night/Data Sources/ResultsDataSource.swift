//
//  ResultsDataSource.swift
//  Movie Night
//
//  Created by Tom Bastable on 13/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class ResultsDataSource: NSObject, UITableViewDataSource {

    private var movies: [Movie]
    
    init(movies: [Movie]){
        self.movies = movies
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsCell.reuseIdentifier, for: indexPath) as! ResultsCell
        
        let movie = movies[indexPath.row]
        
        cell.movieTitle.text = movie.title
        cell.averageReview.text = "Average Review Score: \(movie.voteAverage ?? 0.0)"
        cell.overviewLabel.text = movie.overview
        
        //Check for Movie Poster Path
        if let posterPath = movie.posterPath{
        
        //Check for cached image
        if let cachedImage = globalProperties.imageCache.object(forKey: NSString(string: posterPath)) {
              cell.posterImageView.image = cachedImage
        }else{
            //otherwise make a network call and cache the image
            DispatchQueue.global(qos: .background).async {
                let url = URL(string:"https://image.tmdb.org/t/p/w200\(posterPath)")
                let data = try? Data(contentsOf: url!)
                let image: UIImage = UIImage(data: data!)!
                DispatchQueue.main.async {
                    globalProperties.imageCache.setObject(image, forKey: NSString(string: posterPath))
                     cell.posterImageView.image = image
                }
            }
            
        }
        }
        
        let colorView = UIView()
        colorView.backgroundColor = UIColor(red:0.09, green:0.05, blue:0.05, alpha:0.5)
        
        cell.selectedBackgroundView = colorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
         switch section {
         case 0: return "Suggestions based on both sets of criteria:"
         default: return nil
         }
        
    }
    
    func update(with movies: [Movie]) {
        self.movies = movies
    }
    
    // MARK: - Helper methods
    
    func movie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }

}
