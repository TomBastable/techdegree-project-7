//
//  DisplayAlert.swift
//  Movie Night
//
//  Created by Tom Bastable on 16/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    

func displayAlertWith(error: Error){
    
    let title: String
    let subTitle: String
    let buttonTitle: String
    
    switch error {
        
    case MovieError.invalidData:
        title = "Error Retrieving Data"
        subTitle = "Please try again"
        buttonTitle = "OK"
    case MovieError.resultsRetrievalError:
        title = "Error retrieving results - possible network issue"
        subTitle = "Please check your network and try again"
        buttonTitle = "OK"
    default:
        title = "Error"
        subTitle = "\(error)"
        buttonTitle = "OK"
    }
    
    let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
    
    self.present(alert, animated: true)
    
}

}
