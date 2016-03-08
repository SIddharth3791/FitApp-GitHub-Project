//
//  CoreTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 2/25/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CoreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var coreSegment: UISegmentedControl!
    @IBOutlet weak var Coretableview: UITableView!
    var CoreArray = [String]()
    var AbsArray = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
     
        let query0 = PFQuery(className: "Workout_Planlist")
        let coreType = ["Core"]
        let runkey = query0.orderByDescending("createdAt").whereKey("BodyType", containedIn: coreType)
        
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.objectForKey("WorkoutName")  as! String
                        self.CoreArray.append(load)
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
        let AbsType = ["Abs"]
        let Glukey = query1.orderByDescending("createdAt").whereKey("BodyType", containedIn: AbsType)
        
        Glukey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.objectForKey("WorkoutName") as! String
                        self.AbsArray.append(load)
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
                self.Coretableview.reloadData()
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
        switch(coreSegment.selectedSegmentIndex)
        {
        case 0:
            returnvaule = CoreArray.count
            break
        case 1:
            returnvaule = AbsArray.count
            break
        default:
            break
        }
        return returnvaule
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = Coretableview.dequeueReusableCellWithIdentifier("Core", forIndexPath: indexPath)
        
        switch(coreSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = CoreArray[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = AbsArray[indexPath.row]
            break
        default:
            break
        }
        return cell
    }

    @IBAction func coreList(sender: AnyObject) {
        
        Coretableview.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var BodyVC: DetailBodyTableViewController = segue.destinationViewController as!
        DetailBodyTableViewController
        
        if let selectedArrayIndex = Coretableview.indexPathForSelectedRow?.row{
            switch(coreSegment.selectedSegmentIndex)
            {
            case 0:
                BodyVC.label = CoreArray[selectedArrayIndex]
                break
            case 1:
                BodyVC.label = AbsArray[selectedArrayIndex]
                break
            default:
                break
            }
        }
    }
    


    
}