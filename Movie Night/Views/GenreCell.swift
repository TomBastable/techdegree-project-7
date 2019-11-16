//
//  GenreCell.swift
//  Movie Night
//
//  Created by Tom Bastable on 12/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class GenreCell: UITableViewCell {
    
    static let reuseIdentifier = "GenreCell"
    
    @IBOutlet weak var GenreTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
