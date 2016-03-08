//
//  BackTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 2/19/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

class BackTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var BackTableView: UITableView!
    @IBOutlet weak var BackSegment: UISegmentedControl!
    
    var UpperBackArray = [String]()
    var LowerBackArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query0 = PFQuery(className: "Workout_Planlist")
        let uBackType = ["Upper Back"]
        let runkey = query0.orderByDescending("createdAt").whereKey("BodyType", containedIn: uBackType)
        
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.objectForKey("WorkoutName")  as! String
                        self.UpperBackArray.append(load)
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
        let lBackType = ["Lower Back"]
        let Glukey = query1.orderByDescending("createdAt").whereKey("BodyType", containedIn: lBackType)
        
        Glukey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.objectForKey("WorkoutName") as! String
                        self.LowerBackArray.append(load)
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
                self.BackTableView.reloadData()
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
        switch(BackSegment.selectedSegmentIndex)
        {
        case 0:
            returnvaule = UpperBackArray.count
            break
        case 1:
            returnvaule = LowerBackArray.count
            break
        default:
            break
        }
        return returnvaule
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = BackTableView.dequeueReusableCellWithIdentifier("Back", forIndexPath: indexPath)
        
        switch(BackSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = UpperBackArray[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = LowerBackArray[indexPath.row]
            break
        default:
            break
        }
        return cell
    }
    
    @IBAction func BackList(sender: AnyObject) {
        
        BackTableView.reloadData()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var BodyVC: DetailBodyTableViewController = segue.destinationViewController as!
        DetailBodyTableViewController
       
         if let selectedArrayIndex = BackTableView.indexPathForSelectedRow?.row{
            switch(BackSegment.selectedSegmentIndex)
                {
                    case 0:
                    BodyVC.label = UpperBackArray[selectedArrayIndex]
                break
            case 1:
                BodyVC.label = LowerBackArray[selectedArrayIndex]
                break
            default:
                break
            }
            }
    }

}