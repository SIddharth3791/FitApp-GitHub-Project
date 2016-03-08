//
//  ArmTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 2/18/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

class ArmTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var ArmTableView: UITableView!
    
    @IBOutlet weak var ArmSegment: UISegmentedControl!
    
    var BicepArray = [String]()
        var BicepDetailsArray = [String]()
    var TricepArray = [String]()
        var TricepDetailsArray = [String]()
    var ArmArray = [String]()
        var ArmDetailsArray = [String]()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query0 = PFQuery(className: "Workout_Planlist")
        let bicepsType = ["Biceps"]
        let runkey = query0.orderByDescending("createdAt").whereKey("BodyType", containedIn: bicepsType)
        
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.BicepArray.append(load)
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
        
        let query1 = PFQuery(className: "Workout_Planlist")
        let TricepsType = ["Triceps"]
        let trikey = query1.orderByDescending("createdAt").whereKey("BodyType", containedIn: TricepsType)
        
        trikey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.TricepArray.append(load)
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
        
        let query2 = PFQuery(className: "Workout_Planlist")
        let ArmType = ["Forearms"]
        let armkey = query2.orderByDescending("createdAt").whereKey("BodyType", containedIn: ArmType)
        
        armkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.ArmArray.append(load)
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
                self.ArmTableView.reloadData()
                return
        })
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

 func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnvaule = 0
        switch(ArmSegment.selectedSegmentIndex)
        {
        case 0:
            returnvaule = BicepArray.count
            break
        case 1:
            returnvaule = TricepArray.count
            break
        case 2:
            returnvaule = ArmArray.count
            break
        default:
            break
        }
        return returnvaule
        
    }
 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = ArmTableView.dequeueReusableCellWithIdentifier("Arms", forIndexPath: indexPath)
        
        switch(ArmSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = BicepArray[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = TricepArray[indexPath.row]
            break
        case 2:
            cell.textLabel?.text = ArmArray[indexPath.row]
            break
        default:
            break
        }
        return cell
        
    }
    
    @IBAction func ArmList(sender: AnyObject) {
        ArmTableView.reloadData()
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let BodypartDetails: DetailBodyTableViewController = segue.destinationViewController as! DetailBodyTableViewController
        if let selectArrayIndex = ArmTableView.indexPathForSelectedRow?.row{
            switch(ArmSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = BicepArray[selectArrayIndex]
            break
            case 1:
                BodypartDetails.label = TricepArray[selectArrayIndex]
            break
            case 2:
                BodypartDetails.label = ArmArray[selectArrayIndex]
            break
            default:
                break
            }
        }
    }
    
    
    
    
}




