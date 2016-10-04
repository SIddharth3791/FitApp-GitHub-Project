//
//  AddCaloriesViewController.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 9/15/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//
import Foundation
import UIKit

class AddCaloriesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, ItemChangedDelegate, UIPopoverPresentationControllerDelegate {


    @IBOutlet weak var AllowedMaxCaloriesCount: UILabel!
    @IBOutlet weak var CaloriesConsumed: UILabel!
    @IBOutlet weak var ExerciseLabel: UILabel!
    @IBOutlet weak var RemainingCaloriesConsumedTotal: UILabel!
    
    
    
    //+ AddQuick Buttons
    @IBOutlet weak var QuickAddBreakFast: UIButton!
    @IBOutlet weak var QuickAddLunch: UIButton!
    @IBOutlet weak var QuickAddDinner: UIButton!
    
    // +AddFood Buttons
    @IBOutlet weak var BreakfastFoodAdd: UIButton!
    
    @IBOutlet weak var BreakFastLabel: UILabel!
    @IBOutlet weak var BreakFastCal: UILabel!
    
    //TabelViews
    @IBOutlet weak var BreakfastTable: UITableView!
    
    //Edit Buttons
    @IBOutlet weak var BreakFastEditButton: UIButton!
 
    //PopOver
    @IBOutlet weak var PopOver: UIButton!
    
    var Breakfastfood = [Item(name:"Food1", amount: 000)]
    var exercise =  [Item(name: "exercise 1", amount: 000)]
    var isEditingfood = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateCount()
    }
    
    
    //------------------------@@@@@@@@@@@@@-Break Fast Table View Section-@@@@@@@@@@@@@@@-------------
    
    
    @IBAction func EditBreakfastClicked(_ sender: AnyObject) {
        
        if isEditingfood == true{
            sender.setTitle("Edit", for: UIControlState())
            self.BreakfastTable?.setEditing(false, animated: false)
            isEditingfood = false
            updateCount()
        }
        else{
            sender.setTitle("Done", for: UIControlState())
            self.BreakfastTable?.setEditing(true, animated: false)
            isEditingfood = true
            updateCount()
        }
        self.BreakfastTable.reloadData()
    
    }
    
    
    @IBAction func GetBreakfast(_ sender: UIButton) {
        
        if sender == QuickAddBreakFast{
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "QuickFoodAddViewController") as!AddFoodCaloriesViewController
            
                controller.Ftitle = "BreakFast"
                self.present(controller, animated: true, completion: nil)
        }
    }
  
    @IBAction func AddBreakfast(_ sender: AnyObject) {
        
        var BreakFastL = "Rice"
        Breakfastfood.append(Item(name: BreakFastL, amount: 100))
        self.BreakfastTable.reloadData()
        updateCount()
    }
    
    func updateCount() {
        var foodCalories: Int = 0
        var AllowedCaloriesCount: Int = 2000
        
        AllowedMaxCaloriesCount.text = String(AllowedCaloriesCount)
        for item in Breakfastfood { foodCalories += item.amount}
        CaloriesConsumed.text = String(foodCalories)
        
        var exerciseCalories: Int = 0
        for item in exercise { exerciseCalories += item.amount}
        ExerciseLabel.text = String(exerciseCalories)
        
        RemainingCaloriesConsumedTotal.text = String(AllowedCaloriesCount - foodCalories + exerciseCalories)
        
    }
// confrom ItemchangeProtocal 
    func itemChanged(_ item: Item) {
        updateCount()
    }
    
    
    func itemEditing(_ item: Item) {
        
    }
    
    //Break Fast Tableview Protocals
    func numberOfSectionInTableView(_ tableView: UITableView) -> Int{
        //Food and Excercise
        return 2
    }
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int{
        return section == 0 ? Breakfastfood.count : exercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = (indexPath as NSIndexPath).section == 0
            ? Breakfastfood[(indexPath as NSIndexPath).row]
            : exercise[(indexPath as NSIndexPath).row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreakfastCell") as! BreakfastCell
        
        cell.setup(item, delegate: self)
        
        return cell
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item : Item = Breakfastfood[(sourceIndexPath as NSIndexPath).row]
        Breakfastfood.remove(at: (sourceIndexPath as NSIndexPath).row)
        Breakfastfood.insert(item, at: (destinationIndexPath as NSIndexPath).row)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            Breakfastfood.remove(at: (indexPath as NSIndexPath).row)
            tableView.reloadData()
        }
        
        
    }
    
    
    
 //------------------------@@@@@@@@@@@@@-Break Fast Table View Section-@@@@@@@@@@@@@@@-------------
    @IBAction func GetLunchQuick(_ sender: UIButton) {
        
        if sender == QuickAddLunch{
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "QuickFoodAddViewController") as!AddFoodCaloriesViewController
            
            controller.Ftitle = "Lunch"
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    
//------------------------@@@@@@@@@@@@@-Break Fast Table View Section-@@@@@@@@@@@@@@@-------------
    
    @IBAction func GetDinnerQuick(_ sender: UIButton) {
    
        if sender == QuickAddDinner{
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "QuickFoodAddViewController") as!AddFoodCaloriesViewController
            
            controller.Ftitle = "Dinner"
            self.present(controller, animated: true, completion: nil)
        }

    }
// Marks:- Popover functionality 
    
    @IBAction func PopButtonClicked(_ sender: AnyObject) {
     
        
        self.performSegue(withIdentifier: "ShowFood", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowFood"
        {
            let AddCaloriesVC = segue.destination 
            let Controller = AddCaloriesVC.popoverPresentationController
            
            if Controller != nil{
                Controller?.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
    }
    
    func AddFoodDidFinish(FoodName: String, type: String, controller: FoodNutritionViews) {
        
        BreakFastLabel.text = type
        controller.navigationController?.popViewController(animated: true)
        BreakfastTable.reloadData()
        
    }
    
    
    
}
