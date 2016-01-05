//
//  WODTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/21/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class WODTableViewController:UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var MySegmentedControl: UISegmentedControl!
    @IBOutlet weak var WodTableView: UITableView!
    
    var GirlArray = [String]()
    var HeroArray = [String]()
    var HybridArray = [String]()
    var OpenArray = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Parse Query to populate table cell
        let query = PFQuery(className: "CF_WOD")
        let runkey = query.orderByAscending("WorkOut_Name")
        runkey.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?)-> Void in
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.objectForKey("WorkOut_Name") as! String
                        self.GirlArray.append(load)
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
        dispatch_async(dispatch_get_main_queue(), { self.WodTableView.reloadData()
            return
        })
    }
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // Marks: display rows depening on data
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnvaule = 0
        
        switch(MySegmentedControl.selectedSegmentIndex)
        {
            case 0:
                returnvaule = GirlArray.count
                break
            case 1:
                returnvaule = HeroArray.count
                break
            case 2:
                returnvaule = HybridArray.count
                break
                case 3:
                    returnvaule = OpenArray.count
                break
            default:
                break
        
        }
        return returnvaule

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
    
        let cell = WodTableView.dequeueReusableCellWithIdentifier("CFWOD", forIndexPath: indexPath)
        
        switch(MySegmentedControl.selectedSegmentIndex)
        {
            case 0:
                cell.textLabel!.text = GirlArray[indexPath.row]
                break
            case 1:
                cell.textLabel!.text  = HeroArray[indexPath.row]
                break
            case 2:
                cell.textLabel!.text = HybridArray[indexPath.row]
                break
            case 3:
                cell.textLabel!.text = OpenArray[indexPath.row]
                break
            default:
                break
            
        }
           return cell
    }
    
    
   
    
    @IBAction func CFListControl(sender: AnyObject)
    {
        WodTableView.reloadData()

    }
    
}


/**PFQueryTableViewController {

    struct object {
        var sectionName : String!
        var sectionObjects: [String]!
    }
    
    
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "CF_WOD")
        if [self.objects].count == 0 {
            query.cachePolicy = PFCachePolicy.CacheElseNetwork
        }
        query.whereKey("Workout_Type", equalTo: "The Benchmark Girls")
       // query.whereKey("Workout_Type", equalTo: "The New Girls")
        return query
    }
    
    
    
    //Marks: Function for populating table
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell?{
        
        let cell =  tableView.dequeueReusableCellWithIdentifier("CellWod", forIndexPath: indexPath) as! WODTableViewCell
        cell.titleLabel.text = object?.objectForKey("WorkOut_Name") as? String
        
        return cell
    }
    //Marks: Function for Height of Rows
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row + 1 > self.objects?.count
        {
            return 44
        }
        else
        {
        let height = super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        return height
        }
    }
    
    //Marks: Function for load page for more WODs
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row + 1 > self.objects?.count
        {
            self.loadNextPage()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        }
        else
        {
            self.performSegueWithIdentifier("ShowWodDetails", sender: self)
        }
        
        
    }
    
    // Marks: Function to show number of section for table view
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    // Marks: Function to show title of differnet section of table view
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "The Benchmark girls"
        }
        else
        {
            return "The New Girls"
        }
    }

 }**/
