//
//  ChestTableView Controller.swift
//  FitApp
//
//  Created by Siddharth Patel on 2/19/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

class ChestTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ChestSegment: UISegmentedControl!
    
    @IBOutlet weak var ChestTableView: UITableView!
    
    var UpperChestArray = [String]()
    var LowerChestArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query0 = PFQuery(className: "Workout_Planlist")
        let ChestType = ["Upper chest"]
        let runkey = query0.orderByDescending("createdAt").whereKey("BodyType", containedIn: ChestType)
        
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.UpperChestArray.append(load)
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
        let ChestTypeLower = ["Lower Chest"]
        let LCkey = query1.orderByDescending("createdAt").whereKey("BodyType", containedIn: ChestTypeLower)
        
        LCkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.LowerChestArray.append(load)
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
                self.ChestTableView.reloadData()
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
        switch(ChestSegment.selectedSegmentIndex)
        {
        case 0:
            returnvaule = UpperChestArray.count
            break
        case 1:
            returnvaule = LowerChestArray.count
            break
        default:
            break
        }
        return returnvaule
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = ChestTableView.dequeueReusableCellWithIdentifier("Chest", forIndexPath: indexPath)
        
        switch(ChestSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = UpperChestArray[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = LowerChestArray[indexPath.row]
            break
        default:
            break
        }
        return cell

    }
    
    @IBAction func ChestList(sender: AnyObject) {
        ChestTableView.reloadData()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let BodypartDetails: DetailBodyTableViewController = segue.destinationViewController as! DetailBodyTableViewController
        if let selectArrayIndex = ChestTableView.indexPathForSelectedRow?.row{
            switch(ChestSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = UpperChestArray[selectArrayIndex]
                break
            case 1:
                BodypartDetails.label = LowerChestArray[selectArrayIndex]
                break
            default:
                break
            }
        }
    }
    
    
}
