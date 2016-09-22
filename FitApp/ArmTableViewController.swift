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
    
    //Bisceps
    var BicepArray = [String]()
    var BicepArrayReps = [String]()
    var BicepArrayDetails = [String]()
    
    //Triceps
    var TricepArray = [String]()
    var TricepArrayRep = [String]()
    var TricepArrayDetails = [String]()
    
    //Arms
    var ArmArray = [String]()
    var ArmArrayReps = [String]()
    var ArmsArrayDetails = [String]()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query0 = PFQuery(className: "Workout_Planlist")
        let bicepsType = ["Biceps"]
        let runkey = query0.order(byDescending: "createdAt").whereKey("BodyType", containedIn: bicepsType)
        
        runkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in

            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
                        self.BicepArray.append(load)
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
        let BiscepRepkey = query00.order(byDescending: "createdAt").whereKey("BodyType", containedIn: bicepsType)
        
        BiscepRepkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in

            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.BicepArrayReps.append(load)
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
        let BiscepDetailkey = query000.order(byDescending: "createdAt").whereKey("BodyType", containedIn: bicepsType)
        
        BiscepDetailkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutDetails") as! String
                        self.BicepArrayDetails.append(load)
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
        let TricepsType = ["Triceps"]
        let trikey = query1.order(byDescending: "createdAt").whereKey("BodyType", containedIn: TricepsType)
        
        trikey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
                        self.TricepArray.append(load)
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
        let TricepsRepkey = query11.order(byDescending: "createdAt").whereKey("BodyType", containedIn: TricepsType)
        
        TricepsRepkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.TricepArrayRep.append(load)
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
        let TricepsDetailkey = query111.order(byDescending: "createdAt").whereKey("BodyType", containedIn: TricepsType)
        
        TricepsDetailkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutDetails") as! String
                        self.TricepArrayDetails.append(load)
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
        
        
        
        let query2 = PFQuery(className: "Workout_Planlist")
        let ArmType = ["Forearms"]
        let armkey = query2.order(byDescending: "createdAt").whereKey("BodyType", containedIn: ArmType)
        
        armkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
                        self.ArmArray.append(load)
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
        
        let query22 = PFQuery(className: "Workout_Planlist")
        let armRepkey = query22.order(byDescending: "createdAt").whereKey("BodyType", containedIn: ArmType)
        
        armRepkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.ArmArrayReps.append(load)
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
        
        let query222 = PFQuery(className: "Workout_Planlist")
        let armDetailskey = query222.order(byDescending: "createdAt").whereKey("BodyType", containedIn: ArmType)
        
        armDetailskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutDetails") as! String
                        self.ArmsArrayDetails.append(load)
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
                self.ArmTableView.reloadData()
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
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ArmTableView.dequeueReusableCell(withIdentifier: "Arms", for: indexPath)
        
        switch(ArmSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = BicepArray[(indexPath as NSIndexPath).row]
            break
        case 1:
            cell.textLabel?.text = TricepArray[(indexPath as NSIndexPath).row]
            break
        case 2:
            cell.textLabel?.text = ArmArray[(indexPath as NSIndexPath).row]
            break
        default:
            break
        }
        return cell
        
    }
    
    @IBAction func ArmList(_ sender: AnyObject) {
        ArmTableView.reloadData()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let BodypartDetails: DetailBodyTableViewController = segue.destination as! DetailBodyTableViewController
        if let selectArrayIndex = (ArmTableView.indexPathForSelectedRow as NSIndexPath?)?.row{
            switch(ArmSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = BicepArray[selectArrayIndex]
                BodypartDetails.Reps = BicepArrayReps[selectArrayIndex]
                BodypartDetails.details = BicepArrayDetails[selectArrayIndex]
            break
            case 1:
                BodypartDetails.label = TricepArray[selectArrayIndex]
                BodypartDetails.Reps = TricepArrayRep[selectArrayIndex]
                BodypartDetails.details = TricepArrayDetails[selectArrayIndex]
            break
            case 2:
                BodypartDetails.label = ArmArray[selectArrayIndex]
                BodypartDetails.Reps = ArmArrayReps[selectArrayIndex]
                BodypartDetails.details = ArmsArrayDetails[selectArrayIndex]
            break
            default:
                break
            }
        }
    }
    
    
    
    
}
