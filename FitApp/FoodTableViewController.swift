//
//  FoodTableViewController.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 9/28/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FoodTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate{

    //TableView controller
    @IBOutlet weak var FoodTableTV: UITableView!
    
    
    //Label for caloreis......
    
    @IBOutlet weak var TotalCaloriesLabel: UILabel!
    @IBOutlet weak var caloriesAteLabel: UILabel!
    @IBOutlet weak var CaloriesConsumedInEnd: UILabel!
    
    @IBOutlet weak var foodEditingButton: UIButton!
    
    var foodArray = [String]()
    var foodCalArray = [String]()
    var isEditingfood = false
    
    func addFood(newfood: String, newcal: String) {
        foodArray.append(newfood as String)
        foodCalArray.append(newcal as String)
        self.FoodTableTV.reloadData()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodArray =  ["Pizza"]
        foodCalArray = ["345"]
        
        let findTotalCaloriesData: PFQuery = PFQuery(className: "_User")
        findTotalCaloriesData.whereKey("username", equalTo: PFUser.current()!.username!)
        findTotalCaloriesData.whereKeyExists("DailyCalories")
        findTotalCaloriesData.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let UserCalLoad = object.value(forKey: "DailyCalories") as! String
                        self.TotalCaloriesLabel.text = UserCalLoad
                    }
                }
            }
        })
    

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updatecalContingMethod()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

  // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodArray.count
    
    }

    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Breakfast", for: indexPath)

        let rowNumber = (indexPath as NSIndexPath).row
        let food = foodArray[rowNumber]
        let cal = foodCalArray[rowNumber]
        cell.textLabel!.text = food
        cell.detailTextLabel?.text = cal
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            foodCalArray.remove(at: indexPath.row)
           FoodTableTV.reloadData()
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFood"{
        let FTView: FoodNutritionViews = segue.destination as! FoodNutritionViews
        FTView.FoodtableView = self
        
        } else if segue.identifier == "QuickAdd"
        {
            let AddCal: AddFoodCaloriesViewController = segue.destination as! AddFoodCaloriesViewController
            AddCal.FoodtableView = self
        }
    }

    //Marks:- Update count of calories
    func updatecalContingMethod(){
        
        var DoubleFoodCalArray = 0
        
        for element in foodCalArray{
            DoubleFoodCalArray += Int(element)!
        }
        
        caloriesAteLabel.text = String(DoubleFoodCalArray)
        let Caloriesleft = Int(TotalCaloriesLabel.text!)! - DoubleFoodCalArray
        CaloriesConsumedInEnd.text = String(Caloriesleft)
        
    }
    
    //Marks:- Edit Button and change table view
    @IBAction func EditButtonClicked(_ sender: AnyObject) {
        
        if isEditingfood == true{
            sender.setTitle("Edit", for: UIControlState())
            self.FoodTableTV?.setEditing(false, animated: false)
            isEditingfood = false
            updatecalContingMethod()
        }
        else{
            sender.setTitle("Done", for: UIControlState())
            self.FoodTableTV?.setEditing(true, animated: false)
            isEditingfood = true
            updatecalContingMethod()
        }
        self.FoodTableTV.reloadData()
        
    }
    
    
    
    @IBAction  func unwindForSegueCalCounter(_ unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    

}
