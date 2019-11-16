//
//  ResultsController.swift
//  Movie Night
//
//  Created by Tom Bastable on 13/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate{
    // MARK:- Properties
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    lazy var resultsDataSource: ResultsDataSource = {
        return ResultsDataSource(movies: [])
    }()
    var movie: Movie?
    
    // MARK:- VDL
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultsTableView.delegate = self
        self.resultsTableView.dataSource = self.resultsDataSource
        
        guard let choiceResults = globalProperties.choiceResults else{
            self.displayAlertWith(error: MovieError.invalidData)
            return
        }
        
        resultsDataSource.update(with: choiceResults)
        self.resultsTableView.reloadData()
    }
    
    // MARK:- Table View Delegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        globalProperties.selectedMovie = resultsDataSource.movie(at: indexPath)
        performSegue(withIdentifier: "movieSegue", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor(red:0.35, green:0.18, blue:0.18, alpha:1.0)
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView = headerView
        header.textLabel?.textColor = UIColor.white
    }
}
