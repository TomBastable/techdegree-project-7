//
//  ResultsCell.swift
//  Movie Night
//
//  Created by Tom Bastable on 13/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class ResultsCell: UITableViewCell {
    
    static let reuseIdentifier = "ResultsCell"
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var averageReview: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
