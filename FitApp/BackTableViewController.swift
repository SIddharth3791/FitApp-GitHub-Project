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
    
    //Upper
    var UpperBackArray = [String]()
    var UpperBackArrayReps = [String]()
    
    //Lower
    var LowerBackArray = [String]()
    var LowerBackArrayReps = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query0 = PFQuery(className: "Workout_Planlist")
        let uBackType = ["Upper Back"]
        let runkey = query0.order(byDescending: "createdAt").whereKey("BodyType", containedIn: uBackType)
        
        runkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutName")  as! String
                        self.UpperBackArray.append(load)
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
        let UpperBackRepskey = query00.order(byDescending: "createdAt").whereKey("BodyType", containedIn: uBackType)
        
        UpperBackRepskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutReps")  as! String
                        self.UpperBackArrayReps.append(load)
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
        let lBackType = ["Lower Back"]
        let Glukey = query1.order(byDescending: "createdAt").whereKey("BodyType", containedIn: lBackType)
        
        Glukey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutName") as! String
                        self.LowerBackArray.append(load)
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
        let lowerBackRepkey = query11.order(byDescending: "createdAt").whereKey("BodyType", containedIn: lBackType)
        
        lowerBackRepkey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.object(forKey: "WorkoutReps") as! String
                        self.LowerBackArrayReps.append(load)
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
                self.BackTableView.reloadData()
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = BackTableView.dequeueReusableCell(withIdentifier: "Back", for: indexPath)
        
        switch(BackSegment.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = UpperBackArray[(indexPath as NSIndexPath).row]
            break
        case 1:
            cell.textLabel?.text = LowerBackArray[(indexPath as NSIndexPath).row]
            break
        default:
            break
        }
        return cell
    }
    
    @IBAction func BackList(_ sender: AnyObject) {
        
        BackTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let BodyVC: DetailBodyTableViewController = segue.destination as!
        DetailBodyTableViewController
       
         if let selectedArrayIndex = (BackTableView.indexPathForSelectedRow as NSIndexPath?)?.row{
            switch(BackSegment.selectedSegmentIndex)
                {
                case 0:
                BodyVC.label = UpperBackArray[selectedArrayIndex]
                BodyVC.Reps = UpperBackArrayReps[selectedArrayIndex]
                break
            case 1:
                BodyVC.label = LowerBackArray[selectedArrayIndex]
                BodyVC.Reps = LowerBackArrayReps[selectedArrayIndex]
                break
            default:
                break
            }
            }
    }

}
