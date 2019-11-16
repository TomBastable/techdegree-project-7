//
//  MovieAPIClient.swift
//  Movie Night
//
//  Created by Tom Bastable on 08/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation

class MovieAPIClient {

let downloader = JSONDownloader()

typealias Results = [[String: Any]]
    
// MARK:- Retrieve Movie Genres.

func retrieveMovieGenres(completion: @escaping ([MovieGenre], MovieError?) -> Void){
    
    let endpoint = MovieNight.genre.request
    
    performRequest(with: endpoint) { results, error in
        guard let results = results else {
            completion([], error)
            return
        }
        
        let genres = results.compactMap { MovieGenre(json: $0) }
        
        completion(genres, nil)
    }
    
}
    
// MARK: - Retrieve Movie Certifications.
    
func retrieveMovieCertifications(completion: @escaping ([MovieCertification], MovieError?) -> Void){
        
        let endpoint = MovieNight.certification.request
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            
            let certifications = results.compactMap { MovieCertification(json: $0) }
            
            completion(certifications, nil)
        }
        
    }
    
// MARK: - Get movie results from user input -
// This method take in an input of URLRequest which is generated from the "generateRequestBasedOn(userChoices" function in the MovieChoices Class.
    
    func retrieveMovieResults(userChoice endpoint: URLRequest, completion: @escaping ([Movie], MovieError?) -> Void){
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            
            let movies = results.compactMap { Movie(json: $0) }
            
            completion(movies, nil)
        }
        
    }
    
//MARK: - Perform request function.
//Modified from the version I made for the API Awakens project to allow for the different types of results experienced in TMDB.

func performRequest(with endpoint: URLRequest, completion: @escaping (Results?, MovieError?) -> Void) {
    
    let task = downloader.jsonTask(with: endpoint) { json, error in
        DispatchQueue.main.async {
            guard var json = json else {
               
                completion(nil, error)
                return
            }
            
            //Movie results will be nested under "results"
            var jsonTitle = "results"
            
            //Similar thing with genres
            if endpoint == MovieNight.genre.request{
                
                jsonTitle = "genres"
                
            }
            // Certifications work slightly differently as they're seperated into countries. Below I've removed the nesting and only fetched the US certifications as the app doesn't require multiple countries. This should be easy to refactor by forwarding user inputted region to this function.
            else if endpoint == MovieNight.certification.request{
                //safely remove nested arrays
                guard let certJson = json["certifications"] as? JSONDownloader.JSON else {
                    completion(nil, .jsonParsingFailure(message: "JSON Error - Nesting issue."))
                    return
                }
                //choose the country for certifications
                jsonTitle = "US"
                //replace the initial json data with the new json data that has had its nesting removed, ready for compactmapping into modelled data.
                json = certJson
                
            }
            //below we will get the correct results based on the request this function initialised with - outlined above.
            guard let results = json[jsonTitle] as? [[String: Any]] else {
               
                completion(nil, .jsonParsingFailure(message: "JSON data does not contain any valid results"))
                return
            }
            completion(results, nil)
        }
    }
    
    task.resume()
    
}
}
