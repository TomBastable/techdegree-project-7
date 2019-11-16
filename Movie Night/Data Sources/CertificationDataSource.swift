//
//  CertificationDataSource.swift
//  Movie Night
//
//  Created by Tom Bastable on 12/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class CertificationDataSource: NSObject, UITableViewDataSource {
    private var certifications: [MovieCertification]
    
    init(certifications: [MovieCertification]) {
        self.certifications = certifications
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return certifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CertificationCell.reuseIdentifier, for: indexPath) as! CertificationCell
        
        let certification = certifications[indexPath.row]
        
        cell.certificationTitles.text = certification.certification
        cell.certificationOverview.text = certification.meaning
        
        let colorView = UIView()
        colorView.backgroundColor = UIColor(red:0.09, green:0.05, blue:0.05, alpha:0.5)
        
        cell.selectedBackgroundView = colorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
         switch section {
         case 0: return "Select A Movie Certification"
         default: return nil
         }
        
    }
    
    func update(with certifications: [MovieCertification]) {
        self.certifications = certifications
    }
    
    // MARK: - Helper methods
    
    func certification(at indexPath: IndexPath) -> MovieCertification {
        return certifications[indexPath.row]
    }
}
