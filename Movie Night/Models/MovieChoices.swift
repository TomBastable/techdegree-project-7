//
//  MovieUserChoices.swift
//  Movie Night
//
//  Created by Tom Bastable on 08/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class MovieChoices {
    
    //MARK:- - Properties -
    
    // certifications
    let certificationChoice: MovieCertification
    
    // minimum rating
    let minimumRatingChoice: Int
    
    // genres
    let genreChoices: [MovieGenre]
    
    // - Class init -
    init(certificationChoice: MovieCertification, minimumRatingChoice: Int, genreChoices: [MovieGenre]) {
        
        self.certificationChoice = certificationChoice
        self.minimumRatingChoice = minimumRatingChoice
        self.genreChoices = genreChoices
        
    }
    
    //MARK:-  - Class Functions -
    
    // generate URLRequest for above selections, taking second user selections as an input
    // must also see if the certification should be greater than or less than
    
    func generateRequestBasedOn(userChoices: MovieChoices) -> URLRequest {
        
        var combinedGenres = genreChoices + userChoices.genreChoices
        
        //remove duplicate genres
        combinedGenres = combinedGenres.removeDuplicates()
        
        // Generate a string containing each genre id in a comma separated way.
        var genreIdsCommaSeparated: String {
            // Loop through both genre selections and add each id together in a string.
            var commaIdString: String = ""
            //
            for genre in combinedGenres {
                
                if commaIdString == "" {
                    commaIdString.append("\(genre.id)")
                }else{
                    commaIdString.append(",\(genre.id)")
                }
                
            }
            // return the resulting genres
            return commaIdString
            
        }
        
        // Calculate if the certificate should descend or ascend. This is done by comparing the second users choice to the first.
        var certificationAndHigher: Bool
        
        if certificationChoice.order >= userChoices.certificationChoice.order{
            certificationAndHigher = false
        }else {
            certificationAndHigher = true
        }
        
        // Find the median rating of the two users minimum ratings
        
        let medianRating = ((minimumRatingChoice + userChoices.minimumRatingChoice)/2)
        
        //Return the request with all of the above user selected criteria.
        
        return MovieNight.discover(genre: genreIdsCommaSeparated, certification: certificationChoice.certification, certificationHigher: certificationAndHigher, voteAverage: medianRating).request
        
    }
    
}

struct globalProperties {
    
    static var firstUserChoices: MovieChoices?
    static var secondUserChoices: MovieChoices?
    static var currentUser: Int?
    static var choiceResults: [Movie]?
    static var selectedMovie: Movie?
    static let imageCache = NSCache<NSString, UIImage>()
    static let largerImageCache = NSCache<NSString, UIImage>()
    
}

// Extension to Array to remove duplicate Genre's
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
