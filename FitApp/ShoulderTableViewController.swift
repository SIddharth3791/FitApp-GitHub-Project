//
//  ShoulderTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 2/18/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ShoulderTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var ShoulderSegment: UISegmentedControl!
    @IBOutlet var ShoulderTableView: UITableView!
    
    var ShoulderArray = [String]()
    var TrapArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query0 = PFQuery(className: "Workout_Planlist")
        let shoulderType = ["Shoulder"]
        let runkey = query0.orderByDescending("createdAt").whereKey("BodyType", containedIn: shoulderType)
        
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.ShoulderArray.append(load)
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
        let TrapType = ["Traps"]
        let Trapkey = query1.orderByDescending("createdAt").whereKey("BodyType", containedIn: TrapType)
        
        Trapkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.TrapArray.append(load)
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
                self.ShoulderTableView.reloadData()
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
            switch(ShoulderSegment.selectedSegmentIndex)
            {
            case 0:
                returnvaule = ShoulderArray.count
                break
            case 1:
                returnvaule = TrapArray.count
                break
            default:
                break
            }
            return returnvaule
            
        }
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        {
            let cell = ShoulderTableView.dequeueReusableCellWithIdentifier("Shoulder", forIndexPath: indexPath)
            
            switch(ShoulderSegment.selectedSegmentIndex)
            {
            case 0:
                cell.textLabel?.text = ShoulderArray[indexPath.row]
                break
            case 1:
                cell.textLabel?.text = TrapArray[indexPath.row]
                break
            default:
                break
            }
            return cell
            
        }

    @IBAction func ShoulderLIst(sender: AnyObject) {
        ShoulderTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let BodypartDetails: DetailBodyTableViewController = segue.destinationViewController as! DetailBodyTableViewController
        if let selectArrayIndex = ShoulderTableView.indexPathForSelectedRow?.row{
            switch(ShoulderSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = ShoulderArray[selectArrayIndex]
                break
            case 1:
                BodypartDetails.label = TrapArray[selectArrayIndex]
                break
            default:
                break
            }
        }
        
        
    }

    
}
