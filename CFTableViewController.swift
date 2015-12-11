//
//  CFTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/16/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit

class CFTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var MySegmentedControl: UISegmentedControl!
    @IBOutlet weak var MyTableView: UITableView!
    
    let WOD:[String] = ["Fran","Annie","Grace","murphy"]
    let AboutWod:[String] = ["Functional Movement","Constanly Varying","Varying time"]
    let TimeKeeper:[String] = ["Timer","Tabata","EMOM","Custom"]
    let PR_s:[String] = ["Snatch","Clean & Jerk","Dead Lifts","Bench press"]
    
    
    // Marks: display rows depening on data
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
        var returnvaule = 0
        
        switch(MySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            returnvaule = WOD.count
            break
        case 1:
            returnvaule = TimeKeeper.count
            break
        case 2:
           returnvaule = AboutWod.count
            break
        case 3:
            returnvaule = PR_s.count
            break
        default:
            break
            
        }
        return returnvaule
    }
    
    //Marks: display data in rows
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var mycell = tableView.dequeueReusableCellWithIdentifier("CFList", forIndexPath: indexPath)
        
        switch(MySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            mycell.textLabel?.text = WOD[indexPath.row]
            break
        case 1:
             mycell.textLabel?.text  = TimeKeeper[indexPath.row]
            break
        case 2:
            mycell.textLabel?.text = AboutWod[indexPath.row]
            break
        case 3:
            mycell.textLabel?.text = PR_s[indexPath.row]
            break
        default:
            break
            
        }

        //mycell.textLabel?.text =
        return mycell
    }
    
    //selected Tableview will appear
    @IBAction func CFListAction(sender: AnyObject) {
        
        MyTableView.reloadData()
        
    }
    
}