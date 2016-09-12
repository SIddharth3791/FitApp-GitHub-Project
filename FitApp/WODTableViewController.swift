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
    var GirlArrayWODDetails = [String]() //marks :- Girl Workout details
    var GirlArrayWODReps = [String]()    //Marks :- Girl Workout Reps
    
    var HeroArray = [String]()
    var HeroArrayDetails = [String]()
    var HeroArrayWODDetails = [String]() // Marks:- Hero Workout Details
    var HeroArrayWODReps = [String]() // Marks:- Hero Workout Reps
    
    var HybridArray = [String]()
    var HybridArrayDetails = [String]()
    var HybridArrayWODDetails = [String]() //Marks:- Hybrid workout Details
    var HybridArrayWODReps = [String]() //Marks: - Hybrid workout Rep
    
    var OpenArray = [String]()
    var OpenArrayDetails = [String]()
    var OpenArrayWODDetails = [String]() // Marks:- Open Workout Details
    var OpenArrayWODReps = [String]() //marks:- Open Workout Reps
    
    
    
   
    var photo = [PFFile]()
    
    @IBAction  func unwindForWodTableview(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }

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
            sleep (1)
            self.do_table_refresh()
            }
        
// marks:-  Parse query to get Girl WOD type
        
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
            sleep (0)
            self.do_table_refresh()
        }
        
// Marks:- Parse Query to get Girl WOD Details
        
        let query01 = PFQuery(className: "CF_WOD")
        let girlDetailKey = query01.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: girlsType)
        //  let subkey = query2.whereKeyExists("Workout_Type")
        girlDetailKey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Details") as! String
                        self.GirlArrayWODDetails.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        }
// Marks: Parse query to get Girls Rep
        
        let query001 = PFQuery(className: "CF_WOD")
        let girlRepKey = query001.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: girlsType)
        //  let subkey = query2.whereKeyExists("Workout_Type")
        girlRepKey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Reps") as! String
                        self.GirlArrayWODReps.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        }
        
//marks:- Parse query to get Image file
        
               

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
            sleep (1)
            self.do_table_refresh()
        }
//marks: - Parse query to get  Hero text
        
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
            sleep (0)
            self.do_table_refresh()
        }
// Marks:- Parse query to get Hero WOD details
        
        
       let query03 = PFQuery(className: "CF_WOD")
        let heroDetailkey = query03.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: heroType)
        heroDetailkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Details") as! String
                        self.HeroArrayWODDetails.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        }
//Marks:- Parse query to get Hero WOD reps
        
        let query003 = PFQuery(className: "CF_WOD")
        let heroRepkey = query003.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: heroType)
        heroRepkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Reps") as! String
                        self.HeroArrayWODReps.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
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
            sleep (1)
            self.do_table_refresh()
        }
        
//marks: - Parse Query to get Hybrid text

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
            sleep (0)
            self.do_table_refresh()
        }
//marks: - Parse Query to get Hybrid deatils
        
        let query05 = PFQuery(className: "CF_WOD")
        let hybridDetailkey = query05.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: hybridType)
        hybridDetailkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Details") as! String
                        self.HybridArrayWODDetails.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        }
//Marks: - Parse Query to get Hydrid Reps
        
        let query005 = PFQuery(className: "CF_WOD")
        let hybridRepkey = query005.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: hybridType)
        hybridRepkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Reps") as! String
                        self.HybridArrayWODReps.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
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
            sleep (1)
            self.do_table_refresh()
        }
//Marks: - Parse query to get Open text
        
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
            sleep (0)
            self.do_table_refresh()
        }

//Marks:- Parse query to get Open Details
        
        let query07 = PFQuery(className: "CF_WOD")
        let openDetailkey = query07.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: openType)
        openDetailkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Details") as! String
                        self.OpenArrayWODDetails.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        }
//marks:- Parse Query to get Open WOD Reps
        
        let query007 = PFQuery(className: "CF_WOD")
        let openRepskey = query007.orderByDescending("createdAt").whereKey("Workout_Type", containedIn: openType)
        openRepskey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let load = object.objectForKey("Workout_Reps") as! String
                        self.OpenArrayWODReps.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
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
    
        let cell = WodTableView.dequeueReusableCellWithIdentifier("CFWOD", forIndexPath: indexPath)
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let WodDetailsVC : WODDetailTableViewController = segue.destinationViewController as! WODDetailTableViewController
        if let selectedArrayIndex = WodTableView.indexPathForSelectedRow?.row{
       
            switch (MySegmentedControl.selectedSegmentIndex){
            case 0:
            WodDetailsVC.WODNameLabel = GirlArray[selectedArrayIndex]
            WodDetailsVC.WodDetailsLabel = GirlArrayDetails[selectedArrayIndex]
            WodDetailsVC.detailLabel = GirlArrayWODDetails[selectedArrayIndex]
            WodDetailsVC.WODrepsLabel = GirlArrayWODReps[selectedArrayIndex]
           // WodDetailsVC.WodImageFile = photo[selectedArrayIndex]
            break
            case 1:
            WodDetailsVC.WODNameLabel = HeroArray[selectedArrayIndex]
            WodDetailsVC.WodDetailsLabel = HeroArrayDetails[selectedArrayIndex]
            WodDetailsVC.detailLabel = HeroArrayWODDetails[selectedArrayIndex]
            WodDetailsVC.WODrepsLabel = HeroArrayWODReps[selectedArrayIndex]
           // WodDetailsVC.WodImageFile = photo[selectedArrayIndex]
            break
            case 2:
            WodDetailsVC.WODNameLabel = HybridArray[selectedArrayIndex]
            WodDetailsVC.WodDetailsLabel = HybridArrayDetails[selectedArrayIndex]
            WodDetailsVC.detailLabel = HybridArrayWODDetails[selectedArrayIndex]
            WodDetailsVC.WODrepsLabel = HybridArrayWODReps[selectedArrayIndex]
           // WodDetailsVC.WodImageFile = photo[selectedArrayIndex]
            break
            case 3:
            WodDetailsVC.WODNameLabel = OpenArray[selectedArrayIndex]
            WodDetailsVC.WodDetailsLabel = OpenArrayDetails[selectedArrayIndex]
            WodDetailsVC.detailLabel = OpenArrayWODDetails[selectedArrayIndex]
            WodDetailsVC.WODrepsLabel = OpenArrayWODReps[selectedArrayIndex]
           // WodDetailsVC.WodImageFile = photo[selectedArrayIndex]
            break
            default:
            break
            }
        
        }
    }
}


