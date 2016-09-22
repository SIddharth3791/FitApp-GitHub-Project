

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
    
    //Shoulder
    var ShoulderArray = [String]()
    var ShoulderArrayRep = [String]()
    var ShoulderArrayDetails = [String]()

    //Traps
    var TrapArray = [String]()
    var TrapArrayRep = [String]()
    var TrapArrayDetails = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let query0 = PFQuery(className: "Workout_Planlist")
        let shoulderType = ["Shoulder"]
        let runkey = query0.order(byDescending: "createdAt").whereKey("BodyType", containedIn: shoulderType)
        runkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
                        self.ShoulderArray.append(load)
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
    
        let query01 = PFQuery(className: "Workout_Planlist")
        let ShoulderReps = query01.order(byDescending: "createdAt").whereKey("BodyType", containedIn: shoulderType)
        
        ShoulderReps.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.ShoulderArrayRep.append(load)
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
        
        
        let query001 = PFQuery(className: "Workout_Planlist")
        let ShoulderDetails = query001.order(byDescending: "createdAt").whereKey("BodyType", containedIn: shoulderType)
        
        ShoulderDetails.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutDetails") as! String
                        self.ShoulderArrayDetails.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (1)
            self.do_table_refresh()
        })
        
        
        let query1 = PFQuery(className: "Workout_Planlist")
        let TrapType = ["Traps"]
        let Trapkey = query1.order(byDescending: "createdAt").whereKey("BodyType", containedIn: TrapType)
        
        Trapkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
                        self.TrapArray.append(load)
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
        let TrapReps = query11.order(byDescending: "createdAt").whereKey("BodyType", containedIn: shoulderType)
        
        TrapReps.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.TrapArrayRep.append(load)
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
        let TrapDetails = query111.order(byDescending: "createdAt").whereKey("BodyType", containedIn: shoulderType)
        
        TrapDetails.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutDetails") as! String
                        self.TrapArrayDetails.append(load)
                    }
                }
                else
                {
                    print ("error")
                }
            }
            sleep (1)
            self.do_table_refresh()
        })

    }
    func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
                self.ShoulderTableView.reloadData()
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
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = ShoulderTableView.dequeueReusableCell(withIdentifier: "Shoulder", for: indexPath)
            
            switch(ShoulderSegment.selectedSegmentIndex)
            {
            case 0:
                cell.textLabel?.text = ShoulderArray[(indexPath as NSIndexPath).row]
                break
            case 1:
                cell.textLabel?.text = TrapArray[(indexPath as NSIndexPath).row]
                break
            default:
                break
            }
            return cell
            
        }

    @IBAction func ShoulderLIst(_ sender: AnyObject) {
        ShoulderTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let BodypartDetails: DetailBodyTableViewController = segue.destination as! DetailBodyTableViewController
        if let selectArrayIndex = (ShoulderTableView.indexPathForSelectedRow as NSIndexPath?)?.row{
            
            switch(ShoulderSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = ShoulderArray[selectArrayIndex]
                BodypartDetails.Reps = ShoulderArrayRep[selectArrayIndex]
                BodypartDetails.details = ShoulderArrayDetails[selectArrayIndex]
                break
            case 1:
                BodypartDetails.label = TrapArray[selectArrayIndex]
                BodypartDetails.Reps = TrapArrayRep[selectArrayIndex]
                BodypartDetails.details = ShoulderArrayDetails[selectArrayIndex]
                break
            default:
                break
            }
        }
        
        
    }

    
}
