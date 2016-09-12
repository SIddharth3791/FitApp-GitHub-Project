//
//  Calf_GlutesTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 2/19/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Calf_GlutesTableViewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Calf_GluTableView: UITableView!
    @IBOutlet weak var CFSegment: UISegmentedControl!
    
    var CalfArray = [String]()
    var GlutesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query0 = PFQuery(className: "Workout_Planlist")
        let CalfType = ["Calf"]
        let runkey = query0.orderByDescending("createdAt").whereKey("BodyType", containedIn: CalfType)
        
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.CalfArray.append(load)
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
        
        let query1 = PFQuery(className: "Workout_Planlist")
        let GluType = ["Glute"]
        let Glukey = query1.orderByDescending("createdAt").whereKey("BodyType", containedIn: GluType)
        
        Glukey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.GlutesArray.append(load)
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
                self.Calf_GluTableView.reloadData()
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
        switch(CFSegment.selectedSegmentIndex)
        {
        case 0:
            returnvaule = CalfArray.count
            break
        case 1:
            returnvaule = GlutesArray.count
            break
        default:
            break
        }
        return returnvaule
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = Calf_GluTableView.dequeueReusableCellWithIdentifier("Calf&Glutes", forIndexPath: indexPath)
        
        switch(CFSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = CalfArray[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = GlutesArray[indexPath.row]
            break
        default:
            break
        }
        return cell
        
    }
    
    @IBAction func CGList(sender: AnyObject) {
        
        Calf_GluTableView.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let BodypartDetails: DetailBodyTableViewController = segue.destinationViewController as! DetailBodyTableViewController
        if let selectArrayIndex = Calf_GluTableView.indexPathForSelectedRow?.row{
            switch(CFSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = CalfArray[selectArrayIndex]
                break
            case 1:
                BodypartDetails.label = GlutesArray[selectArrayIndex]
                break
                
            default:
                break
            }
        }
    }
}