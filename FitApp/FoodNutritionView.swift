//
//  FoodNutritionView.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 9/22/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

class FoodNutritionViews: UIViewController, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate ,UIPopoverPresentationControllerDelegate {
    
    
//Marks:- TextFeild EndEditing Action-------------------->
    
    @IBAction func FoodNameTextClicked(_ sender: AnyObject) {
    }
    @IBAction func FoodCalTextClicked(_ sender: AnyObject) {
    }
    @IBAction func FoodFatsTextClicked(_ sender: AnyObject) {
    }
    
    @IBAction func FoodProteinTextClicked(_ sender: AnyObject) {
    }
    
    @IBAction func FoodCarbsTextClicked(_ sender: AnyObject) {
    }
    @IBAction func FoodCountTextClicked(_ sender: AnyObject) {
    }
    
    var FoodtableView : FoodTableViewController?
    
//Marks:- Food Detail Txt----------------->
    

    @IBOutlet weak var FoodNameText: UITextField!
    
    @IBOutlet weak var FoodCalText: UITextField!
    
    @IBOutlet weak var FoodFatsText: UITextField!
    
    @IBOutlet weak var FoodProteinText: UITextField!
    
    @IBOutlet weak var FoodCarbsText: UITextField!
    
    @IBOutlet weak var FoodCountText: UITextField!
    
    @IBOutlet weak var ServingSizeText: UITextField!
 
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    //Marks:-   Table View controller----------->
    
    @IBOutlet weak var FoodTableView: UITableView!
    
    @IBOutlet weak var FoodSearchBar: UISearchBar!
    
    var SearchResult = [String]()
    var FoodFat = [String]()
    var FoodProtein = [String]()
    var FoodCarbs = [String]()
    var FoodCal = [String]()
    var FoodSize = [String]()
    var FoodIDList = [Int]()
    
    
    //Marks:- Detail View controller----------->
    @IBOutlet weak var SizeLabel: UILabel!
    @IBOutlet weak var FatsLabel: UILabel!
    @IBOutlet weak var ProteinLabel: UILabel!
    @IBOutlet weak var CarbsLabel: UILabel!
    @IBOutlet weak var FoodNameLabel: UILabel!
    @IBOutlet weak var CalLabel: UILabel!
    
    @IBOutlet weak var EnterFoodTextFeild: UITextField!
    
    @IBOutlet weak var EnterFoodCall: UITextField!
    
    
    var FoodName = String()
    var Fats = String()
    var Proteins = String()
    var Carbs = String()
    var Cal = String()
    var Size = String()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CalLabel.text = Cal
        FoodNameLabel.text = FoodName
        FatsLabel.text = Fats
        ProteinLabel.text = Proteins
        CarbsLabel.text = Carbs
        SizeLabel.text = Size
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //----------------------working with Textfield--------------------
    
    
    @IBAction func CalculateButton(_ sender: UIButton) {
        
        
        
        //get serving size
        let SizeCount = Double(ServingSizeText.text!)
        
        
        
        // get Double value of Nutrition
        let Fatupdated = Double(FoodFatsText.text!)
        let CarbsUpdated = Double(FoodCarbsText.text!)
        let ProteinUpdated = Double(FoodProteinText.text!)
        let CalUpdated = Double(FoodCalText.text!)

        
        
        //Update Fat label with total Nutrition
        let TotalFats: Double =  (SizeCount! * Fatupdated!)
        FoodFatsText.text = "\(TotalFats)"
        
        //Update Carbs label with total Nutrition
        
        let TotalCarbs: Double = (SizeCount! * CarbsUpdated!)
        FoodCarbsText.text = "\(TotalCarbs)"
        
        //Update Protein label with total Nutrition
        let Totalprotein: Double = (SizeCount! * ProteinUpdated!)
        FoodProteinText.text = "\(Totalprotein)"
        
        //Update Cal label with total Nutrition
        let TotalCal: Double = (SizeCount! * CalUpdated!)
        let IntTotalCall = Int(TotalCal)
        FoodCalText.text = "\(IntTotalCall)"
        
    }
    
    @IBAction func refreshButtonTapped(_ sender: AnyObject) {
        
        ServingSizeText.text = "1.0"
        
        let FoodName:String = FoodNameText.text!
        let Fatsquery = PFQuery(className: "FoodDB")
        Fatsquery.order(byDescending: "createdAt").whereKey("FoodName", contains: FoodName)
        //*****
        Fatsquery.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "FoodFats") as! String
                        self.FoodFatsText.text = load
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
        
        let Proteinquery = PFQuery(className: "FoodDB")
        let Prokey = Proteinquery.order(byDescending: "createdAt").whereKey("FoodName", contains: FoodName)
        Proteinquery.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "FoodProtein") as! String
                        self.FoodProteinText.text = load
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
        
        let Carbsquery = PFQuery(className: "FoodDB")
        let Carbskey = Carbsquery.order(byDescending: "createdAt").whereKey("FoodName", contains: FoodName)
        Carbskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "FoodCarbs") as! String
                        self.FoodCarbsText.text = load
                        
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
        
        let Calquery = PFQuery(className: "FoodDB")
        let Calskey = Calquery.order(byDescending: "createdAt").whereKey("FoodName", contains: FoodName)
        Calskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "FoodCal") as! String
                        self.FoodCalText.text = load
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
    
    @IBAction func AddFoodButton(_ sender: UIButton) {
        
        var newFood: String = FoodNameText.text!
        let NewFoodCal: String = FoodCalText.text!
        
        if newFood.utf16.count < 1 {
            
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
            
            
        }
        
        self.FoodtableView?.addFood(newfood: newFood, newcal: NewFoodCal)
        NSLog("----------->\(newFood)")
        //self.performSegue(withIdentifier: "AddFood", sender: UIButton.self)
        
        self.presentingViewController?.dismiss(animated:true, completion: nil)
        
    }
    
    func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
            return
        })
    }
    
    @IBAction func SearchFodDatabase(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "SearchFood", sender: self)
        
        
    }

        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            
            return .none
        }
    
    //-----------------Table and Search Bar functions -----------------------
    
    //Marks:- Tableview functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return SearchResult.count
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let Cell = FoodTableView.dequeueReusableCell(withIdentifier: "ShowFood", for: indexPath) 
        Cell.textLabel?.text = SearchResult[indexPath.row]
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
        
        FoodNameText.text = SearchResult[(indexPath as NSIndexPath).row]
        FoodCalText.text = FoodCal[(indexPath as NSIndexPath).row]
        FoodFatsText.text = FoodFat[(indexPath as NSIndexPath).row]
        FoodProteinText.text = FoodProtein[(indexPath as NSIndexPath).row]
        FoodCarbsText.text = FoodCarbs[(indexPath as NSIndexPath).row]
        FoodCountText.text = FoodSize[(indexPath as NSIndexPath).row]
        FoodNameText.endEditing(true)
        FoodCalText.endEditing(true)
        FoodFatsText.endEditing(true)
        FoodProteinText.endEditing(true)
        FoodCarbsText.endEditing(true)
        FoodCountText.endEditing(true)
        FoodTableView.isHidden = true
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    
    //Marks:- SearchBar functions
    
   public func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //FoodSearchBar.resignFirstResponder()
        
        let Query = PFQuery(className: "FoodDB")
        Query.whereKey("FoodName", contains: searchBar.text)
        
        
        Query.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error != nil
            {
                let myAlert = UIAlertController(title:"Alert", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK",style: UIAlertActionStyle.default)
                myAlert.addAction(okAction)
                self.present(myAlert,animated:true,completion:nil)
                return
            }
            if let objects = objects as [PFObject]!
            {
                self.SearchResult.removeAll(keepingCapacity: false)
                
                for object in objects
                {
                    let FoodName = object.object(forKey: "FoodName")
                    self.SearchResult.append(FoodName as! String)
                }
            }
            DispatchQueue.main.async(execute: {
                self.FoodTableView.reloadData()
                self.FoodSearchBar.resignFirstResponder()
            })
            
        })
        
        let Fatsquery = PFQuery(className: "FoodDB")
        Fatsquery.order(byDescending: "createdAt").whereKey("FoodName", contains: searchBar.text)
        //*****
        print(searchBar.text)
        Fatsquery.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "FoodFats") as! String
                        self.FoodFat.append(load)
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
        
        let Proteinquery = PFQuery(className: "FoodDB")
        let Prokey = Proteinquery.order(byDescending: "createdAt").whereKey("FoodName", contains: searchBar.text)
        Proteinquery.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "FoodProtein") as! String
                        self.FoodProtein.append(load)
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
        
        let Carbsquery = PFQuery(className: "FoodDB")
        let Carbskey = Carbsquery.order(byDescending: "createdAt").whereKey("FoodName", contains: searchBar.text)
        Carbskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "FoodCarbs") as! String
                        self.FoodCarbs.append(load)
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
        
        let Calquery = PFQuery(className: "FoodDB")
        let Calskey = Calquery.order(byDescending: "createdAt").whereKey("FoodName", contains: searchBar.text)
        Calskey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "FoodCal") as! String
                        self.FoodCal.append(load)
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
        
        let sizequery = PFQuery(className: "FoodDB")
        let Sizekey = sizequery.order(byDescending: "createdAt").whereKey("FoodName", contains: searchBar.text)
        Sizekey.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil{
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        let load = object.value(forKey: "ServingSize") as! String
                        self.FoodSize.append(load)
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
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

            if segue.identifier == "FoodAdded"{
            let NutritionVC: FoodNutritionViews = segue.destination as!
            FoodNutritionViews
            
            if let selectedArrayIndex = (FoodTableView.indexPathForSelectedRow as NSIndexPath?)?.row{
                
                NutritionVC.FoodName = SearchResult[selectedArrayIndex]
                NutritionVC.Fats = FoodFat[selectedArrayIndex]
                NutritionVC.Proteins = FoodProtein[selectedArrayIndex]
                NutritionVC.Carbs = FoodCarbs[selectedArrayIndex]
                NutritionVC.Cal = FoodCal[selectedArrayIndex]
                NutritionVC.Size = FoodSize[selectedArrayIndex]
                
            }
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        FoodSearchBar.resignFirstResponder()
        FoodSearchBar.text = ""
    }

        
}
  

