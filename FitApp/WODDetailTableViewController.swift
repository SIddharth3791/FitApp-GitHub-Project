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
    
    @IBOutlet weak var WOD: UILabel!
    
    @IBOutlet weak var DetailWOD: UITextView!
    
    var WODNameLabel = String()
    var WodLabel = String()
    var detailsWodText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WODName.text = WODNameLabel
        WOD.text = WodLabel
        DetailWOD.text = detailsWodText
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
