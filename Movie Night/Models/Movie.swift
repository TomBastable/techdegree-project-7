//
//  Movie.swift
//  Movie Night
//
//  Created by Tom Bastable on 08/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    
    // title
    let title: String?
    // overview
    let overview: String?
    // release date
    let releaseDate: String?
    // id
    let id: Int?
    // backdrop path
    let backdropPath: String?
    // poster path
    let posterPath: String?
    // genre id's
    let genreIds: [Int]?
    // average vote
    let voteAverage: Double?
    
    init(title: String?, overview: String?, releaseDate: String?, id: Int?, backdropPath: String?, posterPath: String?, genreIds: [Int]?, voteAverage: Double?) {
        
        
            self.title = title
            self.overview = overview
            self.releaseDate = releaseDate
            self.id = id
            self.backdropPath = backdropPath
            self.posterPath = posterPath
            self.genreIds = genreIds
            self.voteAverage = voteAverage
        
    }
    
    required convenience init?(json: [String: Any]) {
        
        struct Key {
            
            static let title = "title"
            static let overview = "overview"
            static let releaseDate = "release_date"
            static let id = "id"
            static let backdropPath = "backdrop_path"
            static let posterPath = "poster_path"
            static let genreIds = "genre_ids"
            static let voteAverage = "vote_average"
            
        }
        
        guard let title = json[Key.title] as? String,
            let overview = json[Key.overview] as? String,
            let releaseDate = json[Key.releaseDate] as? String,
            let id = json[Key.id] as? Int,
            let backdropPath = json[Key.backdropPath] as? String,
            let posterPath = json[Key.posterPath] as? String,
            let genreIds = json[Key.genreIds] as? [Int],
            let voteAverage = json[Key.voteAverage] as? Double
            else {
                return nil
        }
        
        self.init(title: title, overview: overview, releaseDate: releaseDate, id: id, backdropPath: backdropPath, posterPath: posterPath, genreIds: genreIds, voteAverage: voteAverage)
    }
    
}
