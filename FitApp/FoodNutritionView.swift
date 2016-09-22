//
//  FoodNutritionView.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 9/22/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

class FoodNutritionView: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var FatsLabel: UILabel!
    @IBOutlet weak var ProteinLabel: UILabel!
    @IBOutlet weak var CarbsLabel: UILabel!
    
    @IBOutlet weak var FoodNameLabel: UILabel!
    @IBOutlet weak var CalLabel: UILabel!
    
    var FoodName = String()
    var Fats = String()
    var Proteins = String()
    var Carbs = String()
    var Cal = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CalLabel.text = Cal
        FoodNameLabel.text = FoodName
        FatsLabel.text = Fats
        ProteinLabel.text = Proteins
        CarbsLabel.text = Carbs
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//Marks:- PopOver Method Functionality
    
    @IBAction func PopButtonClicked(_ sender: AnyObject) {
        
        
        self.performSegue(withIdentifier: "CountSize", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CountSize"
        {
            let CountSizeVC = segue.destination
            let Controller = CountSizeVC.popoverPresentationController
            
            if Controller != nil{
                Controller?.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
    }

    
}
