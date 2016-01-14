//
//  WODTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/21/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class WODTableViewController:UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var MySegmentedControl: UISegmentedControl!
    @IBOutlet weak var WodTableView: UITableView!
    
    var GirlArray = [String]()
    var GirlArrayDetails = [String]()
    var HeroArray = [String]()
    var HeroArrayDetails = [String]()
    var HybridArray = [String]()
    var HybridArrayDetails = [String]()
    var OpenArray = [String]()
    var OpenArrayDetails = [String]()
   
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
// Marks:- Parse Query to populate Girls workout table cell
        let query0 = PFQuery(className: "CF_WOD")
        let girlsType = ["The New Girls", "The Benchmark Girls"]
        let runkey = query0.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: girlsType)
        //runkey.whereKeyExists("The New Girls")
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkOut_Name") as! String
                        self.GirlArray.append(load)
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
        
// marks:- Girls Parse query to get detail text
        
        let query1 = PFQuery(className: "CF_WOD")
        let subkey = query1.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: girlsType)
      //  let subkey = query2.whereKeyExists("Workout_Type")
        subkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Type") as! String
                        self.GirlArrayDetails.append(load)
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
// marks: Parse query to get hero
        
        let query2 = PFQuery(className: "CF_WOD")
        let heroType = ["Hero"]
        let heroKey = query2.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: heroType)
        heroKey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("WorkOut_Name") as! String
                        self.HeroArray.append(load)
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
//marks: - Hero Parse query to get detail text
        
        let query3 = PFQuery(className: "CF_WOD")
        let heroDkey = query3.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: heroType)
        heroDkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Type") as! String
                        self.HeroArrayDetails.append(load)
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
//Marks:- Parse query to get Hybrid
        
        let query4 = PFQuery(className: "CF_WOD")
        let hybridType = ["Hybrid"]
        let hybridkey = query4.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: hybridType)
        hybridkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("WorkOut_Name") as! String
                        self.HybridArray.append(load)
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
        
//marks: - Parse Query to get Hybrid Details

        let query5 = PFQuery(className: "CF_WOD")
        let hybridDkey = query5.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: hybridType)
        hybridDkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Type") as! String
                        self.HybridArrayDetails.append(load)
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
//Marks: - Parse Query to get Opens
        
        let query6 = PFQuery(className: "CF_WOD")
        let openType = ["Open"]
        let openkey = query6.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: openType)
        openkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("WorkOut_Name") as! String
                        self.OpenArray.append(load)
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
//Marks: - Parse query to get Open Details
        
        let query7 = PFQuery(className: "CF_WOD")
        let openDkey = query7.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: openType)
        openDkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Type") as! String
                        self.OpenArrayDetails.append(load)
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
        dispatch_async(dispatch_get_main_queue(),
        {
            self.WodTableView.reloadData()
            return
        })
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // Marks: display rows depening on data
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnvaule = 0
        
        switch(MySegmentedControl.selectedSegmentIndex)
        {
            case 0:
                returnvaule = GirlArray.count
                break
            case 1:
                returnvaule = HeroArray.count
                break
            case 2:
                returnvaule = HybridArray.count
                break
                case 3:
                returnvaule = OpenArray.count
                break
            default:
                break
        
        }
        return returnvaule

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
    
        var cell = WodTableView.dequeueReusableCellWithIdentifier("CFWOD", forIndexPath: indexPath)
        
        switch(MySegmentedControl.selectedSegmentIndex)
        {
            case 0:
                cell.textLabel?.text = GirlArray[indexPath.row]
               cell.detailTextLabel?.text = GirlArrayDetails[indexPath.row]
                break
            case 1:
                cell.textLabel?.text  = HeroArray[indexPath.row]
                cell.detailTextLabel?.text = HeroArrayDetails[indexPath.row]
                break
            case 2:
                cell.textLabel?.text = HybridArray[indexPath.row]
               cell.detailTextLabel?.text = HybridArrayDetails[indexPath.row]
                break
            case 3:
                cell.textLabel?.text = OpenArray[indexPath.row]
                cell.detailTextLabel?.text = OpenArrayDetails[indexPath.row]
                break
            default:
                break
            
        }
           return cell
    }
    
    
   
    
    @IBAction func CFListControl(sender: AnyObject)
    {
        WodTableView.reloadData()

    }
    
}



