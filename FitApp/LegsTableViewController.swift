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

    //quads
    var QuadsArray = [String]()
    var QuadArrayReps = [String]()
    
    //Hamstring
    var HamstringArray = [String]()
    var HamStringArrayReps = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let query0 = PFQuery(className: "Workout_Planlist")
        let QuadsType = ["Quads"]
        let runkey = query0.order(byDescending: "createdAt").whereKey("BodyType", containedIn: QuadsType)
        
        runkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
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
        })
        
        let query00 = PFQuery(className: "Workout_Planlist")
        let QuadsRepkey = query00.order(byDescending: "createdAt").whereKey("BodyType", containedIn: QuadsType)
        
        QuadsRepkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.QuadArrayReps.append(load)
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
        let HamStringsType = ["HamStrings"]
        let hamkey = query1.order(byDescending: "createdAt").whereKey("BodyType", containedIn: HamStringsType)
        
        hamkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutName") as! String
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
        })
        
        let query11 = PFQuery(className: "Workout_Planlist")
        let hamRepskey = query11.order(byDescending: "createdAt").whereKey("BodyType", containedIn: HamStringsType)
        
        hamRepskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "WorkoutReps") as! String
                        self.HamStringArrayReps.append(load)
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
                self.legTableView.reloadData()
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = legTableView.dequeueReusableCell(withIdentifier: "legs", for: indexPath)
        
        switch(legSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = QuadsArray[(indexPath as NSIndexPath).row]
            break
        case 1:
            cell.textLabel?.text = HamstringArray[(indexPath as NSIndexPath).row]
            break
        default:
            break
        }
        return cell
        
    }
    @IBAction func LegList(_ sender: AnyObject) {
        
        legTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let BodypartDetails: DetailBodyTableViewController = segue.destination as! DetailBodyTableViewController
        if let selectArrayIndex = (legTableView.indexPathForSelectedRow as NSIndexPath?)?.row{
            switch(legSegment.selectedSegmentIndex)
            {
            case 0:
                BodypartDetails.label = QuadsArray[selectArrayIndex]
                BodypartDetails.Reps = QuadArrayReps[selectArrayIndex]
                break
            case 1:
                BodypartDetails.label = HamstringArray[selectArrayIndex]
                BodypartDetails.Reps = HamStringArrayReps[selectArrayIndex]
                break
            
            default:
                break
            }
        }
    }


    
}
