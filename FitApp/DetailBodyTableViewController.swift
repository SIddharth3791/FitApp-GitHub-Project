//
//  DetailBodyTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 2/25/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import ParseUI
import Parse

class DetailBodyTableViewController: UIViewController {
    
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var workoutLabel: UILabel!
    
    
    
    var label = String()
    var workout = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        TitleLabel.text = label
        workoutLabel.text = workout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
