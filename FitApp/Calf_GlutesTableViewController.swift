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
    
    //Calf
    var CalfArray = [String]()
    var CalfArrayReps = [String]()
    var CalfArrayDetails = [String]()
    
    //Glutes
    var GlutesArray = [String]()
    var GlutesArrayReps = [String]()
    var GlutesArrayDetails = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query0 = PFQuery(className: "Workout_Planlist")
        let CalfType = ["Calf"]
        let runkey = query0.order(byDescending: "createdAt").whereKey("BodyType", containedIn: CalfType)
        var messages = [PFObject]()
        runkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
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
        })
        
        
        let query00 = PFQuery(className: "Workout_Planlist")
        let CalfRepskey = query00.order(byDescending: "createdAt").whereKey("BodyType", containedIn: CalfType)
        
        CalfRepskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.CalfArrayReps.append(load)
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
        let CalfDetailskey = query000.order(byDescending: "createdAt").whereKey("BodyType", containedIn: CalfType)
        
        CalfDetailskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutDetails") as! String
                        self.CalfArrayDetails.append(load)
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
        let GluType = ["Glute"]
        let Glukey = query1.order(byDescending: "createdAt").whereKey("BodyType", containedIn: GluType)
        
        Glukey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
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
        })
        
        let query11 = PFQuery(className: "Workout_Planlist")
        let GluRepskey = query11.order(byDescending: "createdAt").whereKey("BodyType", containedIn: GluType)
        
        GluRepskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.GlutesArrayReps.append(load)
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
        let GluDetailskey = query111.order(byDescending: "createdAt").whereKey("BodyType", containedIn: GluType)
        
        GluDetailskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutDetails") as! String
                        self.GlutesArrayDetails.append(load)
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
                self.Calf_GluTableView.reloadData()
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Calf_GluTableView.dequeueReusableCell(withIdentifier: "Calf&Glutes", for: indexPath)
        
        switch(CFSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = CalfArray[(indexPath as NSIndexPath).row]
            break
        case 1:
            cell.textLabel?.text = GlutesArray[(indexPath as NSIndexPath).row]
            break
        default:
            break
        }
        return cell
        
    }
    
    @IBAction func CGList(_ sender: AnyObject) {
        
        Calf_GluTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let BodypartDetails: DetailBodyTableViewController = segue.destination as! DetailBodyTableViewController
        if let selectArrayIndex = (Calf_GluTableView.indexPathForSelectedRow as NSIndexPath?)?.row{
            switch(CFSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = CalfArray[selectArrayIndex]
                BodypartDetails.Reps = CalfArrayReps[selectArrayIndex]
                BodypartDetails.details = CalfArrayDetails[selectArrayIndex]
                break
            case 1:
                BodypartDetails.label = GlutesArray[selectArrayIndex]
                BodypartDetails.Reps = GlutesArrayReps[selectArrayIndex]
                BodypartDetails.details = GlutesArrayDetails[selectArrayIndex]
                break
                
            default:
                break
            }
        }
    }
}
