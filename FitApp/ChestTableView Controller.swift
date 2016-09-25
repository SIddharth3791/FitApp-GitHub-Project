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
    
    @IBOutlet weak var ChestSegment: UISegmentedControl!
    
    @IBOutlet weak var ChestTableView: UITableView!
    
    //upper chest
    var UpperChestArray = [String]()
    var UpperChestArrayReps = [String]()
    var UpperchestArrayDetails = [String]()
    
    //lower chest
    var LowerChestArray = [String]()
    var LowerChestArrayReps = [String]()
    var LowerChestArrayDetails = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let query0 = PFQuery(className: "Workout_Planlist")
        let ChestType = ["Upper chest"]
        let runkey = query0.order(byDescending: "createdAt").whereKey("BodyType", containedIn: ChestType)
        
        runkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
                        self.UpperChestArray.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        })
        
        let query00 = PFQuery(className: "Workout_Planlist")
        let ChestRepskey = query00.order(byDescending: "createdAt").whereKey("BodyType", containedIn: ChestType)
        
        ChestRepskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.UpperChestArrayReps.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        })
        
        let query000 = PFQuery(className: "Workout_Planlist")
        let ChestDetailsskey = query000.order(byDescending: "createdAt").whereKey("BodyType", containedIn: ChestType)
        
        ChestDetailsskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutDetails") as! String
                        self.UpperchestArrayDetails.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        })
        
        
        let query1 = PFQuery(className: "Workout_Planlist")
        let ChestTypeLower = ["Lower Chest"]
        let LCkey = query1.order(byDescending: "createdAt").whereKey("BodyType", containedIn: ChestTypeLower)
        
        LCkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
                        self.LowerChestArray.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        })
        
        let query11 = PFQuery(className: "Workout_Planlist")
        let LCRepskey = query11.order(byDescending: "createdAt").whereKey("BodyType", containedIn: ChestTypeLower)
        
        LCRepskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.LowerChestArrayReps.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        })
        
        let query111 = PFQuery(className: "Workout_Planlist")
        let LCDetailskey = query111.order(byDescending: "createdAt").whereKey("BodyType", containedIn: ChestTypeLower)
        
        LCDetailskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutDetails") as! String
                        self.LowerChestArrayDetails.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (0)
            self.do_table_refresh()
        })

        
    }
    func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
                self.ChestTableView.reloadData()
                return
        })
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ChestTableView.dequeueReusableCell(withIdentifier: "Chest", for: indexPath)
        
        switch(ChestSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = UpperChestArray[(indexPath as NSIndexPath).row]
            break
        case 1:
            cell.textLabel?.text = LowerChestArray[(indexPath as NSIndexPath).row]
            break
        default:
            break
        }
        return cell

    }
    
    @IBAction func ChestList(_ sender: AnyObject) {
        ChestTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let BodypartDetails: DetailBodyTableViewController = segue.destination as! DetailBodyTableViewController
        if let selectArrayIndex = (ChestTableView.indexPathForSelectedRow as NSIndexPath?)?.row{
            switch(ChestSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = UpperChestArray[selectArrayIndex]
                BodypartDetails.Reps = UpperChestArrayReps[selectArrayIndex]
                BodypartDetails.details = UpperchestArrayDetails[selectArrayIndex]
                break
            case 1:
                BodypartDetails.label = LowerChestArray[selectArrayIndex]
                BodypartDetails.Reps = LowerChestArrayReps[selectArrayIndex]
                BodypartDetails.details = LowerChestArrayDetails[selectArrayIndex]
                break
            default:
                break
            }
        }
    }
    
    
}
