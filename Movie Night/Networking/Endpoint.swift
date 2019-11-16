//
//  Endpoint.swift
//  Movie Night
//
//  Created by Tom Bastable on 07/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation

fileprivate let apiKey: URLQueryItem = URLQueryItem(name: "api_key", value: "35c0e6eeaf6639015575e3f5fdecab98")

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
    
    var request: URLRequest {
        
        let url = urlComponents.url!
        return URLRequest(url: url)
        
    }
    
}

enum MovieNight {
    
    case certification
    case genre
    case discover(genre: String?, certification: String?, certificationHigher: Bool?, voteAverage: Int?)
    
}

extension MovieNight: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        
        switch self {
            
        case .certification: return "/3/certification/movie/list"
        case .genre: return "/3/genre/movie/list"
        case .discover: return "/3/discover/movie"
            
        }
        
    }
    
    var queryItems: [URLQueryItem] {
        
    switch self {
        
    case .discover(let genre, let certification, let certificationHigher, let voteAverage):
        
        var result = [URLQueryItem]()
        
        if let genre = genre {
            let genreChoices = URLQueryItem(name: "with_genres", value: genre)
            result.append(genreChoices)
        }
        
        if let certification = certification, let certificationHigher = certificationHigher{
            // Work out which way the certification filter needs to go
            let certificationCountry = URLQueryItem(name: "certification_country", value: "US")
            
            if certificationHigher {
                
            result.append(certificationCountry)
            let certificationChoice = URLQueryItem(name: "certification.gte", value: certification)
            result.append(certificationChoice)
                
            } else if !certificationHigher{
                
                result.append(certificationCountry)
                let certificationChoice = URLQueryItem(name: "certification.lte", value: certification)
                result.append(certificationChoice)
                
            }
        }
        
        if let voteAverage = voteAverage{
            let voteAverageChoice = URLQueryItem(name: "vote_average.gte", value: String(voteAverage))
            result.append(voteAverageChoice)
        }
        
        result.append(apiKey)
        
        return result
        
    case .certification:
        return [apiKey]
        
    case .genre:
        return [apiKey]
        }
    }
    
}

