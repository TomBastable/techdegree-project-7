//
//  ViewController.swift
//  Movie Night
//
//  Created by Tom Bastable on 07/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let bubbleSelected: UIImage = UIImage(named: "bubble-selected")!
    let bubbleEmpty: UIImage = UIImage(named: "bubble-empty")!
    @IBOutlet weak var firstUserButton: UIButton!
    @IBOutlet weak var secondUserButton: UIButton!
    let client = MovieAPIClient()
    @IBOutlet weak var viewResultsButton: UIButton!
    
    
    //MARK: - VDL
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor(red:0.09, green:0.05, blue:0.05, alpha:1.0)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.white
        
        }
    
    //MARK: - VWA
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateButtons()

    }
    
    // MARK: - userChoiceSegue
    @IBAction func startChoosing(_ sender: UIButton) {
            
            if sender == firstUserButton { globalProperties.currentUser = 1 }
            if sender == secondUserButton { globalProperties.currentUser = 2 }
            performSegue(withIdentifier: "choiceSegue", sender: self)
            
    }
    
    // MARK: - Clear Current Choices
    @IBAction func clearChoices(_ sender: Any) {
        
        //Nil user choices
        globalProperties.firstUserChoices = nil
        globalProperties.secondUserChoices = nil
        // update buttons
        updateButtons()
        
    }
    
    //MARK: - Update Button Status / Images
    func updateButtons(){
        
        //first user button
        if globalProperties.firstUserChoices != nil {
            firstUserButton.setImage(bubbleSelected, for: .normal)
        }else if globalProperties.firstUserChoices == nil{
            firstUserButton.setImage(bubbleEmpty, for: .normal)
        }
        //second user button
        if globalProperties.secondUserChoices != nil {
            secondUserButton.setImage(bubbleSelected, for: .normal)
        } else if globalProperties.secondUserChoices == nil{
            secondUserButton.setImage(bubbleEmpty, for: .normal)
        }
        //view results button
        if globalProperties.firstUserChoices != nil && globalProperties.secondUserChoices != nil{
            viewResultsButton.isEnabled = true
            viewResultsButton.alpha = 1.0
        }else if globalProperties.firstUserChoices == nil && globalProperties.secondUserChoices == nil{
            viewResultsButton.isEnabled = false
            viewResultsButton.alpha = 0.5
        }
    }
    
    // MARK: - Get final results
    @IBAction func getResults(_ sender: Any) {
        
        client.retrieveMovieResults(userChoice: (globalProperties.firstUserChoices?.generateRequestBasedOn(userChoices: globalProperties.secondUserChoices!))!) { (movies, error) in
            
            if error != nil {
                
                self.displayAlertWith(error: error!)
                
            }else{
                globalProperties.choiceResults = movies
                self.performSegue(withIdentifier: "resultsSegue", sender: self)
            }
            
        }
        
    }
    
    
    }


