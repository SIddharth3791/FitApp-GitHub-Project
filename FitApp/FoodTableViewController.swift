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

    
    //Delegate to delete Rows
    
       var deletePlanetIndexPath: NSIndexPath? = nil
    
    //TableView controller
    @IBOutlet weak var FoodTableTV: UITableView!
    
    
    //Label for caloreis......
    
    @IBOutlet weak var TotalCaloriesLabel: UILabel!
    @IBOutlet weak var caloriesAteLabel: UILabel!
    @IBOutlet weak var CaloriesConsumedInEnd: UILabel!
    //Marks:- TextFeild for Cal
    @IBOutlet weak var CaloriesAteText: UITextField!
    
    @IBOutlet weak var CaloriesConsumedInEndText: UITextField!
    
   
    var VCsegue = false
    var foodArray = [String]()
    var foodCalArray = [String]()
    var isEditingfood = false
    
    

    
    func addFood(newfood: String, newcal: String) {
        foodArray.append(newfood as String)
        foodCalArray.append(newcal as String)
        self.FoodTableTV.reloadData()
        updateCalCountingMethod()
        if isEditingfood == true{
            
            UpdateCountMethodForMap()
        }
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* if isEditingfood == true{
            
            UpdateCountMethodForMap()
        }*/
        //CaloriesConsumedInEndText.isHidden = true
      
       
        //Marks:- Get User cal to consume
        
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
        
        //Marks:- Get User cal ate
        getPreviousCalories()
       // updatecalContingMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

//Marks:- Delete or cancel Food Item entry.
    
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
            deletePlanetIndexPath = indexPath as NSIndexPath?
            let FoodTodelete = foodCalArray[indexPath.row]
            confirmDelete(Food:FoodTodelete)
            FoodTableTV.reloadData()
        }
    }
    
    func confirmDelete(Food: String) {
        let alert = UIAlertController(title: "Delete Food", message: "Are you sure you want to permanently delete?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteFood)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteFood)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func handleDeleteFood(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deletePlanetIndexPath {
            FoodTableTV.beginUpdates()
            
            foodArray.remove(at: indexPath.row)
            foodCalArray.remove(at:indexPath.row)
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            FoodTableTV.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            
            deletePlanetIndexPath = nil
             updateCalCountingMethod()
            FoodTableTV.endUpdates()
        }
    }
    
    func cancelDeleteFood(alertAction: UIAlertAction!) {
        deletePlanetIndexPath = nil
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
    
    func updateCalCountingMethod(){
        
        var DoubleFoodCalArray = 0
 
        for element in foodCalArray{
            DoubleFoodCalArray += Int(element)!
        }
        let AddPastCal = Int(CaloriesAteText.text!)! + DoubleFoodCalArray
        CaloriesAteText.isHidden = true
        
        caloriesAteLabel.text = String(AddPastCal)
        let Caloriesleft = Int(TotalCaloriesLabel.text!)!  - Int(caloriesAteLabel.text!)! 
        CaloriesConsumedInEndText.isHidden = true
        CaloriesConsumedInEnd.text = String(Caloriesleft)
    }

    func UpdateCountMethodForMap()
    {
        

        var DoubleFoodCalArray = 0
        
        for element in foodCalArray{
            DoubleFoodCalArray += Int(element)!
        }
        var pastcal = Int(self.CaloriesAteText.text!)
        let AddPastCal = pastcal! + DoubleFoodCalArray
        CaloriesAteText.isHidden = true
        
        caloriesAteLabel.text = String(AddPastCal)
        let Caloriesleft = Int(TotalCaloriesLabel.text!)!  - Int(caloriesAteLabel.text!)!
        CaloriesConsumedInEndText.isHidden = true
        CaloriesConsumedInEnd.text = String(Caloriesleft)
        
    }

    
    @IBAction func SaveFoodLogButton(_ sender: AnyObject) {
        
        // saving Current user
        let User = PFUser.current()
        User!["FoodCaloriesAte"] = caloriesAteLabel.text
        User!["FoodCaloriesRemaining"] = CaloriesConsumedInEnd.text
        User?.saveInBackground()
        
    }
    
    
    func getPreviousCalories()
    {
        let findCalAteData: PFQuery = PFQuery(className: "_User")
        findCalAteData.whereKey("username", equalTo: PFUser.current()!.username!)
        findCalAteData.whereKeyExists("FoodCaloriesAte")
        findCalAteData.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let oldCalLoad = object.value(forKey: "FoodCaloriesAte") as! String
                        self.CaloriesAteText.text = oldCalLoad
                    }
                }
            }
        })
        
        let findCalRemainData: PFQuery = PFQuery(className: "_User")
        findCalRemainData.whereKey("username", equalTo: PFUser.current()!.username!)
        findCalRemainData.whereKeyExists("FoodCaloriesRemaining")
        findCalRemainData.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let oldCalLoad = object.value(forKey: "FoodCaloriesRemaining") as! String
                        self.CaloriesConsumedInEndText.text = oldCalLoad
                    }
                }
            }
        })
        
    }
    
      @IBAction  func unwindForSegueCalCounter(_ unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    

}
