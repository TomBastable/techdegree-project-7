//
//  CertificationCell.swift
//  Movie Night
//
//  Created by Tom Bastable on 12/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation


import Foundation
import UIKit

class CertificationCell: UITableViewCell {
    
    static let reuseIdentifier = "CertificationCell"
    
    @IBOutlet weak var certificationTitles: UILabel!
    
    @IBOutlet weak var certificationOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
