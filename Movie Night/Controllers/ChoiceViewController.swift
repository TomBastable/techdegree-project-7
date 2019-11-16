//
//  ChoiceViewController.swift
//  Movie Night
//
//  Created by Tom Bastable on 12/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class ChoiceViewController: UIViewController, UITableViewDelegate{
    
    // MARK:- Properties
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var genreTableView: UITableView!
    @IBOutlet weak var certificationTableView: UITableView!
    let client = MovieAPIClient()
    @IBOutlet weak var ratingSegmentedControl: UISegmentedControl!
    
    //Genres  & Certifications  has a didSet Observer that will update the data source if changed. Only occurs once in this instance, after fetching the genre data.
    var genres: [MovieGenre] = [] {
        didSet {
            genreDataSource.update(with: genres)
            genreTableView.reloadData()
        }
    }
    
    var certifications: [MovieCertification] = [] {
        didSet{
            certificationDataSource.update(with: certifications)
            certificationTableView.reloadData()
        }
    }
    
    //Initialise empty data sources.
    lazy var genreDataSource: GenreDataSource = {
        return GenreDataSource(genres: [])
    }()
    lazy var certificationDataSource: CertificationDataSource = {
           return CertificationDataSource(certifications: [])
       }()
    
    // Choice properties - didSet KVO again, checking for a full set of choices which enables the Apply button.
    var genreChoice: [MovieGenre] = [] {
        didSet{
            enableApplyButton(isFullSetOfChoices())
        }
    }
    var certificationChoice: MovieCertification? {
        didSet{
            enableApplyButton(isFullSetOfChoices())
        }
    }
    var ratingChoice: Int = 0 {
        didSet{
            enableApplyButton(isFullSetOfChoices())
        }
    }
    
    // MARK:- VDL
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the data sources and delegates
        self.genreTableView.delegate = self
        self.genreTableView.dataSource = self.genreDataSource
        self.certificationTableView.delegate = self
        self.certificationTableView.dataSource = self.certificationDataSource
        
        //disable apply button
        enableApplyButton(isFullSetOfChoices())
        
        // retrieve genres
        client.retrieveMovieGenres { (genres, error) in
            if error != nil {
                
                self.displayAlertWith(error: error!)
                //Handle the error
                
            }else{
                // Deal with the data.
                self.genres = genres
            }
            
        }
        // retrieve certifications
        client.retrieveMovieCertifications { (certifications, error) in
            if error != nil {
                
                self.displayAlertWith(error: error!)
                // Handle Error
                
            }else{
                
                // Deal with the data
                self.certifications = certifications
                
            }
        }
        
        
    }
    
    // MARK: - Check for valid set of choices function
    
    func isFullSetOfChoices() -> Bool {
        
        if genreChoice != [] && ratingChoice != 0 && certificationChoice != nil{
            return true
        }else{
            return false
        }
    
        
    }
    
    // MARK: - Enable / Disable Apply Button
    
    func enableApplyButton(_ isFullSet: Bool){
        
        if isFullSet{
            applyButton.alpha = 1.0
            applyButton.isEnabled = true
        }else{
            applyButton.alpha = 0.5
            applyButton.isEnabled = false
        }
        
    }
    
    //MARK: - Tableview Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.genreTableView{
            
            genreChoice = [genreDataSource.genre(at: indexPath)]
            
        }else if tableView == self.certificationTableView{
            
            certificationChoice = certificationDataSource.certification(at: indexPath)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor(red:0.35, green:0.18, blue:0.18, alpha:1.0)
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView = headerView
        header.textLabel?.textColor = UIColor.white
    }
    
    //MARK: - Rating changed IBAction
    
    @IBAction func ratingChanged(_ sender: Any) {
        
        ratingChoice = ratingSegmentedControl.selectedSegmentIndex + 1
        
    }
    
    // MARK: - Apply Choices / send to home
    
    @IBAction func segueApply(_ sender: Any) {
       
        if globalProperties.currentUser == 1 {
            
            globalProperties.firstUserChoices = MovieChoices(certificationChoice: certificationChoice!, minimumRatingChoice: ratingChoice, genreChoices: genreChoice)
            
        } else if globalProperties.currentUser == 2{
            
            globalProperties.secondUserChoices = MovieChoices(certificationChoice: certificationChoice!, minimumRatingChoice: ratingChoice, genreChoices: genreChoice)
            
        }
        
        navigationController?.popViewController(animated: true)
    
    }
    
    
}
