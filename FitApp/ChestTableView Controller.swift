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

class ChestTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var ChestTableView: UITableView!
    
    var ChestArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query0 = PFQuery(className: "Workout_Planlist")
        let ChestType = ["Chest"]
        let runkey = query0.orderByDescending("createdAt").whereKey("BodyType", containedIn: ChestType)
        
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if var objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.valueForKey("WorkoutName") as! String
                        self.ChestArray.append(load)
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
       
        return ChestArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = ChestTableView.dequeueReusableCellWithIdentifier("Chest", forIndexPath: indexPath)
        
        cell.textLabel?.text = ChestArray[indexPath.row]
        return cell
    }
}
