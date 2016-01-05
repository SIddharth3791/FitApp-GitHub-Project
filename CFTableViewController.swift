//
//  CFTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/16/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

class CFTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var MySegmentedControl: UISegmentedControl!
    @IBOutlet weak var MyTableView: UITableView!
    
    var WodArray = [String]()
    
    //Marks : - ViewDidLoad....................
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query  = PFQuery(className: "CF_WOD")
        let runKey = query.orderByAscending("WorkOut_Name")
       runKey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.objectForKey("WorkOut_Name") as! String
                        self.WodArray.append(load)
                        
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (3)
            self.do_table_refresh()
            
        }
    }
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), { self.MyTableView.reloadData()
            return
        })

            }
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
            returnvaule = WodArray.count
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
            mycell.textLabel?.text = WodArray[indexPath.row]
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