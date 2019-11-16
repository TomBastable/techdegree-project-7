//
//  MovieGenre.swift
//  Movie Night
//
//  Created by Tom Bastable on 08/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation

class MovieGenre: Equatable {
    
    static func == (lhs: MovieGenre, rhs: MovieGenre) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
    
    let name: String
    let id: Int
    
    init(name: String, id: Int) {
        
        self.name = name
        self.id = id
    }
    
    required convenience init?(json: [String: Any]) {
        
        struct Key {
            
            static let genreName = "name"
            static let genreId = "id"
            
        }
        
        guard let genreName = json[Key.genreName] as? String,
        let genreId = json[Key.genreId] as? Int
            else {
                
                print("Fail #1")
                return nil
                
        }
        
        self.init(name: genreName, id: genreId)
    }
    
    
}
