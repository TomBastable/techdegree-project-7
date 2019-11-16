//
//  GenreDataSource.swift
//  Movie Night
//
//  Created by Tom Bastable on 12/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class GenreDataSource: NSObject, UITableViewDataSource {
    private var genres: [MovieGenre]
    
    init(genres: [MovieGenre]) {
        self.genres = genres
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenreCell.reuseIdentifier, for: indexPath) as! GenreCell
        
        let genre = genres[indexPath.row]
        
        cell.GenreTitleLabel.text = genre.name
        
        let colorView = UIView()
        colorView.backgroundColor = UIColor(red:0.09, green:0.05, blue:0.05, alpha:0.5)
        
        cell.selectedBackgroundView = colorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Select A Movie Genre"
        default: return nil
        }
    }
    
    func update(with genres: [MovieGenre]) {
        self.genres = genres
    }
    
    // MARK: - Helper methods
    
    func genre(at indexPath: IndexPath) -> MovieGenre {
        return genres[indexPath.row]
    }
}
