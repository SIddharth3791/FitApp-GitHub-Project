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
    
    //Core
    var CoreArray = [String]()
    var CoreArrayReps = [String]()
    var CoreArrayDetails = [String]()
    
    //Abs
    var AbsArray = [String]()
    var AbsArrayReps = [String]()
    var AbsArrayDetails = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
     
        let query0 = PFQuery(className: "Workout_Planlist")
        let coreType = ["Core"]
        let runkey = query0.order(byDescending: "createdAt").whereKey("BodyType", containedIn: coreType)
        var messages = [PFObject]()
        runkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutName")  as! String
                        self.CoreArray.append(load)
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
        let CoreRepskey = query00.order(byDescending: "createdAt").whereKey("BodyType", containedIn: coreType)
        
        CoreRepskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutReps")  as! String
                        self.CoreArrayReps.append(load)
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
        let CoreDetailkey = query000.order(byDescending: "createdAt").whereKey("BodyType", containedIn: coreType)
        
        CoreDetailkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutDetails")  as! String
                        self.CoreArrayDetails.append(load)
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
        let AbsType = ["Abs"]
        let Glukey = query1.order(byDescending: "createdAt").whereKey("BodyType", containedIn: AbsType)
        
        Glukey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in

            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutName") as! String
                        self.AbsArray.append(load)
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
        let AbsRepskey = query11.order(byDescending: "createdAt").whereKey("BodyType", containedIn: AbsType)
        
        AbsRepskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in

            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutReps") as! String
                        self.AbsArrayReps.append(load)
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
        let AbsDetailkey = query111.order(byDescending: "createdAt").whereKey("BodyType", containedIn: AbsType)
        AbsDetailkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in

            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutDetails") as! String
                        self.AbsArrayDetails.append(load)
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
                self.Coretableview.reloadData()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Coretableview.dequeueReusableCell(withIdentifier: "Core", for: indexPath)
        
        switch(coreSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = CoreArray[(indexPath as NSIndexPath).row]
            break
        case 1:
            cell.textLabel?.text = AbsArray[(indexPath as NSIndexPath).row]
            break
        default:
            break
        }
        return cell
    }

    @IBAction func coreList(_ sender: AnyObject) {
        
        Coretableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let BodyVC: DetailBodyTableViewController = segue.destination as!
        DetailBodyTableViewController
        
        if let selectedArrayIndex = (Coretableview.indexPathForSelectedRow as NSIndexPath?)?.row{
            switch(coreSegment.selectedSegmentIndex)
            {
            case 0:
                BodyVC.label = CoreArray[selectedArrayIndex]
                BodyVC.Reps = CoreArrayReps[selectedArrayIndex]
                BodyVC.details = CoreArrayDetails[selectedArrayIndex]
                break
            case 1:
                BodyVC.label = AbsArray[selectedArrayIndex]
                BodyVC.Reps = AbsArrayReps[selectedArrayIndex]
                BodyVC.details = AbsArrayDetails[selectedArrayIndex]
                break
            default:
                break
            }
        }
    }
    


    
}
