//
//  MovieCertification.swift
//  Movie Night
//
//  Created by Tom Bastable on 08/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation

class MovieCertification: Equatable {
    
    static func == (lhs: MovieCertification, rhs: MovieCertification) -> Bool {
        return lhs.certification == rhs.certification && lhs.meaning == rhs.meaning && lhs.order == rhs.order
    }
    
    let certification: String
    let meaning: String
    let order: Int
    
    init(certification: String, meaning: String, order: Int) {
        
        self.certification = certification
        self.meaning = meaning
        self.order = order
    }
    
    required convenience init?(json: [String: Any]) {
        
        struct Key {
            
            static let certification = "certification"
            static let meaning = "meaning"
            static let order = "order"
            
        }
        
        guard let certification = json[Key.certification] as? String,
        let order = json[Key.order] as? Int,
        let meaning = json[Key.meaning] as? String
            
            else {
                
                print("Fail #2")
                return nil
                
        }
        
        self.init(certification: certification, meaning: meaning, order: order)
        
    }
    
    
}
