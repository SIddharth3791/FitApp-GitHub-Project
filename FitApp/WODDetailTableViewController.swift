//
//  WODDetailTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 1/13/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//
import UIKit
import Parse
import ParseUI

class WODDetailTableViewController: UIViewController {

    //Container to store the view table selected object 
    
    //var currentObject : PFObject?
   
    
    @IBOutlet weak var WODName: UILabel!
    
    @IBOutlet weak var WODDetails: UILabel!
    
    @IBOutlet weak var DetailWOD: UILabel!
    
    @IBOutlet weak var WODReps: UILabel!
    @IBOutlet weak var WodImage: UIImageView!
    
    var WODNameLabel = String()
    var WodDetailsLabel = String()
    var detailLabel = String()
    var WODrepsLabel = String()
    var WodImageFile: PFFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WODName.text = WODNameLabel
        WODDetails.text = WodDetailsLabel
        DetailWOD.text = detailLabel
        WODReps.text = WODrepsLabel
        
        
        //
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
