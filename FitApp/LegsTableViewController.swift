//
//  LegsTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 2/18/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse

class LegsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var legSegment: UISegmentedControl!
    @IBOutlet var legTableView: UITableView!

    var QuadsArray = [String]()
    var HamstringArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let query0 = PFQuery(className: "Workout_Planlist")
        let QuadsType = ["Quads"]
        let runkey = query0.orderByDescending("createdAt").whereKey("BodyType", containedIn: QuadsType)
        
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.QuadsArray.append(load)
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
        let HamStringsType = ["HamStrings"]
        let hamkey = query1.orderByDescending("createdAt").whereKey("BodyType", containedIn: HamStringsType)
        
        hamkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.HamstringArray.append(load)
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
                self.legTableView.reloadData()
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
        switch(legSegment.selectedSegmentIndex)
        {
        case 0:
            returnvaule = QuadsArray.count
            break
        case 1:
            returnvaule = HamstringArray.count
            break
        default:
            break
        }
        return returnvaule
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = legTableView.dequeueReusableCellWithIdentifier("legs", forIndexPath: indexPath)
        
        switch(legSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = QuadsArray[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = HamstringArray[indexPath.row]
            break
        default:
            break
        }
        return cell
        
    }
    @IBAction func LegList(sender: AnyObject) {
        
        legTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var BodypartDetails: DetailBodyTableViewController = segue.destinationViewController as! DetailBodyTableViewController
        if let selectArrayIndex = legTableView.indexPathForSelectedRow?.row{
            switch(legSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = QuadsArray[selectArrayIndex]
                break
            case 1:
                BodypartDetails.label = HamstringArray[selectArrayIndex]
                break
            
            default:
                break
            }
        }
    }


    
}
