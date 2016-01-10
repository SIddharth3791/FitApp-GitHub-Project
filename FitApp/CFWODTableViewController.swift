//
//  CFWODTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 1/6/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CFWODTableViewController: PFQueryTableViewController {
    
    
    @IBOutlet var hello: UITableView!
    @IBOutlet weak var CFSegmentedController: UISegmentedControl!
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.parseClassName = "CF_WOD"
        self.textKey = "WorkOut_Name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        

    }

    
    override func queryForTable() -> PFQuery {
        var query1 = PFQuery(className: "CF_WOD")
        query1.whereKeyExists("WorkOut_Name")
        return query1
    }
    
 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CellCF") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CellCF")
        }
        
        
        switch(CFSegmentedController.selectedSegmentIndex)
        {
            
        case 0:
            if let nameEnglish = object?["WorkOut_Name"] as? String {
                cell?.textLabel?.text = nameEnglish
            }
            if let capital = object?["Workout_Type"] as? String {
                cell?.detailTextLabel?.text = capital
            }
            break
             case 1:
            break
        default:
            break
            
        }
        return cell
    }
    
    @IBAction func CFList(sender: UISegmentedControl) {
        
   
        
    }
   
}
