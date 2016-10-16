//
//  MapPinFoodDataBaseViewController.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 10/14/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MapPinFoodDataBaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
     var FoodtableView : FoodTableViewController?
    
    @IBOutlet weak var FoodPinName: UILabel!
    @IBOutlet weak var TableView: UITableView!

    
    var FoodDataCal = [String]()
    var FoodItemData = [String]()
    
    var FoodAnnotationName: String = ""
    
    
    var Fooddatagiven = String()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        
        FoodPinName.text = Fooddatagiven
        
//Marks:- McDonald's
        
        if FoodPinName.text == "McDonald's"{
            let Macquery = PFQuery(className: "FoodMap_DB")
                let Food = ["McDonalds"]
                let Mackey = Macquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
                
                Mackey.findObjectsInBackground(block: {
                    (objects: [PFObject]?, error: Error?) -> Void in
                    
                    if error == nil{
                        if let objects = objects as [PFObject]!
                        {
                            for object in objects
                            {
                                let load = object.value(forKey: "FoodCalories") as! String
                                self.FoodDataCal.append(load)
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
            
            let MacItemquery = PFQuery(className: "FoodMap_DB")
            let MacItemkey = MacItemquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            MacItemkey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodItem") as! String
                            self.FoodItemData.append(load)
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
//Marks:- Chick-fil-A
            
        } else if FoodPinName.text == "Chick-fil-A"{
            let Chickquery = PFQuery(className: "FoodMap_DB")
            let Food = ["Chick-fil-A"]
            let Chickkey = Chickquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            Chickkey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodCalories") as! String
                            self.FoodDataCal.append(load)
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
            
            let ChickItemquery = PFQuery(className: "FoodMap_DB")
            let ChickItemkey = ChickItemquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            ChickItemkey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodItem") as! String
                            self.FoodItemData.append(load)
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
//Marks:- Subway
            
        } else if FoodPinName.text == "Subway"{
            let subquery = PFQuery(className: "FoodMap_DB")
            let Food = ["Subway"]
            let subkey = subquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            subkey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodCalories") as! String
                            self.FoodDataCal.append(load)
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
            
            let subItemquery = PFQuery(className: "FoodMap_DB")
            let subItemkey = subItemquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            subItemkey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodItem") as! String
                            self.FoodItemData.append(load)
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
//Marks:- Arby's
            
        else if FoodPinName.text == "Arby's"{
            let Arbyquery = PFQuery(className: "FoodMap_DB")
            let Food = ["Arby's"]
            let Arbykey = Arbyquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            Arbykey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodCalories") as! String
                            self.FoodDataCal.append(load)
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
            
            let ArbyItemquery = PFQuery(className: "FoodMap_DB")
            let ArbyItemkey = ArbyItemquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            ArbyItemkey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodItem") as! String
                            self.FoodItemData.append(load)
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
    //Marks:- Panda Express

        else if FoodPinName.text == "Panda Express"{
            let Pandaquery = PFQuery(className: "FoodMap_DB")
            let Food = ["Panda Express"]
            let Pandakey = Pandaquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            Pandakey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodCalories") as! String
                            self.FoodDataCal.append(load)
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
            
            let PandaItemquery = PFQuery(className: "FoodMap_DB")
            let PandaItemkey = PandaItemquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            PandaItemkey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodItem") as! String
                            self.FoodItemData.append(load)
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
    //Marks:- Pizza Hut
            
        else if FoodPinName.text == "Pizza Hut"{
            let Pizquery = PFQuery(className: "FoodMap_DB")
            let Food = ["Pizza Hut"]
            let Pizkey = Pizquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            Pizkey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodCalories") as! String
                            self.FoodDataCal.append(load)
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
            
            let PizItemquery = PFQuery(className: "FoodMap_DB")
            let PizItemkey = PizItemquery.order(byDescending: "createdAt").whereKey("FoodPlaces", containedIn: Food)
            
            PizItemkey.findObjectsInBackground(block: {
                (objects: [PFObject]?, error: Error?) -> Void in
                
                if error == nil{
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let load = object.value(forKey: "FoodItem") as! String
                            self.FoodItemData.append(load)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return FoodItemData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = TableView.dequeueReusableCell(withIdentifier: "FoodList", for: indexPath)
        cell.textLabel?.text = FoodItemData[(indexPath as NSIndexPath).row]
        cell.detailTextLabel?.text = FoodDataCal[(indexPath as NSIndexPath).row]
        return cell
    }
    
    
    func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
            self.TableView.reloadData()
            return
        })
        
    }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MapFood"{
            let MapFoodVC: FoodTableViewController = segue.destination as! FoodTableViewController
            
            if let selectedArrayIndex = (TableView.indexPathForSelectedRow as NSIndexPath?)?.row{
                
                MapFoodVC.foodArray = [FoodItemData[selectedArrayIndex]]
                MapFoodVC.foodCalArray = [FoodDataCal[selectedArrayIndex]]
                MapFoodVC.isEditingfood = true
                
            }
        }
    
    }
}
