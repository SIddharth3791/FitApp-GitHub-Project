//
//  FoodTableViewController.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 9/28/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit

class FoodTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate{

    //TableView controller
    @IBOutlet weak var FoodTableTV: UITableView!
    
    
    //Label for caloreis......
    
    @IBOutlet weak var TotalCaloriesLabel: UILabel!
    @IBOutlet weak var caloriesAteLabel: UILabel!
    @IBOutlet weak var CaloriesConsumedInEnd: UILabel!
    
    
    var foodArray = [String]()
    var foodCalArray = [String]()
    
    func addFood(newfood: String, newcal: String) {
        foodArray.append(newfood as String)
        foodCalArray.append(newcal as String)
        self.FoodTableTV.reloadData()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodArray =  ["Pizza", "Brown rice", "Whole Milk"]
        foodCalArray = ["345", "450","550"]
        
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

        let rowNumber = indexPath.row
        let food = foodArray[rowNumber]
        let cal = foodCalArray[rowNumber]
        cell.textLabel!.text = food
        cell.detailTextLabel?.text = cal
        return cell
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

    

    

}
